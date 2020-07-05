# Memory Management

A user-space memory allocation library for WeensyOS, which constitutes the standard C API for heap allocation, i.e. malloc, calloc, realloc, and free. I implemented the functionality of these four function calls as well as two new ones: defrag, and heap_info(). I also implemented a more sophisticated process memory management system in the kernel - namely the brk/sbrk system calls and optimistic/lazy memory allocation.
