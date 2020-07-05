#include "malloc.h"
#include "process.h"

// free block struct
typedef struct free_list_
{
    uint64_t size;
    int free;
    void *payload;

    struct free_list_ *next;
    struct free_list_ *prev;
} free_list;

// initialze free linked list
free_list *head = NULL;

// heap info flag
int if_heap_info = 0;

// take care of alignment
#define ALIGN(sz) (((sz) + (8 - 1)) & ~(8 - 1))
#define METADATA ALIGN(sizeof(free_list))
#define DEFAULT_EXPAND PAGESIZE
#define MY_INT_MAX 4294967295

// get the header from payload
free_list *get_header(void *payload)
{
    return (free_list *) (uintptr_t)payload - METADATA;
}

// get the payload from header
void *get_payload(void *header_ptr)
{
    return (void *) (uintptr_t)header_ptr + METADATA;
}

// search free list for a block that fits `sz`
free_list *search_block(uint64_t sz)
{
    //initialize iterator
    free_list *current = head;

    // search for free block
    while (current != NULL)
    {
        // if free block is found
        if (current->size >= sz && current->free == 0)
        {
            return current;
        }
        current = current->next;
    }

    // if no free block was found
    return NULL;
}

// append block to our free list
void append_block(void *block)
{
    free_list *temp = (free_list *)block;

    temp->free = 0;

    // initialize pointers
    temp->next = NULL;
    temp->prev = NULL;

    // when we need to update the head
    if (head == NULL || (uintptr_t) head > (uintptr_t) temp)
    {
        if (head != NULL)
        {
            head->prev = temp;
        }
        
        temp->next = head;

        head = temp;
    }
    else
    {
        // initialize iterator
        free_list *current = head;

        while (current->next != NULL && (uintptr_t) current->next < (uintptr_t)temp)
        {
            current = current->next;
        }

        temp->next = current->next;
        current->next = temp;
    }
}

// split block to get the memory we need and release the surplus
void split(uint64_t new_sz, uint64_t block_size, void *new_block)
{
    free_list *temp = (free_list *) new_block;

    // get the end of our memory block
    void *new_ptr = (void *) ((uintptr_t) new_block + new_sz);

    // if a block, when split, creates a free-list node that is too small to be properly typecast,
    // it is okay to just use the entire free block for the allocation
    if ((block_size - new_sz) < METADATA)
    {
        return;
    }

    // if there's enough space, initialize values for the next block
    free_list *new_free_list = (free_list *) new_ptr;

    // set size
    new_free_list->size = block_size - new_sz;

   
    // update size of current block
    temp->size = new_sz;
    
    // set occupied flag
    new_free_list->free = 0;

    // append the new block to our free list
    append_block(new_free_list);
}

// remove block from our free list
void remove_block(void *block)
{
    free_list *temp = (free_list *)block;

    // if this block is the head
    if (temp->prev == NULL)
    {
        if (temp->next != NULL)
        {
            // set head to be the next node
            head = temp->next;

            // remove the node
            temp->next->prev = NULL;
        }
        else
        {
            // list is empty
            head = NULL;
        }

    }
    else
    {
        if (temp->next != NULL)
        {
            // node is in the middle
            temp->prev->next = temp->next;

            temp->next->prev = temp->prev;
        }
        else
        {
            // node is at the end
            temp->prev->next = NULL;
        }
    }
}

// malloc(sz):
// allocates sz bytes of uninitialized memory and returns a pointer to the allocated memory
// if sz == 0, then malloc() either returns NULL or a unique pointer value that can be
// successfully passed to a later free
// the pointer should be aligned to 8 bytes
void * malloc(uint64_t sz)
{
    // if sz == 0, then malloc() either returns NULL
    if (sz <= 0)
    {
        return NULL;
    }

    // check for overflow
    if ((METADATA > 0) && (sz > MY_INT_MAX - METADATA))
    {
        /* Oh no, overflow */
        return NULL;
    }

    // keep stock of metadata: header metadata, sz
    // make sure to align
    uint64_t new_sz = ALIGN(sz + METADATA);

    // search for a free block to accomodate sz
    free_list *new_block = search_block(new_sz);

    //  If a block is not found, the heap is expanded and added to the free list in some way.
    if (new_block == NULL)
    {
        uint64_t expand_sz = 0;

        if (new_sz > DEFAULT_EXPAND)
        {
            expand_sz = new_sz; 
        }
        else
        {
            expand_sz = ALIGN(DEFAULT_EXPAND);
        }

        // allocate more space
        void *temp_block = (void *)new_block;

        temp_block = (void *) sys_sbrk(expand_sz);
        if (temp_block == (void *)-1)
        {
            return NULL;
        }

        new_block = (free_list *)temp_block;

        // add this space to our free list
        append_block(new_block);

        // set size
        new_block->size = expand_sz;

        // don't account for heap info data
        if (if_heap_info == 0)
        {
            // set free flag
            new_block->free = 1;
        }

        // set payload
        new_block->payload = get_payload(new_block);

        // split block to get the memory we need and release the surplus
        split(new_sz, new_block->size, new_block);

        // if (if_heap_info == 0)
        // {
        //     // update num_allocs
        //     num_allocs++;
        // }

        // return payload
        return get_payload(new_block);
    }

    //if enough space is found

    // don't account for heap info data
    if (if_heap_info == 0)
    {
        // set free flag
        new_block->free = 1;
    }

    // set payload
    new_block->payload = get_payload(new_block);

    // split block to get the memory we need and release the surplus
    split(new_sz, new_block->size, new_block);

    // if (if_heap_info == 0)
    // {
    //     // update num_allocs
    //     num_allocs++;
    // }

    // return payload
    return get_payload(new_block);
}


// calloc(num, sz):
// allocates memory of an array of num elements of size sz bytes each and returns a pointer 
// to the allocated array. The memory is set to 0. if num or sz is equal to 0, then calloc
// returns NULL or a unique pointer value that can be successfully passed to a later free
// calloc also checks for size overflow caused by num*sz
// returns NULL on failure
void * calloc(uint64_t num, uint64_t sz)
{
    // initialize ptr
    void* ptr = NULL;

    // if num or sz is equal to 0, then calloc returns NULL
    if (num == 0 || sz == 0)
    {
        return NULL;
    }
     
    // check for overflow
    if ((sz > 0) && (num > MY_INT_MAX/sz))
    {
        /* Oh no, overflow */
        ptr = NULL;
    }
    else
    {
        // allocates memory of an array of num elements of size sz bytes
        ptr = malloc(num * sz);
    }

    if (ptr) 
    {
        // The memory is set to 0
        memset(ptr, 0, num * sz);
    }

    // returns a pointer to the allocated array
    return ptr;
}

// free(ptr)
// the free function frees the memory space pointed to by ptr, which must have been returned
// by a previous call to malloc or realloc, or if free has already been called before, then
// undefined behavior occurs
// if ptr == NULL, then no operation happens
void free(void * ptr)
{
    // if ptr == NULL, then no operation happens
    if (ptr == NULL)
    {
        return;
    }

    free_list *current = head;

    while (current)
    {
        if (current->payload == ptr && current->free == 1)
        {
            // set free flag
            current->free = 0;

            return;
        }
        current = current->next;
    }
}

// realloc(ptr, sz)
// realloc changes the size of the memory block pointed to by ptr to size bytes.
// the contents will be unchanged in the range from the start of the region up to the
// minimum of the old and new sizes
// if the new size is larger than the old size, the added memory will not be initialized
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz)
{
    // if ptr is NULL
    if (ptr == NULL)
    {
        // then the call is equivalent to malloc(size) for all values of size
        void *temp = malloc(sz);

        return temp;
    }

    // if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
    if (sz == 0 && ptr != NULL)
    {
        free(ptr);

        return NULL;
    }

    // let's get the header, we will use it to get thw size of the block
    free_list *header = get_header(ptr);

    // we have to check that we are expanding the block
    if (sz < header->size)
    {
        return ptr;
    }

    // check for overflow
    if ((METADATA > 0) && (sz > MY_INT_MAX - METADATA))
    {
        /* Oh no, overflow */
        return NULL;
    }

    // what is the new size we require? sz; metadata
    uint64_t new_sz = ALIGN(sz + METADATA);

    // initialize new location
    free_list *new_loc = malloc(sz);
    if (new_loc == NULL)
    {
        return NULL;
    }

    // move data over
    memcpy(new_loc, ptr, header->size);

    // free current ptr
    free(ptr);

    return new_loc;
}


// coalesce adjacent blocks of free memory together into a single block.
void defrag()
{
    // initialize iterator
    free_list *current = head;

    while (current != NULL)
    {
        // (((uintptr_t)current + current->size) == (uintptr_t)current->next)
        if (current->free == 0 && current->next && current->next->free == 0)
        {
            if (current->prev != NULL && current->prev->free == 0)
            {
                // add up sizes
                current->prev->size += current->size;

                // remove current block
                //remove_block(current);
            }
            else 
            {
                uint64_t next_sz = current->next->size;

                // coalesce with current

                // add up size
                current->size += next_sz;

                // remove next block
                //remove_block(current->next);
            }
        }
        current = current->next;
    }
}


/* function adapted with guidance from https://www.youtube.com/watch?v=7h1s2SojIRw */

// swap two elements 
void swap(long* a, long* b) 
{ 
    long t = *a; 
    *a = *b; 
    *b = t; 
}

// swap two elements 
void ptr_swap(void** a, void** b) 
{ 
    void* t = *a; 
    *a = *b; 
    *b = t; 
}

/* function adapted with guidance from https://www.youtube.com/watch?v=7h1s2SojIRw */

int partition (long arr[], int low, int high, void**ptr_arr) 
{ 
    // pivot
    long pivot = arr[high];   

    // Index of smaller element 
    int i = (low - 1);  
  
    for (int j = low; j <= high- 1; j++) 
    { 
        // If current element is bigger than the pivot 
        if (arr[j] > pivot) 
        { 
            // increment index of smaller element 
            i++;    
            swap(&arr[i], &arr[j]); 

            // swap ptr array as well
            ptr_swap(&ptr_arr[i], &ptr_arr[j]);
        } 
    } 
    swap(&arr[i + 1], &arr[high]); 

    // swap ptr array as well
    ptr_swap(&ptr_arr[i+1], &ptr_arr[high]);

    return (i + 1); 
} 

/* function adapted with guidance from https://www.youtube.com/watch?v=7h1s2SojIRw */

void quickSort(long arr[], int low, int high, void **ptr_arr) 
{ 
    if (low < high) 
    { 
        /* pi is partitioning index, arr[p] is now 
           at right place */
        int pi = partition(arr, low, high, ptr_arr); 
  
        // Separately sort elements before 
        // partition and after partition 
        quickSort(arr, low, pi - 1, ptr_arr); 
        quickSort(arr, pi + 1, high, ptr_arr); 
    } 
} 

// heap_info(info)
// set the appropriate values in the heap_info_struct passed
// the malloc library will be responsible for alloc'ing size_array and 
// ptr_array
// the user, i.e. the process will be responsible for freeing these allocations
// note that the allocations used by the heap_info_struct will count as metadata
// and should NOT be included in the heap info
// return 0 for a successfull call
// if for any reason the information cannot be saved, return -1
int heap_info(heap_info_struct * info)
{
    // heap info values
    int num_allocs = 0;             // number of currently allocated sites
    long *size_array = NULL;           // an array of longs that store the sizes of the currently allocated sites in descending order
    void **ptr_array = NULL;        // an array of void ptrs that store the ptrs of the currently allocated sites in descending order
    int free_space = 0;             // amount of free space in bytes that are currently available within the heap
    int largest_free_chunk = 0;     // largest chunk of free space that is currently available within the heap.

    free_list *index = head;

    // fill in size array values
    while (index != NULL && index->free == 1)
    {
        // update size array and ptr_array
        num_allocs++;

        index = index->next;
    }

    // set the num_allocs
    info->num_allocs = num_allocs;

    // loop through list to find free space

    //initialize iterator
    free_list *current = head;

    uint64_t max_space = 0;
    // search for free block
    while (current != NULL && current->free == 0)
    {        
        // update free space
        free_space += current->size - METADATA;

        if (current->size - METADATA > max_space)
        {
            max_space = current->size - METADATA;
            // update largest_free_chunk
            largest_free_chunk = max_space;
        }
        
        current = current->next;
    }

    // update free space
    info->free_space = free_space;

    // update largest_free_chunk
    info->largest_free_chunk = largest_free_chunk;  

    if (num_allocs == 0)
    {
        // update info struct
        info->size_array = size_array;
        info->ptr_array = ptr_array;

        return 0;
    }

    // set heap info flag
    if_heap_info = 1;

    // allocate size array
    size_array = malloc((uint64_t)num_allocs);
    if (!size_array)
    {
        return -1;
    }

    // allocate ptr_array
    void *ptr_temp = malloc((uint64_t)num_allocs);
    ptr_array = &ptr_temp;

    // initialize iterator
    free_list *curr = head;

    int j = 0;

    // fill in size array values
    while (curr != NULL && curr->free == 1)
    {
        // update size array and ptr_array
        size_array[j] = curr->size - METADATA;
        ptr_array[j] = curr->payload; 

        j++;

        curr = curr->next;
    }

    // sort size_array and ptr array
    quickSort(size_array, 0, num_allocs-1, ptr_array);

    // update info struct
    info->size_array = size_array;
    info->ptr_array = ptr_array;

    // set heap info flag
    if_heap_info = 0;

    return 0;
}

