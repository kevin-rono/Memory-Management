#include "process.h"
#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
    pid_t p = sys_getpid();
    srand(p);

    //pid_t pid = sys_fork();

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
    
    // sbrk(0) should return current program break without changing it.
    void * ptr = sys_sbrk(0);
    if(ptr == (void *)-1){
	panic("SBRK unimplemented!");
    }
    assert(ptr == heap_top);

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
            if(heap_top == stack_bottom)
                break;
            void * ret = sys_sbrk(PAGESIZE);
            if(ret == (void *) -1)
                break;
            *heap_top = p;      /* check we have write access to new page */
            heap_top = (uint8_t *)ret + PAGESIZE;
        }
        sys_yield();
    }
    // After running out of memory, do nothing forever
    while (1) {
        sys_yield();
    }
    while (1) {
        sys_yield();
    }
}
