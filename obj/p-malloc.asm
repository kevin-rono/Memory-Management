
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();

    //pid_t pid = sys_fork(); 

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 2f 30 10 00       	mov    $0x10302f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 01 20 00 00 	mov    %rax,0x2001(%rip)        # 102020 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 f5 1f 00 00 	mov    %rax,0x1ff5(%rip)        # 102028 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 04 02 00 00       	callq  100240 <rand>
  10003c:	89 c2                	mov    %eax,%edx
  10003e:	48 98                	cltq   
  100040:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
  100047:	48 c1 f8 25          	sar    $0x25,%rax
  10004b:	89 d1                	mov    %edx,%ecx
  10004d:	c1 f9 1f             	sar    $0x1f,%ecx
  100050:	29 c8                	sub    %ecx,%eax
  100052:	6b c0 64             	imul   $0x64,%eax,%eax
  100055:	29 c2                	sub    %eax,%edx
  100057:	39 da                	cmp    %ebx,%edx
  100059:	7d da                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005b:	bf 00 10 00 00       	mov    $0x1000,%edi
  100060:	e8 29 0b 00 00       	callq  100b8e <malloc>
	    if(ret == NULL)
  100065:	48 85 c0             	test   %rax,%rax
  100068:	74 04                	je     10006e <process_main+0x6e>
		break;
	    *((int*)ret) = p;       // check we have write access
  10006a:	89 18                	mov    %ebx,(%rax)
  10006c:	eb c7                	jmp    100035 <process_main+0x35>
  10006e:	cd 32                	int    $0x32
  100070:	eb fc                	jmp    10006e <process_main+0x6e>

0000000000100072 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100072:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100075:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  10007c:	00 
  10007d:	72 08                	jb     100087 <console_putc+0x15>
        cp->cursor = console;
  10007f:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  100086:	00 
    }
    if (c == '\n') {
  100087:	40 80 fe 0a          	cmp    $0xa,%sil
  10008b:	74 17                	je     1000a4 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10008d:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100091:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100095:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  100099:	40 0f b6 f6          	movzbl %sil,%esi
  10009d:	44 09 c6             	or     %r8d,%esi
  1000a0:	66 89 30             	mov    %si,(%rax)
    }
}
  1000a3:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1000a4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  1000a8:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  1000af:	48 89 f1             	mov    %rsi,%rcx
  1000b2:	48 d1 f9             	sar    %rcx
  1000b5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1000bc:	66 66 66 
  1000bf:	48 89 c8             	mov    %rcx,%rax
  1000c2:	48 f7 ea             	imul   %rdx
  1000c5:	48 c1 fa 05          	sar    $0x5,%rdx
  1000c9:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1000cd:	48 29 f2             	sub    %rsi,%rdx
  1000d0:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  1000d4:	48 c1 e0 04          	shl    $0x4,%rax
  1000d8:	89 ca                	mov    %ecx,%edx
  1000da:	29 c2                	sub    %eax,%edx
  1000dc:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1000de:	44 89 c6             	mov    %r8d,%esi
  1000e1:	83 ce 20             	or     $0x20,%esi
  1000e4:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1000e8:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  1000ec:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  1000f0:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  1000f3:	83 c0 01             	add    $0x1,%eax
  1000f6:	83 f8 50             	cmp    $0x50,%eax
  1000f9:	75 e9                	jne    1000e4 <console_putc+0x72>
  1000fb:	c3                   	retq   

00000000001000fc <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1000fc:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100100:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  100104:	73 0b                	jae    100111 <string_putc+0x15>
        *sp->s++ = c;
  100106:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10010a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  10010e:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  100111:	c3                   	retq   

0000000000100112 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  100112:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100115:	48 85 d2             	test   %rdx,%rdx
  100118:	74 17                	je     100131 <memcpy+0x1f>
  10011a:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10011f:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100124:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100128:	48 83 c1 01          	add    $0x1,%rcx
  10012c:	48 39 d1             	cmp    %rdx,%rcx
  10012f:	75 ee                	jne    10011f <memcpy+0xd>
}
  100131:	c3                   	retq   

0000000000100132 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  100132:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100135:	48 39 fe             	cmp    %rdi,%rsi
  100138:	72 1d                	jb     100157 <memmove+0x25>
        while (n-- > 0) {
  10013a:	b9 00 00 00 00       	mov    $0x0,%ecx
  10013f:	48 85 d2             	test   %rdx,%rdx
  100142:	74 12                	je     100156 <memmove+0x24>
            *d++ = *s++;
  100144:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100148:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  10014c:	48 83 c1 01          	add    $0x1,%rcx
  100150:	48 39 ca             	cmp    %rcx,%rdx
  100153:	75 ef                	jne    100144 <memmove+0x12>
}
  100155:	c3                   	retq   
  100156:	c3                   	retq   
    if (s < d && s + n > d) {
  100157:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  10015b:	48 39 cf             	cmp    %rcx,%rdi
  10015e:	73 da                	jae    10013a <memmove+0x8>
        while (n-- > 0) {
  100160:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100164:	48 85 d2             	test   %rdx,%rdx
  100167:	74 ec                	je     100155 <memmove+0x23>
            *--d = *--s;
  100169:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  10016d:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  100170:	48 83 e9 01          	sub    $0x1,%rcx
  100174:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100178:	75 ef                	jne    100169 <memmove+0x37>
  10017a:	c3                   	retq   

000000000010017b <memset>:
void* memset(void* v, int c, size_t n) {
  10017b:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10017e:	48 85 d2             	test   %rdx,%rdx
  100181:	74 13                	je     100196 <memset+0x1b>
  100183:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  100187:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  10018a:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10018d:	48 83 c2 01          	add    $0x1,%rdx
  100191:	48 39 d1             	cmp    %rdx,%rcx
  100194:	75 f4                	jne    10018a <memset+0xf>
}
  100196:	c3                   	retq   

0000000000100197 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100197:	80 3f 00             	cmpb   $0x0,(%rdi)
  10019a:	74 10                	je     1001ac <strlen+0x15>
  10019c:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1001a1:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1001a5:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001a9:	75 f6                	jne    1001a1 <strlen+0xa>
  1001ab:	c3                   	retq   
  1001ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001b1:	c3                   	retq   

00000000001001b2 <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001b2:	b8 00 00 00 00       	mov    $0x0,%eax
  1001b7:	48 85 f6             	test   %rsi,%rsi
  1001ba:	74 10                	je     1001cc <strnlen+0x1a>
  1001bc:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001c0:	74 09                	je     1001cb <strnlen+0x19>
        ++n;
  1001c2:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001c6:	48 39 c6             	cmp    %rax,%rsi
  1001c9:	75 f1                	jne    1001bc <strnlen+0xa>
}
  1001cb:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001cc:	48 89 f0             	mov    %rsi,%rax
  1001cf:	c3                   	retq   

00000000001001d0 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1001d0:	48 89 f8             	mov    %rdi,%rax
  1001d3:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1001d8:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1001dc:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1001df:	48 83 c2 01          	add    $0x1,%rdx
  1001e3:	84 c9                	test   %cl,%cl
  1001e5:	75 f1                	jne    1001d8 <strcpy+0x8>
}
  1001e7:	c3                   	retq   

00000000001001e8 <strcmp>:
    while (*a && *b && *a == *b) {
  1001e8:	0f b6 17             	movzbl (%rdi),%edx
  1001eb:	84 d2                	test   %dl,%dl
  1001ed:	74 1a                	je     100209 <strcmp+0x21>
  1001ef:	0f b6 06             	movzbl (%rsi),%eax
  1001f2:	38 d0                	cmp    %dl,%al
  1001f4:	75 13                	jne    100209 <strcmp+0x21>
  1001f6:	84 c0                	test   %al,%al
  1001f8:	74 0f                	je     100209 <strcmp+0x21>
        ++a, ++b;
  1001fa:	48 83 c7 01          	add    $0x1,%rdi
  1001fe:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100202:	0f b6 17             	movzbl (%rdi),%edx
  100205:	84 d2                	test   %dl,%dl
  100207:	75 e6                	jne    1001ef <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100209:	0f b6 0e             	movzbl (%rsi),%ecx
  10020c:	38 ca                	cmp    %cl,%dl
  10020e:	0f 97 c0             	seta   %al
  100211:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100214:	83 d8 00             	sbb    $0x0,%eax
}
  100217:	c3                   	retq   

0000000000100218 <strchr>:
    while (*s && *s != (char) c) {
  100218:	0f b6 07             	movzbl (%rdi),%eax
  10021b:	84 c0                	test   %al,%al
  10021d:	74 10                	je     10022f <strchr+0x17>
  10021f:	40 38 f0             	cmp    %sil,%al
  100222:	74 18                	je     10023c <strchr+0x24>
        ++s;
  100224:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100228:	0f b6 07             	movzbl (%rdi),%eax
  10022b:	84 c0                	test   %al,%al
  10022d:	75 f0                	jne    10021f <strchr+0x7>
        return NULL;
  10022f:	40 84 f6             	test   %sil,%sil
  100232:	b8 00 00 00 00       	mov    $0x0,%eax
  100237:	48 0f 44 c7          	cmove  %rdi,%rax
}
  10023b:	c3                   	retq   
  10023c:	48 89 f8             	mov    %rdi,%rax
  10023f:	c3                   	retq   

0000000000100240 <rand>:
    if (!rand_seed_set) {
  100240:	83 3d bd 1d 00 00 00 	cmpl   $0x0,0x1dbd(%rip)        # 102004 <rand_seed_set>
  100247:	74 1b                	je     100264 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100249:	69 05 ad 1d 00 00 0d 	imul   $0x19660d,0x1dad(%rip),%eax        # 102000 <rand_seed>
  100250:	66 19 00 
  100253:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100258:	89 05 a2 1d 00 00    	mov    %eax,0x1da2(%rip)        # 102000 <rand_seed>
    return rand_seed & RAND_MAX;
  10025e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100263:	c3                   	retq   
    rand_seed = seed;
  100264:	c7 05 92 1d 00 00 9e 	movl   $0x30d4879e,0x1d92(%rip)        # 102000 <rand_seed>
  10026b:	87 d4 30 
    rand_seed_set = 1;
  10026e:	c7 05 8c 1d 00 00 01 	movl   $0x1,0x1d8c(%rip)        # 102004 <rand_seed_set>
  100275:	00 00 00 
}
  100278:	eb cf                	jmp    100249 <rand+0x9>

000000000010027a <srand>:
    rand_seed = seed;
  10027a:	89 3d 80 1d 00 00    	mov    %edi,0x1d80(%rip)        # 102000 <rand_seed>
    rand_seed_set = 1;
  100280:	c7 05 7a 1d 00 00 01 	movl   $0x1,0x1d7a(%rip)        # 102004 <rand_seed_set>
  100287:	00 00 00 
}
  10028a:	c3                   	retq   

000000000010028b <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10028b:	55                   	push   %rbp
  10028c:	48 89 e5             	mov    %rsp,%rbp
  10028f:	41 57                	push   %r15
  100291:	41 56                	push   %r14
  100293:	41 55                	push   %r13
  100295:	41 54                	push   %r12
  100297:	53                   	push   %rbx
  100298:	48 83 ec 58          	sub    $0x58,%rsp
  10029c:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1002a0:	0f b6 02             	movzbl (%rdx),%eax
  1002a3:	84 c0                	test   %al,%al
  1002a5:	0f 84 ba 06 00 00    	je     100965 <printer_vprintf+0x6da>
  1002ab:	49 89 fe             	mov    %rdi,%r14
  1002ae:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1002b1:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  1002b8:	41 89 f7             	mov    %esi,%r15d
  1002bb:	e9 a5 04 00 00       	jmpq   100765 <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  1002c0:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1002c5:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1002cb:	45 84 e4             	test   %r12b,%r12b
  1002ce:	0f 84 85 06 00 00    	je     100959 <printer_vprintf+0x6ce>
        int flags = 0;
  1002d4:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1002da:	41 0f be f4          	movsbl %r12b,%esi
  1002de:	bf 51 12 10 00       	mov    $0x101251,%edi
  1002e3:	e8 30 ff ff ff       	callq  100218 <strchr>
  1002e8:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1002eb:	48 85 c0             	test   %rax,%rax
  1002ee:	74 55                	je     100345 <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  1002f0:	48 81 e9 51 12 10 00 	sub    $0x101251,%rcx
  1002f7:	b8 01 00 00 00       	mov    $0x1,%eax
  1002fc:	d3 e0                	shl    %cl,%eax
  1002fe:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  100301:	48 83 c3 01          	add    $0x1,%rbx
  100305:	44 0f b6 23          	movzbl (%rbx),%r12d
  100309:	45 84 e4             	test   %r12b,%r12b
  10030c:	75 cc                	jne    1002da <printer_vprintf+0x4f>
  10030e:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100312:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  100318:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  10031f:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100322:	0f 84 a9 00 00 00    	je     1003d1 <printer_vprintf+0x146>
        int length = 0;
  100328:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  10032d:	0f b6 13             	movzbl (%rbx),%edx
  100330:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100333:	3c 37                	cmp    $0x37,%al
  100335:	0f 87 c5 04 00 00    	ja     100800 <printer_vprintf+0x575>
  10033b:	0f b6 c0             	movzbl %al,%eax
  10033e:	ff 24 c5 60 10 10 00 	jmpq   *0x101060(,%rax,8)
  100345:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  100349:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  10034e:	3c 08                	cmp    $0x8,%al
  100350:	77 2f                	ja     100381 <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100352:	0f b6 03             	movzbl (%rbx),%eax
  100355:	8d 50 d0             	lea    -0x30(%rax),%edx
  100358:	80 fa 09             	cmp    $0x9,%dl
  10035b:	77 5e                	ja     1003bb <printer_vprintf+0x130>
  10035d:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100363:	48 83 c3 01          	add    $0x1,%rbx
  100367:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  10036c:	0f be c0             	movsbl %al,%eax
  10036f:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100374:	0f b6 03             	movzbl (%rbx),%eax
  100377:	8d 50 d0             	lea    -0x30(%rax),%edx
  10037a:	80 fa 09             	cmp    $0x9,%dl
  10037d:	76 e4                	jbe    100363 <printer_vprintf+0xd8>
  10037f:	eb 97                	jmp    100318 <printer_vprintf+0x8d>
        } else if (*format == '*') {
  100381:	41 80 fc 2a          	cmp    $0x2a,%r12b
  100385:	75 3f                	jne    1003c6 <printer_vprintf+0x13b>
            width = va_arg(val, int);
  100387:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10038b:	8b 01                	mov    (%rcx),%eax
  10038d:	83 f8 2f             	cmp    $0x2f,%eax
  100390:	77 17                	ja     1003a9 <printer_vprintf+0x11e>
  100392:	89 c2                	mov    %eax,%edx
  100394:	48 03 51 10          	add    0x10(%rcx),%rdx
  100398:	83 c0 08             	add    $0x8,%eax
  10039b:	89 01                	mov    %eax,(%rcx)
  10039d:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1003a0:	48 83 c3 01          	add    $0x1,%rbx
  1003a4:	e9 6f ff ff ff       	jmpq   100318 <printer_vprintf+0x8d>
            width = va_arg(val, int);
  1003a9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1003ad:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1003b1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1003b5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1003b9:	eb e2                	jmp    10039d <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003bb:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003c1:	e9 52 ff ff ff       	jmpq   100318 <printer_vprintf+0x8d>
        int width = -1;
  1003c6:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1003cc:	e9 47 ff ff ff       	jmpq   100318 <printer_vprintf+0x8d>
            ++format;
  1003d1:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1003d5:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1003d9:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1003dc:	80 f9 09             	cmp    $0x9,%cl
  1003df:	76 13                	jbe    1003f4 <printer_vprintf+0x169>
            } else if (*format == '*') {
  1003e1:	3c 2a                	cmp    $0x2a,%al
  1003e3:	74 32                	je     100417 <printer_vprintf+0x18c>
            ++format;
  1003e5:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1003e8:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1003ef:	e9 34 ff ff ff       	jmpq   100328 <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003f4:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  1003f9:	48 83 c2 01          	add    $0x1,%rdx
  1003fd:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  100400:	0f be c0             	movsbl %al,%eax
  100403:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100407:	0f b6 02             	movzbl (%rdx),%eax
  10040a:	8d 48 d0             	lea    -0x30(%rax),%ecx
  10040d:	80 f9 09             	cmp    $0x9,%cl
  100410:	76 e7                	jbe    1003f9 <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  100412:	48 89 d3             	mov    %rdx,%rbx
  100415:	eb 1c                	jmp    100433 <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  100417:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10041b:	8b 07                	mov    (%rdi),%eax
  10041d:	83 f8 2f             	cmp    $0x2f,%eax
  100420:	77 23                	ja     100445 <printer_vprintf+0x1ba>
  100422:	89 c2                	mov    %eax,%edx
  100424:	48 03 57 10          	add    0x10(%rdi),%rdx
  100428:	83 c0 08             	add    $0x8,%eax
  10042b:	89 07                	mov    %eax,(%rdi)
  10042d:	8b 32                	mov    (%rdx),%esi
                ++format;
  10042f:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  100433:	85 f6                	test   %esi,%esi
  100435:	b8 00 00 00 00       	mov    $0x0,%eax
  10043a:	0f 48 f0             	cmovs  %eax,%esi
  10043d:	89 75 9c             	mov    %esi,-0x64(%rbp)
  100440:	e9 e3 fe ff ff       	jmpq   100328 <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  100445:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100449:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10044d:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100451:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100455:	eb d6                	jmp    10042d <printer_vprintf+0x1a2>
        switch (*format) {
  100457:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10045c:	e9 f1 00 00 00       	jmpq   100552 <printer_vprintf+0x2c7>
            ++format;
  100461:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  100465:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  100468:	e9 c0 fe ff ff       	jmpq   10032d <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10046d:	85 c9                	test   %ecx,%ecx
  10046f:	74 55                	je     1004c6 <printer_vprintf+0x23b>
  100471:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100475:	8b 01                	mov    (%rcx),%eax
  100477:	83 f8 2f             	cmp    $0x2f,%eax
  10047a:	77 38                	ja     1004b4 <printer_vprintf+0x229>
  10047c:	89 c2                	mov    %eax,%edx
  10047e:	48 03 51 10          	add    0x10(%rcx),%rdx
  100482:	83 c0 08             	add    $0x8,%eax
  100485:	89 01                	mov    %eax,(%rcx)
  100487:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  10048a:	48 89 d0             	mov    %rdx,%rax
  10048d:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100491:	49 89 d0             	mov    %rdx,%r8
  100494:	49 f7 d8             	neg    %r8
  100497:	25 80 00 00 00       	and    $0x80,%eax
  10049c:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1004a0:	0b 45 a8             	or     -0x58(%rbp),%eax
  1004a3:	83 c8 60             	or     $0x60,%eax
  1004a6:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1004a9:	41 bc 54 10 10 00    	mov    $0x101054,%r12d
            break;
  1004af:	e9 35 01 00 00       	jmpq   1005e9 <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004b4:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004b8:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004bc:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004c0:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1004c4:	eb c1                	jmp    100487 <printer_vprintf+0x1fc>
  1004c6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004ca:	8b 07                	mov    (%rdi),%eax
  1004cc:	83 f8 2f             	cmp    $0x2f,%eax
  1004cf:	77 10                	ja     1004e1 <printer_vprintf+0x256>
  1004d1:	89 c2                	mov    %eax,%edx
  1004d3:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004d7:	83 c0 08             	add    $0x8,%eax
  1004da:	89 07                	mov    %eax,(%rdi)
  1004dc:	48 63 12             	movslq (%rdx),%rdx
  1004df:	eb a9                	jmp    10048a <printer_vprintf+0x1ff>
  1004e1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004e5:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004e9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004ed:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004f1:	eb e9                	jmp    1004dc <printer_vprintf+0x251>
        int base = 10;
  1004f3:	be 0a 00 00 00       	mov    $0xa,%esi
  1004f8:	eb 58                	jmp    100552 <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1004fa:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004fe:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100502:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100506:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10050a:	eb 60                	jmp    10056c <printer_vprintf+0x2e1>
  10050c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100510:	8b 01                	mov    (%rcx),%eax
  100512:	83 f8 2f             	cmp    $0x2f,%eax
  100515:	77 10                	ja     100527 <printer_vprintf+0x29c>
  100517:	89 c2                	mov    %eax,%edx
  100519:	48 03 51 10          	add    0x10(%rcx),%rdx
  10051d:	83 c0 08             	add    $0x8,%eax
  100520:	89 01                	mov    %eax,(%rcx)
  100522:	44 8b 02             	mov    (%rdx),%r8d
  100525:	eb 48                	jmp    10056f <printer_vprintf+0x2e4>
  100527:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10052b:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10052f:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100533:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100537:	eb e9                	jmp    100522 <printer_vprintf+0x297>
  100539:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  10053c:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  100543:	bf 40 12 10 00       	mov    $0x101240,%edi
  100548:	e9 e6 02 00 00       	jmpq   100833 <printer_vprintf+0x5a8>
            base = 16;
  10054d:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100552:	85 c9                	test   %ecx,%ecx
  100554:	74 b6                	je     10050c <printer_vprintf+0x281>
  100556:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10055a:	8b 07                	mov    (%rdi),%eax
  10055c:	83 f8 2f             	cmp    $0x2f,%eax
  10055f:	77 99                	ja     1004fa <printer_vprintf+0x26f>
  100561:	89 c2                	mov    %eax,%edx
  100563:	48 03 57 10          	add    0x10(%rdi),%rdx
  100567:	83 c0 08             	add    $0x8,%eax
  10056a:	89 07                	mov    %eax,(%rdi)
  10056c:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  10056f:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  100573:	85 f6                	test   %esi,%esi
  100575:	79 c2                	jns    100539 <printer_vprintf+0x2ae>
        base = -base;
  100577:	41 89 f1             	mov    %esi,%r9d
  10057a:	f7 de                	neg    %esi
  10057c:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  100583:	bf 20 12 10 00       	mov    $0x101220,%edi
  100588:	e9 a6 02 00 00       	jmpq   100833 <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  10058d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100591:	8b 07                	mov    (%rdi),%eax
  100593:	83 f8 2f             	cmp    $0x2f,%eax
  100596:	77 1c                	ja     1005b4 <printer_vprintf+0x329>
  100598:	89 c2                	mov    %eax,%edx
  10059a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10059e:	83 c0 08             	add    $0x8,%eax
  1005a1:	89 07                	mov    %eax,(%rdi)
  1005a3:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1005a6:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1005ad:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005b2:	eb c3                	jmp    100577 <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  1005b4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005b8:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005bc:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005c0:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005c4:	eb dd                	jmp    1005a3 <printer_vprintf+0x318>
            data = va_arg(val, char*);
  1005c6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005ca:	8b 01                	mov    (%rcx),%eax
  1005cc:	83 f8 2f             	cmp    $0x2f,%eax
  1005cf:	0f 87 a9 01 00 00    	ja     10077e <printer_vprintf+0x4f3>
  1005d5:	89 c2                	mov    %eax,%edx
  1005d7:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005db:	83 c0 08             	add    $0x8,%eax
  1005de:	89 01                	mov    %eax,(%rcx)
  1005e0:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1005e3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1005e9:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005ec:	83 e0 20             	and    $0x20,%eax
  1005ef:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1005f2:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1005f8:	0f 85 25 02 00 00    	jne    100823 <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1005fe:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100601:	89 45 88             	mov    %eax,-0x78(%rbp)
  100604:	83 e0 60             	and    $0x60,%eax
  100607:	83 f8 60             	cmp    $0x60,%eax
  10060a:	0f 84 58 02 00 00    	je     100868 <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100610:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100613:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  100616:	48 c7 45 a0 54 10 10 	movq   $0x101054,-0x60(%rbp)
  10061d:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10061e:	83 f8 21             	cmp    $0x21,%eax
  100621:	0f 84 7d 02 00 00    	je     1008a4 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100627:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  10062a:	89 c8                	mov    %ecx,%eax
  10062c:	f7 d0                	not    %eax
  10062e:	c1 e8 1f             	shr    $0x1f,%eax
  100631:	89 45 84             	mov    %eax,-0x7c(%rbp)
  100634:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100638:	0f 85 a2 02 00 00    	jne    1008e0 <printer_vprintf+0x655>
  10063e:	84 c0                	test   %al,%al
  100640:	0f 84 9a 02 00 00    	je     1008e0 <printer_vprintf+0x655>
            len = strnlen(data, precision);
  100646:	48 63 f1             	movslq %ecx,%rsi
  100649:	4c 89 e7             	mov    %r12,%rdi
  10064c:	e8 61 fb ff ff       	callq  1001b2 <strnlen>
  100651:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  100654:	8b 45 88             	mov    -0x78(%rbp),%eax
  100657:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  10065a:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100661:	83 f8 22             	cmp    $0x22,%eax
  100664:	0f 84 ae 02 00 00    	je     100918 <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  10066a:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10066e:	e8 24 fb ff ff       	callq  100197 <strlen>
  100673:	8b 55 9c             	mov    -0x64(%rbp),%edx
  100676:	03 55 98             	add    -0x68(%rbp),%edx
  100679:	41 29 d5             	sub    %edx,%r13d
  10067c:	44 89 ea             	mov    %r13d,%edx
  10067f:	29 c2                	sub    %eax,%edx
  100681:	89 55 8c             	mov    %edx,-0x74(%rbp)
  100684:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100687:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  10068b:	75 2d                	jne    1006ba <printer_vprintf+0x42f>
  10068d:	85 d2                	test   %edx,%edx
  10068f:	7e 29                	jle    1006ba <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  100691:	44 89 fa             	mov    %r15d,%edx
  100694:	be 20 00 00 00       	mov    $0x20,%esi
  100699:	4c 89 f7             	mov    %r14,%rdi
  10069c:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10069f:	41 83 ed 01          	sub    $0x1,%r13d
  1006a3:	45 85 ed             	test   %r13d,%r13d
  1006a6:	7f e9                	jg     100691 <printer_vprintf+0x406>
  1006a8:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1006ab:	85 ff                	test   %edi,%edi
  1006ad:	b8 01 00 00 00       	mov    $0x1,%eax
  1006b2:	0f 4f c7             	cmovg  %edi,%eax
  1006b5:	29 c7                	sub    %eax,%edi
  1006b7:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1006ba:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  1006be:	0f b6 01             	movzbl (%rcx),%eax
  1006c1:	84 c0                	test   %al,%al
  1006c3:	74 22                	je     1006e7 <printer_vprintf+0x45c>
  1006c5:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006c9:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  1006cc:	0f b6 f0             	movzbl %al,%esi
  1006cf:	44 89 fa             	mov    %r15d,%edx
  1006d2:	4c 89 f7             	mov    %r14,%rdi
  1006d5:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1006d8:	48 83 c3 01          	add    $0x1,%rbx
  1006dc:	0f b6 03             	movzbl (%rbx),%eax
  1006df:	84 c0                	test   %al,%al
  1006e1:	75 e9                	jne    1006cc <printer_vprintf+0x441>
  1006e3:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1006e7:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1006ea:	85 c0                	test   %eax,%eax
  1006ec:	7e 1d                	jle    10070b <printer_vprintf+0x480>
  1006ee:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006f2:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1006f4:	44 89 fa             	mov    %r15d,%edx
  1006f7:	be 30 00 00 00       	mov    $0x30,%esi
  1006fc:	4c 89 f7             	mov    %r14,%rdi
  1006ff:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  100702:	83 eb 01             	sub    $0x1,%ebx
  100705:	75 ed                	jne    1006f4 <printer_vprintf+0x469>
  100707:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  10070b:	8b 45 98             	mov    -0x68(%rbp),%eax
  10070e:	85 c0                	test   %eax,%eax
  100710:	7e 2a                	jle    10073c <printer_vprintf+0x4b1>
  100712:	8d 40 ff             	lea    -0x1(%rax),%eax
  100715:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  10071a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10071e:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100721:	41 0f b6 34 24       	movzbl (%r12),%esi
  100726:	44 89 fa             	mov    %r15d,%edx
  100729:	4c 89 f7             	mov    %r14,%rdi
  10072c:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  10072f:	49 83 c4 01          	add    $0x1,%r12
  100733:	49 39 dc             	cmp    %rbx,%r12
  100736:	75 e9                	jne    100721 <printer_vprintf+0x496>
  100738:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  10073c:	45 85 ed             	test   %r13d,%r13d
  10073f:	7e 14                	jle    100755 <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  100741:	44 89 fa             	mov    %r15d,%edx
  100744:	be 20 00 00 00       	mov    $0x20,%esi
  100749:	4c 89 f7             	mov    %r14,%rdi
  10074c:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  10074f:	41 83 ed 01          	sub    $0x1,%r13d
  100753:	75 ec                	jne    100741 <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  100755:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  100759:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  10075d:	84 c0                	test   %al,%al
  10075f:	0f 84 00 02 00 00    	je     100965 <printer_vprintf+0x6da>
        if (*format != '%') {
  100765:	3c 25                	cmp    $0x25,%al
  100767:	0f 84 53 fb ff ff    	je     1002c0 <printer_vprintf+0x35>
            p->putc(p, *format, color);
  10076d:	0f b6 f0             	movzbl %al,%esi
  100770:	44 89 fa             	mov    %r15d,%edx
  100773:	4c 89 f7             	mov    %r14,%rdi
  100776:	41 ff 16             	callq  *(%r14)
            continue;
  100779:	4c 89 e3             	mov    %r12,%rbx
  10077c:	eb d7                	jmp    100755 <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  10077e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100782:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100786:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10078a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10078e:	e9 4d fe ff ff       	jmpq   1005e0 <printer_vprintf+0x355>
            color = va_arg(val, int);
  100793:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100797:	8b 07                	mov    (%rdi),%eax
  100799:	83 f8 2f             	cmp    $0x2f,%eax
  10079c:	77 10                	ja     1007ae <printer_vprintf+0x523>
  10079e:	89 c2                	mov    %eax,%edx
  1007a0:	48 03 57 10          	add    0x10(%rdi),%rdx
  1007a4:	83 c0 08             	add    $0x8,%eax
  1007a7:	89 07                	mov    %eax,(%rdi)
  1007a9:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1007ac:	eb a7                	jmp    100755 <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  1007ae:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007b2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1007b6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ba:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1007be:	eb e9                	jmp    1007a9 <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  1007c0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007c4:	8b 01                	mov    (%rcx),%eax
  1007c6:	83 f8 2f             	cmp    $0x2f,%eax
  1007c9:	77 23                	ja     1007ee <printer_vprintf+0x563>
  1007cb:	89 c2                	mov    %eax,%edx
  1007cd:	48 03 51 10          	add    0x10(%rcx),%rdx
  1007d1:	83 c0 08             	add    $0x8,%eax
  1007d4:	89 01                	mov    %eax,(%rcx)
  1007d6:	8b 02                	mov    (%rdx),%eax
  1007d8:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1007db:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1007df:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1007e3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1007e9:	e9 fb fd ff ff       	jmpq   1005e9 <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  1007ee:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007f2:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007f6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007fa:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1007fe:	eb d6                	jmp    1007d6 <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  100800:	84 d2                	test   %dl,%dl
  100802:	0f 85 3b 01 00 00    	jne    100943 <printer_vprintf+0x6b8>
  100808:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  10080c:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100810:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100814:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100818:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  10081e:	e9 c6 fd ff ff       	jmpq   1005e9 <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  100823:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  100829:	bf 40 12 10 00       	mov    $0x101240,%edi
        if (flags & FLAG_NUMERIC) {
  10082e:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100833:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  100837:	4c 89 c1             	mov    %r8,%rcx
  10083a:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  10083e:	48 63 f6             	movslq %esi,%rsi
  100841:	49 83 ec 01          	sub    $0x1,%r12
  100845:	48 89 c8             	mov    %rcx,%rax
  100848:	ba 00 00 00 00       	mov    $0x0,%edx
  10084d:	48 f7 f6             	div    %rsi
  100850:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100854:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  100858:	48 89 ca             	mov    %rcx,%rdx
  10085b:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  10085e:	48 39 d6             	cmp    %rdx,%rsi
  100861:	76 de                	jbe    100841 <printer_vprintf+0x5b6>
  100863:	e9 96 fd ff ff       	jmpq   1005fe <printer_vprintf+0x373>
                prefix = "-";
  100868:	48 c7 45 a0 57 10 10 	movq   $0x101057,-0x60(%rbp)
  10086f:	00 
            if (flags & FLAG_NEGATIVE) {
  100870:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100873:	a8 80                	test   $0x80,%al
  100875:	0f 85 ac fd ff ff    	jne    100627 <printer_vprintf+0x39c>
                prefix = "+";
  10087b:	48 c7 45 a0 55 10 10 	movq   $0x101055,-0x60(%rbp)
  100882:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100883:	a8 10                	test   $0x10,%al
  100885:	0f 85 9c fd ff ff    	jne    100627 <printer_vprintf+0x39c>
                prefix = " ";
  10088b:	a8 08                	test   $0x8,%al
  10088d:	ba 54 10 10 00       	mov    $0x101054,%edx
  100892:	b8 53 10 10 00       	mov    $0x101053,%eax
  100897:	48 0f 44 c2          	cmove  %rdx,%rax
  10089b:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  10089f:	e9 83 fd ff ff       	jmpq   100627 <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  1008a4:	41 8d 41 10          	lea    0x10(%r9),%eax
  1008a8:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1008ad:	0f 85 74 fd ff ff    	jne    100627 <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  1008b3:	4d 85 c0             	test   %r8,%r8
  1008b6:	75 0d                	jne    1008c5 <printer_vprintf+0x63a>
  1008b8:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1008bf:	0f 84 62 fd ff ff    	je     100627 <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  1008c5:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1008c9:	ba 50 10 10 00       	mov    $0x101050,%edx
  1008ce:	b8 59 10 10 00       	mov    $0x101059,%eax
  1008d3:	48 0f 44 c2          	cmove  %rdx,%rax
  1008d7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1008db:	e9 47 fd ff ff       	jmpq   100627 <printer_vprintf+0x39c>
            len = strlen(data);
  1008e0:	4c 89 e7             	mov    %r12,%rdi
  1008e3:	e8 af f8 ff ff       	callq  100197 <strlen>
  1008e8:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1008eb:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1008ef:	0f 84 5f fd ff ff    	je     100654 <printer_vprintf+0x3c9>
  1008f5:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1008f9:	0f 84 55 fd ff ff    	je     100654 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  1008ff:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100902:	89 fa                	mov    %edi,%edx
  100904:	29 c2                	sub    %eax,%edx
  100906:	39 c7                	cmp    %eax,%edi
  100908:	b8 00 00 00 00       	mov    $0x0,%eax
  10090d:	0f 4e d0             	cmovle %eax,%edx
  100910:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100913:	e9 52 fd ff ff       	jmpq   10066a <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  100918:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10091c:	e8 76 f8 ff ff       	callq  100197 <strlen>
  100921:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100924:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  100927:	44 89 e9             	mov    %r13d,%ecx
  10092a:	29 f9                	sub    %edi,%ecx
  10092c:	29 c1                	sub    %eax,%ecx
  10092e:	89 c8                	mov    %ecx,%eax
  100930:	44 39 ea             	cmp    %r13d,%edx
  100933:	b9 00 00 00 00       	mov    $0x0,%ecx
  100938:	0f 4d c1             	cmovge %ecx,%eax
  10093b:	89 45 9c             	mov    %eax,-0x64(%rbp)
  10093e:	e9 27 fd ff ff       	jmpq   10066a <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  100943:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100946:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10094a:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10094e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100954:	e9 90 fc ff ff       	jmpq   1005e9 <printer_vprintf+0x35e>
        int flags = 0;
  100959:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100960:	e9 ad f9 ff ff       	jmpq   100312 <printer_vprintf+0x87>
}
  100965:	48 83 c4 58          	add    $0x58,%rsp
  100969:	5b                   	pop    %rbx
  10096a:	41 5c                	pop    %r12
  10096c:	41 5d                	pop    %r13
  10096e:	41 5e                	pop    %r14
  100970:	41 5f                	pop    %r15
  100972:	5d                   	pop    %rbp
  100973:	c3                   	retq   

0000000000100974 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100974:	55                   	push   %rbp
  100975:	48 89 e5             	mov    %rsp,%rbp
  100978:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  10097c:	48 c7 45 f0 72 00 10 	movq   $0x100072,-0x10(%rbp)
  100983:	00 
        cpos = 0;
  100984:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  10098a:	b8 00 00 00 00       	mov    $0x0,%eax
  10098f:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100992:	48 63 ff             	movslq %edi,%rdi
  100995:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  10099c:	00 
  10099d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1009a1:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  1009a5:	e8 e1 f8 ff ff       	callq  10028b <printer_vprintf>
    return cp.cursor - console;
  1009aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009ae:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1009b4:	48 d1 f8             	sar    %rax
}
  1009b7:	c9                   	leaveq 
  1009b8:	c3                   	retq   

00000000001009b9 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1009b9:	55                   	push   %rbp
  1009ba:	48 89 e5             	mov    %rsp,%rbp
  1009bd:	48 83 ec 50          	sub    $0x50,%rsp
  1009c1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1009c5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1009c9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1009cd:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1009d4:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1009d8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1009dc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1009e0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1009e4:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1009e8:	e8 87 ff ff ff       	callq  100974 <console_vprintf>
}
  1009ed:	c9                   	leaveq 
  1009ee:	c3                   	retq   

00000000001009ef <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1009ef:	55                   	push   %rbp
  1009f0:	48 89 e5             	mov    %rsp,%rbp
  1009f3:	53                   	push   %rbx
  1009f4:	48 83 ec 28          	sub    $0x28,%rsp
  1009f8:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1009fb:	48 c7 45 d8 fc 00 10 	movq   $0x1000fc,-0x28(%rbp)
  100a02:	00 
    sp.s = s;
  100a03:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100a07:	48 85 f6             	test   %rsi,%rsi
  100a0a:	75 0e                	jne    100a1a <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100a0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a10:	48 29 d8             	sub    %rbx,%rax
}
  100a13:	48 83 c4 28          	add    $0x28,%rsp
  100a17:	5b                   	pop    %rbx
  100a18:	5d                   	pop    %rbp
  100a19:	c3                   	retq   
        sp.end = s + size - 1;
  100a1a:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a1f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a23:	be 00 00 00 00       	mov    $0x0,%esi
  100a28:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100a2c:	e8 5a f8 ff ff       	callq  10028b <printer_vprintf>
        *sp.s = 0;
  100a31:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a35:	c6 00 00             	movb   $0x0,(%rax)
  100a38:	eb d2                	jmp    100a0c <vsnprintf+0x1d>

0000000000100a3a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100a3a:	55                   	push   %rbp
  100a3b:	48 89 e5             	mov    %rsp,%rbp
  100a3e:	48 83 ec 50          	sub    $0x50,%rsp
  100a42:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a46:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a4a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100a4e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a55:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a59:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a5d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a61:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100a65:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a69:	e8 81 ff ff ff       	callq  1009ef <vsnprintf>
    va_end(val);
    return n;
}
  100a6e:	c9                   	leaveq 
  100a6f:	c3                   	retq   

0000000000100a70 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a70:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100a75:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100a7a:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a7f:	48 83 c0 02          	add    $0x2,%rax
  100a83:	48 39 d0             	cmp    %rdx,%rax
  100a86:	75 f2                	jne    100a7a <console_clear+0xa>
    }
    cursorpos = 0;
  100a88:	c7 05 6a 85 fb ff 00 	movl   $0x0,-0x47a96(%rip)        # b8ffc <cursorpos>
  100a8f:	00 00 00 
}
  100a92:	c3                   	retq   

0000000000100a93 <get_header>:
#define MY_INT_MAX 4294967295

// get the header from payload
free_list *get_header(void *payload)
{
    return (free_list *) (uintptr_t)payload - METADATA;
  100a93:	48 8d 87 c0 f9 ff ff 	lea    -0x640(%rdi),%rax
}
  100a9a:	c3                   	retq   

0000000000100a9b <get_payload>:

// get the payload from header
void *get_payload(void *header_ptr)
{
    return (void *) (uintptr_t)header_ptr + METADATA;
  100a9b:	48 8d 47 28          	lea    0x28(%rdi),%rax
}
  100a9f:	c3                   	retq   

0000000000100aa0 <search_block>:

// search free list for a block that fits `sz`
free_list *search_block(uint64_t sz)
{
    //initialize iterator
    free_list *current = head;
  100aa0:	48 8b 05 69 15 00 00 	mov    0x1569(%rip),%rax        # 102010 <head>

    // search for free block
    while (current != NULL)
  100aa7:	48 85 c0             	test   %rax,%rax
  100aaa:	75 0b                	jne    100ab7 <search_block+0x17>
  100aac:	eb 14                	jmp    100ac2 <search_block+0x22>
        // if free block is found
        if (current->size >= sz && current->free == 0)
        {
            return current;
        }
        current = current->next;
  100aae:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (current != NULL)
  100ab2:	48 85 c0             	test   %rax,%rax
  100ab5:	74 0b                	je     100ac2 <search_block+0x22>
        if (current->size >= sz && current->free == 0)
  100ab7:	48 39 38             	cmp    %rdi,(%rax)
  100aba:	72 f2                	jb     100aae <search_block+0xe>
  100abc:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100ac0:	75 ec                	jne    100aae <search_block+0xe>
    }

    // if no free block was found
    return NULL;
}
  100ac2:	c3                   	retq   

0000000000100ac3 <append_block>:
// append block to our free list
void append_block(void *block)
{
    free_list *temp = (free_list *)block;

    temp->free = 0;
  100ac3:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%rdi)

    // initialize pointers
    temp->next = NULL;
  100aca:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100ad1:	00 
    temp->prev = NULL;
  100ad2:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  100ad9:	00 

    // when we need to update the head
    if (head == NULL || (uintptr_t) head > (uintptr_t) temp)
  100ada:	48 8b 05 2f 15 00 00 	mov    0x152f(%rip),%rax        # 102010 <head>
  100ae1:	48 85 c0             	test   %rax,%rax
  100ae4:	74 0c                	je     100af2 <append_block+0x2f>
  100ae6:	48 89 fa             	mov    %rdi,%rdx
  100ae9:	48 39 f8             	cmp    %rdi,%rax
  100aec:	76 10                	jbe    100afe <append_block+0x3b>
    {
        if (head != NULL)
        {
            head->prev = temp;
  100aee:	48 89 78 20          	mov    %rdi,0x20(%rax)
        }
        
        temp->next = head;
  100af2:	48 89 47 18          	mov    %rax,0x18(%rdi)

        head = temp;
  100af6:	48 89 3d 13 15 00 00 	mov    %rdi,0x1513(%rip)        # 102010 <head>
  100afd:	c3                   	retq   
    else
    {
        // initialize iterator
        free_list *current = head;

        while (current->next != NULL && (uintptr_t) current->next < (uintptr_t)temp)
  100afe:	48 89 c1             	mov    %rax,%rcx
  100b01:	48 8b 40 18          	mov    0x18(%rax),%rax
  100b05:	48 85 c0             	test   %rax,%rax
  100b08:	74 05                	je     100b0f <append_block+0x4c>
  100b0a:	48 39 d0             	cmp    %rdx,%rax
  100b0d:	72 ef                	jb     100afe <append_block+0x3b>
        {
            current = current->next;
        }

        temp->next = current->next;
  100b0f:	48 89 47 18          	mov    %rax,0x18(%rdi)
        current->next = temp;
  100b13:	48 89 79 18          	mov    %rdi,0x18(%rcx)
    }
}
  100b17:	c3                   	retq   

0000000000100b18 <split>:
    // get the end of our memory block
    void *new_ptr = (void *) ((uintptr_t) new_block + new_sz);

    // if a block, when split, creates a free-list node that is too small to be properly typecast,
    // it is okay to just use the entire free block for the allocation
    if ((block_size - new_sz) < METADATA)
  100b18:	48 29 fe             	sub    %rdi,%rsi
  100b1b:	48 83 fe 27          	cmp    $0x27,%rsi
  100b1f:	77 01                	ja     100b22 <split+0xa>
  100b21:	c3                   	retq   
{
  100b22:	55                   	push   %rbp
  100b23:	48 89 e5             	mov    %rsp,%rbp
    void *new_ptr = (void *) ((uintptr_t) new_block + new_sz);
  100b26:	48 8d 04 3a          	lea    (%rdx,%rdi,1),%rax

    // if there's enough space, initialize values for the next block
    free_list *new_free_list = (free_list *) new_ptr;

    // set size
    new_free_list->size = block_size - new_sz;
  100b2a:	48 89 30             	mov    %rsi,(%rax)

   
    // update size of current block
    temp->size = new_sz;
  100b2d:	48 89 3a             	mov    %rdi,(%rdx)
    
    // set occupied flag
    new_free_list->free = 0;
  100b30:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)

    // append the new block to our free list
    append_block(new_free_list);
  100b37:	48 89 c7             	mov    %rax,%rdi
  100b3a:	e8 84 ff ff ff       	callq  100ac3 <append_block>
}
  100b3f:	5d                   	pop    %rbp
  100b40:	c3                   	retq   

0000000000100b41 <remove_block>:
void remove_block(void *block)
{
    free_list *temp = (free_list *)block;

    // if this block is the head
    if (temp->prev == NULL)
  100b41:	48 8b 47 20          	mov    0x20(%rdi),%rax
  100b45:	48 85 c0             	test   %rax,%rax
  100b48:	74 16                	je     100b60 <remove_block+0x1f>
        }

    }
    else
    {
        if (temp->next != NULL)
  100b4a:	48 8b 57 18          	mov    0x18(%rdi),%rdx
  100b4e:	48 85 d2             	test   %rdx,%rdx
  100b51:	74 32                	je     100b85 <remove_block+0x44>
        {
            // node is in the middle
            temp->prev->next = temp->next;
  100b53:	48 89 50 18          	mov    %rdx,0x18(%rax)

            temp->next->prev = temp->prev;
  100b57:	48 8b 47 20          	mov    0x20(%rdi),%rax
  100b5b:	48 89 42 20          	mov    %rax,0x20(%rdx)
  100b5f:	c3                   	retq   
        if (temp->next != NULL)
  100b60:	48 8b 47 18          	mov    0x18(%rdi),%rax
  100b64:	48 85 c0             	test   %rax,%rax
  100b67:	74 10                	je     100b79 <remove_block+0x38>
            head = temp->next;
  100b69:	48 89 05 a0 14 00 00 	mov    %rax,0x14a0(%rip)        # 102010 <head>
            temp->next->prev = NULL;
  100b70:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
  100b77:	00 
  100b78:	c3                   	retq   
            head = NULL;
  100b79:	48 c7 05 8c 14 00 00 	movq   $0x0,0x148c(%rip)        # 102010 <head>
  100b80:	00 00 00 00 
  100b84:	c3                   	retq   
        }
        else
        {
            // node is at the end
            temp->prev->next = NULL;
  100b85:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  100b8c:	00 
        }
    }
}
  100b8d:	c3                   	retq   

0000000000100b8e <malloc>:
// allocates sz bytes of uninitialized memory and returns a pointer to the allocated memory
// if sz == 0, then malloc() either returns NULL or a unique pointer value that can be
// successfully passed to a later free
// the pointer should be aligned to 8 bytes
void * malloc(uint64_t sz)
{
  100b8e:	55                   	push   %rbp
  100b8f:	48 89 e5             	mov    %rsp,%rbp
  100b92:	41 56                	push   %r14
  100b94:	41 55                	push   %r13
  100b96:	41 54                	push   %r12
  100b98:	53                   	push   %rbx
    {
        return NULL;
    }

    // check for overflow
    if ((METADATA > 0) && (sz > MY_INT_MAX - METADATA))
  100b99:	48 8d 57 ff          	lea    -0x1(%rdi),%rdx
    {
        /* Oh no, overflow */
        return NULL;
  100b9d:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if ((METADATA > 0) && (sz > MY_INT_MAX - METADATA))
  100ba3:	b8 d6 ff ff ff       	mov    $0xffffffd6,%eax
  100ba8:	48 39 c2             	cmp    %rax,%rdx
  100bab:	77 3b                	ja     100be8 <malloc+0x5a>
    }

    // keep stock of metadata: header metadata, sz
    // make sure to align
    uint64_t new_sz = ALIGN(sz + METADATA);
  100bad:	48 8d 5f 2f          	lea    0x2f(%rdi),%rbx
  100bb1:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx

    // search for a free block to accomodate sz
    free_list *new_block = search_block(new_sz);
  100bb5:	48 89 df             	mov    %rbx,%rdi
  100bb8:	e8 e3 fe ff ff       	callq  100aa0 <search_block>
  100bbd:	48 89 c2             	mov    %rax,%rdx

    //  If a block is not found, the heap is expanded and added to the free list in some way.
    if (new_block == NULL)
  100bc0:	48 85 c0             	test   %rax,%rax
  100bc3:	74 2f                	je     100bf4 <malloc+0x66>
    }

    //if enough space is found

    // don't account for heap info data
    if (if_heap_info == 0)
  100bc5:	83 3d 3c 14 00 00 00 	cmpl   $0x0,0x143c(%rip)        # 102008 <if_heap_info>
  100bcc:	75 07                	jne    100bd5 <malloc+0x47>
    {
        // set free flag
        new_block->free = 1;
  100bce:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
    return (void *) (uintptr_t)header_ptr + METADATA;
  100bd5:	4c 8d 62 28          	lea    0x28(%rdx),%r12
    }

    // set payload
    new_block->payload = get_payload(new_block);
  100bd9:	4c 89 62 10          	mov    %r12,0x10(%rdx)

    // split block to get the memory we need and release the surplus
    split(new_sz, new_block->size, new_block);
  100bdd:	48 8b 32             	mov    (%rdx),%rsi
  100be0:	48 89 df             	mov    %rbx,%rdi
  100be3:	e8 30 ff ff ff       	callq  100b18 <split>
    //     num_allocs++;
    // }

    // return payload
    return get_payload(new_block);
}
  100be8:	4c 89 e0             	mov    %r12,%rax
  100beb:	5b                   	pop    %rbx
  100bec:	41 5c                	pop    %r12
  100bee:	41 5d                	pop    %r13
  100bf0:	41 5e                	pop    %r14
  100bf2:	5d                   	pop    %rbp
  100bf3:	c3                   	retq   
        if (new_sz > DEFAULT_EXPAND)
  100bf4:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
  100bfb:	41 be 00 10 00 00    	mov    $0x1000,%r14d
  100c01:	4c 0f 43 f3          	cmovae %rbx,%r14
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sys_sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100c05:	4c 89 f7             	mov    %r14,%rdi
  100c08:	cd 3a                	int    $0x3a
  100c0a:	49 89 c5             	mov    %rax,%r13
  100c0d:	48 89 05 04 14 00 00 	mov    %rax,0x1404(%rip)        # 102018 <result.1444>
            return NULL;
  100c14:	49 89 d4             	mov    %rdx,%r12
        if (temp_block == (void *)-1)
  100c17:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100c1b:	74 cb                	je     100be8 <malloc+0x5a>
        append_block(new_block);
  100c1d:	48 89 c7             	mov    %rax,%rdi
  100c20:	e8 9e fe ff ff       	callq  100ac3 <append_block>
        new_block->size = expand_sz;
  100c25:	4d 89 75 00          	mov    %r14,0x0(%r13)
        if (if_heap_info == 0)
  100c29:	83 3d d8 13 00 00 00 	cmpl   $0x0,0x13d8(%rip)        # 102008 <if_heap_info>
  100c30:	75 08                	jne    100c3a <malloc+0xac>
            new_block->free = 1;
  100c32:	41 c7 45 08 01 00 00 	movl   $0x1,0x8(%r13)
  100c39:	00 
    return (void *) (uintptr_t)header_ptr + METADATA;
  100c3a:	4d 8d 65 28          	lea    0x28(%r13),%r12
        new_block->payload = get_payload(new_block);
  100c3e:	4d 89 65 10          	mov    %r12,0x10(%r13)
        split(new_sz, new_block->size, new_block);
  100c42:	4c 89 ea             	mov    %r13,%rdx
  100c45:	4c 89 f6             	mov    %r14,%rsi
  100c48:	48 89 df             	mov    %rbx,%rdi
  100c4b:	e8 c8 fe ff ff       	callq  100b18 <split>
        return get_payload(new_block);
  100c50:	eb 96                	jmp    100be8 <malloc+0x5a>

0000000000100c52 <calloc>:
// to the allocated array. The memory is set to 0. if num or sz is equal to 0, then calloc
// returns NULL or a unique pointer value that can be successfully passed to a later free
// calloc also checks for size overflow caused by num*sz
// returns NULL on failure
void * calloc(uint64_t num, uint64_t sz)
{
  100c52:	55                   	push   %rbp
  100c53:	48 89 e5             	mov    %rsp,%rbp
  100c56:	41 54                	push   %r12
  100c58:	53                   	push   %rbx
    // initialize ptr
    void* ptr = NULL;

    // if num or sz is equal to 0, then calloc returns NULL
    if (num == 0 || sz == 0)
  100c59:	48 85 ff             	test   %rdi,%rdi
  100c5c:	74 4c                	je     100caa <calloc+0x58>
  100c5e:	48 89 f3             	mov    %rsi,%rbx
  100c61:	48 85 f6             	test   %rsi,%rsi
  100c64:	74 44                	je     100caa <calloc+0x58>
    {
        return NULL;
    }
     
    // check for overflow
    if ((sz > 0) && (num > MY_INT_MAX/sz))
  100c66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100c6b:	ba 00 00 00 00       	mov    $0x0,%edx
  100c70:	48 f7 f6             	div    %rsi
    {
        /* Oh no, overflow */
        ptr = NULL;
  100c73:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if ((sz > 0) && (num > MY_INT_MAX/sz))
  100c79:	48 39 f8             	cmp    %rdi,%rax
  100c7c:	72 24                	jb     100ca2 <calloc+0x50>
    }
    else
    {
        // allocates memory of an array of num elements of size sz bytes
        ptr = malloc(num * sz);
  100c7e:	48 0f af df          	imul   %rdi,%rbx
  100c82:	48 89 df             	mov    %rbx,%rdi
  100c85:	e8 04 ff ff ff       	callq  100b8e <malloc>
  100c8a:	49 89 c4             	mov    %rax,%r12
    }

    if (ptr) 
  100c8d:	48 85 c0             	test   %rax,%rax
  100c90:	74 10                	je     100ca2 <calloc+0x50>
    {
        // The memory is set to 0
        memset(ptr, 0, num * sz);
  100c92:	48 89 da             	mov    %rbx,%rdx
  100c95:	be 00 00 00 00       	mov    $0x0,%esi
  100c9a:	48 89 c7             	mov    %rax,%rdi
  100c9d:	e8 d9 f4 ff ff       	callq  10017b <memset>
    }

    // returns a pointer to the allocated array
    return ptr;
}
  100ca2:	4c 89 e0             	mov    %r12,%rax
  100ca5:	5b                   	pop    %rbx
  100ca6:	41 5c                	pop    %r12
  100ca8:	5d                   	pop    %rbp
  100ca9:	c3                   	retq   
        return NULL;
  100caa:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100cb0:	eb f0                	jmp    100ca2 <calloc+0x50>

0000000000100cb2 <free>:
// undefined behavior occurs
// if ptr == NULL, then no operation happens
void free(void * ptr)
{
    // if ptr == NULL, then no operation happens
    if (ptr == NULL)
  100cb2:	48 85 ff             	test   %rdi,%rdi
  100cb5:	74 0c                	je     100cc3 <free+0x11>
    {
        return;
    }

    free_list *current = head;
  100cb7:	48 8b 05 52 13 00 00 	mov    0x1352(%rip),%rax        # 102010 <head>

    while (current)
  100cbe:	48 85 c0             	test   %rax,%rax
  100cc1:	75 0a                	jne    100ccd <free+0x1b>

            return;
        }
        current = current->next;
    }
}
  100cc3:	c3                   	retq   
        current = current->next;
  100cc4:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (current)
  100cc8:	48 85 c0             	test   %rax,%rax
  100ccb:	74 f6                	je     100cc3 <free+0x11>
        if (current->payload == ptr && current->free == 1)
  100ccd:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  100cd1:	75 f1                	jne    100cc4 <free+0x12>
  100cd3:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100cd7:	75 eb                	jne    100cc4 <free+0x12>
            current->free = 0;
  100cd9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
            return;
  100ce0:	c3                   	retq   

0000000000100ce1 <realloc>:
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz)
{
  100ce1:	55                   	push   %rbp
  100ce2:	48 89 e5             	mov    %rsp,%rbp
  100ce5:	41 54                	push   %r12
  100ce7:	53                   	push   %rbx
    // if ptr is NULL
    if (ptr == NULL)
  100ce8:	48 85 ff             	test   %rdi,%rdi
  100ceb:	74 56                	je     100d43 <realloc+0x62>
  100ced:	48 89 fb             	mov    %rdi,%rbx

        return temp;
    }

    // if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
    if (sz == 0 && ptr != NULL)
  100cf0:	48 85 f6             	test   %rsi,%rsi
  100cf3:	74 5b                	je     100d50 <realloc+0x6f>
    free_list *header = get_header(ptr);

    // we have to check that we are expanding the block
    if (sz < header->size)
    {
        return ptr;
  100cf5:	49 89 fc             	mov    %rdi,%r12
    if (sz < header->size)
  100cf8:	48 39 b7 c0 f9 ff ff 	cmp    %rsi,-0x640(%rdi)
  100cff:	77 3a                	ja     100d3b <realloc+0x5a>

    // check for overflow
    if ((METADATA > 0) && (sz > MY_INT_MAX - METADATA))
    {
        /* Oh no, overflow */
        return NULL;
  100d01:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if ((METADATA > 0) && (sz > MY_INT_MAX - METADATA))
  100d07:	b8 d7 ff ff ff       	mov    $0xffffffd7,%eax
  100d0c:	48 39 c6             	cmp    %rax,%rsi
  100d0f:	77 2a                	ja     100d3b <realloc+0x5a>

    // what is the new size we require? sz; metadata
    uint64_t new_sz = ALIGN(sz + METADATA);

    // initialize new location
    free_list *new_loc = malloc(sz);
  100d11:	48 89 f7             	mov    %rsi,%rdi
  100d14:	e8 75 fe ff ff       	callq  100b8e <malloc>
  100d19:	49 89 c4             	mov    %rax,%r12
    if (new_loc == NULL)
  100d1c:	48 85 c0             	test   %rax,%rax
  100d1f:	74 1a                	je     100d3b <realloc+0x5a>
    {
        return NULL;
    }

    // move data over
    memcpy(new_loc, ptr, header->size);
  100d21:	48 8b 93 c0 f9 ff ff 	mov    -0x640(%rbx),%rdx
  100d28:	48 89 de             	mov    %rbx,%rsi
  100d2b:	48 89 c7             	mov    %rax,%rdi
  100d2e:	e8 df f3 ff ff       	callq  100112 <memcpy>

    // free current ptr
    free(ptr);
  100d33:	48 89 df             	mov    %rbx,%rdi
  100d36:	e8 77 ff ff ff       	callq  100cb2 <free>

    return new_loc;
}
  100d3b:	4c 89 e0             	mov    %r12,%rax
  100d3e:	5b                   	pop    %rbx
  100d3f:	41 5c                	pop    %r12
  100d41:	5d                   	pop    %rbp
  100d42:	c3                   	retq   
        void *temp = malloc(sz);
  100d43:	48 89 f7             	mov    %rsi,%rdi
  100d46:	e8 43 fe ff ff       	callq  100b8e <malloc>
  100d4b:	49 89 c4             	mov    %rax,%r12
        return temp;
  100d4e:	eb eb                	jmp    100d3b <realloc+0x5a>
        free(ptr);
  100d50:	e8 5d ff ff ff       	callq  100cb2 <free>
        return NULL;
  100d55:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100d5b:	eb de                	jmp    100d3b <realloc+0x5a>

0000000000100d5d <defrag>:

// coalesce adjacent blocks of free memory together into a single block.
void defrag()
{
    // initialize iterator
    free_list *current = head;
  100d5d:	48 8b 05 ac 12 00 00 	mov    0x12ac(%rip),%rax        # 102010 <head>

    while (current != NULL)
  100d64:	48 85 c0             	test   %rax,%rax
  100d67:	75 15                	jne    100d7e <defrag+0x21>
                //remove_block(current->next);
            }
        }
        current = current->next;
    }
}
  100d69:	c3                   	retq   
                current->size += next_sz;
  100d6a:	48 8b 0a             	mov    (%rdx),%rcx
  100d6d:	48 01 08             	add    %rcx,(%rax)
        current = current->next;
  100d70:	48 89 d0             	mov    %rdx,%rax
  100d73:	eb 09                	jmp    100d7e <defrag+0x21>
  100d75:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (current != NULL)
  100d79:	48 85 c0             	test   %rax,%rax
  100d7c:	74 2c                	je     100daa <defrag+0x4d>
        if (current->free == 0 && current->next && current->next->free == 0)
  100d7e:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100d82:	75 f1                	jne    100d75 <defrag+0x18>
  100d84:	48 8b 50 18          	mov    0x18(%rax),%rdx
  100d88:	48 85 d2             	test   %rdx,%rdx
  100d8b:	74 dc                	je     100d69 <defrag+0xc>
  100d8d:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  100d91:	75 dd                	jne    100d70 <defrag+0x13>
            if (current->prev != NULL && current->prev->free == 0)
  100d93:	48 8b 48 20          	mov    0x20(%rax),%rcx
  100d97:	48 85 c9             	test   %rcx,%rcx
  100d9a:	74 ce                	je     100d6a <defrag+0xd>
  100d9c:	83 79 08 00          	cmpl   $0x0,0x8(%rcx)
  100da0:	75 c8                	jne    100d6a <defrag+0xd>
                current->prev->size += current->size;
  100da2:	48 8b 10             	mov    (%rax),%rdx
  100da5:	48 01 11             	add    %rdx,(%rcx)
  100da8:	eb cb                	jmp    100d75 <defrag+0x18>
  100daa:	c3                   	retq   

0000000000100dab <swap>:
/* function adapted with guidance from https://www.youtube.com/watch?v=7h1s2SojIRw */

// swap two elements 
void swap(long* a, long* b) 
{ 
    long t = *a; 
  100dab:	48 8b 07             	mov    (%rdi),%rax
    *a = *b; 
  100dae:	48 8b 16             	mov    (%rsi),%rdx
  100db1:	48 89 17             	mov    %rdx,(%rdi)
    *b = t; 
  100db4:	48 89 06             	mov    %rax,(%rsi)
}
  100db7:	c3                   	retq   

0000000000100db8 <ptr_swap>:

// swap two elements 
void ptr_swap(void** a, void** b) 
{ 
    void* t = *a; 
  100db8:	48 8b 07             	mov    (%rdi),%rax
    *a = *b; 
  100dbb:	48 8b 16             	mov    (%rsi),%rdx
  100dbe:	48 89 17             	mov    %rdx,(%rdi)
    *b = t; 
  100dc1:	48 89 06             	mov    %rax,(%rsi)
}
  100dc4:	c3                   	retq   

0000000000100dc5 <partition>:

/* function adapted with guidance from https://www.youtube.com/watch?v=7h1s2SojIRw */

int partition (long arr[], int low, int high, void**ptr_arr) 
{ 
  100dc5:	55                   	push   %rbp
  100dc6:	48 89 e5             	mov    %rsp,%rbp
  100dc9:	41 55                	push   %r13
  100dcb:	41 54                	push   %r12
  100dcd:	53                   	push   %rbx
    // pivot
    long pivot = arr[high];   
  100dce:	4c 63 da             	movslq %edx,%r11
  100dd1:	49 c1 e3 03          	shl    $0x3,%r11
  100dd5:	4a 8d 1c 1f          	lea    (%rdi,%r11,1),%rbx
  100dd9:	4c 8b 23             	mov    (%rbx),%r12

    // Index of smaller element 
    int i = (low - 1);  
  100ddc:	8d 46 ff             	lea    -0x1(%rsi),%eax
  
    for (int j = low; j <= high- 1; j++) 
  100ddf:	39 f2                	cmp    %esi,%edx
  100de1:	7e 41                	jle    100e24 <partition+0x5f>
  100de3:	48 63 f6             	movslq %esi,%rsi
  100de6:	eb 31                	jmp    100e19 <partition+0x54>
    { 
        // If current element is bigger than the pivot 
        if (arr[j] > pivot) 
        { 
            // increment index of smaller element 
            i++;    
  100de8:	83 c0 01             	add    $0x1,%eax
            swap(&arr[i], &arr[j]); 
  100deb:	4c 63 c0             	movslq %eax,%r8
  100dee:	49 c1 e0 03          	shl    $0x3,%r8
  100df2:	4e 8d 14 07          	lea    (%rdi,%r8,1),%r10
    long t = *a; 
  100df6:	4d 8b 2a             	mov    (%r10),%r13
    *a = *b; 
  100df9:	4d 89 0a             	mov    %r9,(%r10)
    *b = t; 
  100dfc:	4c 89 2c f7          	mov    %r13,(%rdi,%rsi,8)

            // swap ptr array as well
            ptr_swap(&ptr_arr[i], &ptr_arr[j]);
  100e00:	49 01 c8             	add    %rcx,%r8
    void* t = *a; 
  100e03:	4d 8b 08             	mov    (%r8),%r9
    *a = *b; 
  100e06:	4c 8b 14 f1          	mov    (%rcx,%rsi,8),%r10
  100e0a:	4d 89 10             	mov    %r10,(%r8)
    *b = t; 
  100e0d:	4c 89 0c f1          	mov    %r9,(%rcx,%rsi,8)
    for (int j = low; j <= high- 1; j++) 
  100e11:	48 83 c6 01          	add    $0x1,%rsi
  100e15:	39 f2                	cmp    %esi,%edx
  100e17:	7e 0b                	jle    100e24 <partition+0x5f>
        if (arr[j] > pivot) 
  100e19:	4c 8b 0c f7          	mov    (%rdi,%rsi,8),%r9
  100e1d:	4d 39 e1             	cmp    %r12,%r9
  100e20:	7e ef                	jle    100e11 <partition+0x4c>
  100e22:	eb c4                	jmp    100de8 <partition+0x23>
        } 
    } 
    swap(&arr[i + 1], &arr[high]); 
  100e24:	48 63 d0             	movslq %eax,%rdx
  100e27:	48 8d 34 d5 08 00 00 	lea    0x8(,%rdx,8),%rsi
  100e2e:	00 
  100e2f:	48 01 f7             	add    %rsi,%rdi
    long t = *a; 
  100e32:	48 8b 17             	mov    (%rdi),%rdx
    *a = *b; 
  100e35:	4c 8b 03             	mov    (%rbx),%r8
  100e38:	4c 89 07             	mov    %r8,(%rdi)
    *b = t; 
  100e3b:	48 89 13             	mov    %rdx,(%rbx)

    // swap ptr array as well
    ptr_swap(&ptr_arr[i+1], &ptr_arr[high]);
  100e3e:	4a 8d 14 19          	lea    (%rcx,%r11,1),%rdx
  100e42:	48 01 f1             	add    %rsi,%rcx
    void* t = *a; 
  100e45:	48 8b 31             	mov    (%rcx),%rsi
    *a = *b; 
  100e48:	48 8b 3a             	mov    (%rdx),%rdi
  100e4b:	48 89 39             	mov    %rdi,(%rcx)
    *b = t; 
  100e4e:	48 89 32             	mov    %rsi,(%rdx)

    return (i + 1); 
  100e51:	83 c0 01             	add    $0x1,%eax
} 
  100e54:	5b                   	pop    %rbx
  100e55:	41 5c                	pop    %r12
  100e57:	41 5d                	pop    %r13
  100e59:	5d                   	pop    %rbp
  100e5a:	c3                   	retq   

0000000000100e5b <quickSort>:

/* function adapted with guidance from https://www.youtube.com/watch?v=7h1s2SojIRw */

void quickSort(long arr[], int low, int high, void **ptr_arr) 
{ 
    if (low < high) 
  100e5b:	39 d6                	cmp    %edx,%esi
  100e5d:	7c 01                	jl     100e60 <quickSort+0x5>
  100e5f:	c3                   	retq   
{ 
  100e60:	55                   	push   %rbp
  100e61:	48 89 e5             	mov    %rsp,%rbp
  100e64:	41 57                	push   %r15
  100e66:	41 56                	push   %r14
  100e68:	41 55                	push   %r13
  100e6a:	41 54                	push   %r12
  100e6c:	53                   	push   %rbx
  100e6d:	48 83 ec 08          	sub    $0x8,%rsp
  100e71:	49 89 fd             	mov    %rdi,%r13
  100e74:	41 89 f4             	mov    %esi,%r12d
  100e77:	89 d3                	mov    %edx,%ebx
  100e79:	49 89 cf             	mov    %rcx,%r15
    { 
        /* pi is partitioning index, arr[p] is now 
           at right place */
        int pi = partition(arr, low, high, ptr_arr); 
  100e7c:	e8 44 ff ff ff       	callq  100dc5 <partition>
  100e81:	41 89 c6             	mov    %eax,%r14d
  
        // Separately sort elements before 
        // partition and after partition 
        quickSort(arr, low, pi - 1, ptr_arr); 
  100e84:	8d 50 ff             	lea    -0x1(%rax),%edx
  100e87:	4c 89 f9             	mov    %r15,%rcx
  100e8a:	44 89 e6             	mov    %r12d,%esi
  100e8d:	4c 89 ef             	mov    %r13,%rdi
  100e90:	e8 c6 ff ff ff       	callq  100e5b <quickSort>
        quickSort(arr, pi + 1, high, ptr_arr); 
  100e95:	41 8d 76 01          	lea    0x1(%r14),%esi
  100e99:	4c 89 f9             	mov    %r15,%rcx
  100e9c:	89 da                	mov    %ebx,%edx
  100e9e:	4c 89 ef             	mov    %r13,%rdi
  100ea1:	e8 b5 ff ff ff       	callq  100e5b <quickSort>
    } 
} 
  100ea6:	48 83 c4 08          	add    $0x8,%rsp
  100eaa:	5b                   	pop    %rbx
  100eab:	41 5c                	pop    %r12
  100ead:	41 5d                	pop    %r13
  100eaf:	41 5e                	pop    %r14
  100eb1:	41 5f                	pop    %r15
  100eb3:	5d                   	pop    %rbp
  100eb4:	c3                   	retq   

0000000000100eb5 <heap_info>:
// note that the allocations used by the heap_info_struct will count as metadata
// and should NOT be included in the heap info
// return 0 for a successfull call
// if for any reason the information cannot be saved, return -1
int heap_info(heap_info_struct * info)
{
  100eb5:	55                   	push   %rbp
  100eb6:	48 89 e5             	mov    %rsp,%rbp
  100eb9:	41 56                	push   %r14
  100ebb:	41 55                	push   %r13
  100ebd:	41 54                	push   %r12
  100ebf:	53                   	push   %rbx
  100ec0:	48 83 ec 10          	sub    $0x10,%rsp
  100ec4:	49 89 fc             	mov    %rdi,%r12
    long *size_array = NULL;           // an array of longs that store the sizes of the currently allocated sites in descending order
    void **ptr_array = NULL;        // an array of void ptrs that store the ptrs of the currently allocated sites in descending order
    int free_space = 0;             // amount of free space in bytes that are currently available within the heap
    int largest_free_chunk = 0;     // largest chunk of free space that is currently available within the heap.

    free_list *index = head;
  100ec7:	48 8b 05 42 11 00 00 	mov    0x1142(%rip),%rax        # 102010 <head>
    int num_allocs = 0;             // number of currently allocated sites
  100ece:	bb 00 00 00 00       	mov    $0x0,%ebx

    // fill in size array values
    while (index != NULL && index->free == 1)
  100ed3:	48 85 c0             	test   %rax,%rax
  100ed6:	0f 84 36 01 00 00    	je     101012 <heap_info+0x15d>
  100edc:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100ee0:	75 0c                	jne    100eee <heap_info+0x39>
    {
        // update size array and ptr_array
        num_allocs++;
  100ee2:	83 c3 01             	add    $0x1,%ebx

        index = index->next;
  100ee5:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (index != NULL && index->free == 1)
  100ee9:	48 85 c0             	test   %rax,%rax
  100eec:	75 ee                	jne    100edc <heap_info+0x27>
    }

    // set the num_allocs
    info->num_allocs = num_allocs;
  100eee:	41 89 1c 24          	mov    %ebx,(%r12)

    // loop through list to find free space

    //initialize iterator
    free_list *current = head;
  100ef2:	48 8b 15 17 11 00 00 	mov    0x1117(%rip),%rdx        # 102010 <head>

    uint64_t max_space = 0;
    // search for free block
    while (current != NULL && current->free == 0)
  100ef9:	48 85 d2             	test   %rdx,%rdx
  100efc:	74 37                	je     100f35 <heap_info+0x80>
    uint64_t max_space = 0;
  100efe:	be 00 00 00 00       	mov    $0x0,%esi
    int largest_free_chunk = 0;     // largest chunk of free space that is currently available within the heap.
  100f03:	bf 00 00 00 00       	mov    $0x0,%edi
    int free_space = 0;             // amount of free space in bytes that are currently available within the heap
  100f08:	b9 00 00 00 00       	mov    $0x0,%ecx
  100f0d:	eb 09                	jmp    100f18 <heap_info+0x63>
            max_space = current->size - METADATA;
            // update largest_free_chunk
            largest_free_chunk = max_space;
        }
        
        current = current->next;
  100f0f:	48 8b 52 18          	mov    0x18(%rdx),%rdx
    while (current != NULL && current->free == 0)
  100f13:	48 85 d2             	test   %rdx,%rdx
  100f16:	74 27                	je     100f3f <heap_info+0x8a>
  100f18:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  100f1c:	75 21                	jne    100f3f <heap_info+0x8a>
        free_space += current->size - METADATA;
  100f1e:	48 8b 02             	mov    (%rdx),%rax
  100f21:	8d 4c 01 d8          	lea    -0x28(%rcx,%rax,1),%ecx
        if (current->size - METADATA > max_space)
  100f25:	48 83 e8 28          	sub    $0x28,%rax
  100f29:	48 39 f0             	cmp    %rsi,%rax
  100f2c:	76 e1                	jbe    100f0f <heap_info+0x5a>
            largest_free_chunk = max_space;
  100f2e:	89 c7                	mov    %eax,%edi
            max_space = current->size - METADATA;
  100f30:	48 89 c6             	mov    %rax,%rsi
  100f33:	eb da                	jmp    100f0f <heap_info+0x5a>
    int largest_free_chunk = 0;     // largest chunk of free space that is currently available within the heap.
  100f35:	bf 00 00 00 00       	mov    $0x0,%edi
    int free_space = 0;             // amount of free space in bytes that are currently available within the heap
  100f3a:	b9 00 00 00 00       	mov    $0x0,%ecx
    }

    // update free space
    info->free_space = free_space;
  100f3f:	41 89 4c 24 18       	mov    %ecx,0x18(%r12)

    // update largest_free_chunk
    info->largest_free_chunk = largest_free_chunk;  
  100f44:	41 89 7c 24 1c       	mov    %edi,0x1c(%r12)

    if (num_allocs == 0)
  100f49:	85 db                	test   %ebx,%ebx
  100f4b:	75 24                	jne    100f71 <heap_info+0xbc>
    {
        // update info struct
        info->size_array = size_array;
  100f4d:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  100f54:	00 00 
        info->ptr_array = ptr_array;
  100f56:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  100f5d:	00 00 

        return 0;
  100f5f:	b8 00 00 00 00       	mov    $0x0,%eax

    // set heap info flag
    if_heap_info = 0;

    return 0;
}
  100f64:	48 83 c4 10          	add    $0x10,%rsp
  100f68:	5b                   	pop    %rbx
  100f69:	41 5c                	pop    %r12
  100f6b:	41 5d                	pop    %r13
  100f6d:	41 5e                	pop    %r14
  100f6f:	5d                   	pop    %rbp
  100f70:	c3                   	retq   
    if_heap_info = 1;
  100f71:	c7 05 8d 10 00 00 01 	movl   $0x1,0x108d(%rip)        # 102008 <if_heap_info>
  100f78:	00 00 00 
    size_array = malloc((uint64_t)num_allocs);
  100f7b:	4c 63 f3             	movslq %ebx,%r14
  100f7e:	4c 89 f7             	mov    %r14,%rdi
  100f81:	e8 08 fc ff ff       	callq  100b8e <malloc>
  100f86:	49 89 c5             	mov    %rax,%r13
    if (!size_array)
  100f89:	48 85 c0             	test   %rax,%rax
  100f8c:	74 7a                	je     101008 <heap_info+0x153>
    void *ptr_temp = malloc((uint64_t)num_allocs);
  100f8e:	4c 89 f7             	mov    %r14,%rdi
  100f91:	e8 f8 fb ff ff       	callq  100b8e <malloc>
  100f96:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    free_list *curr = head;
  100f9a:	48 8b 05 6f 10 00 00 	mov    0x106f(%rip),%rax        # 102010 <head>
    while (curr != NULL && curr->free == 1)
  100fa1:	ba 00 00 00 00       	mov    $0x0,%edx
  100fa6:	48 85 c0             	test   %rax,%rax
  100fa9:	74 28                	je     100fd3 <heap_info+0x11e>
  100fab:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100faf:	75 22                	jne    100fd3 <heap_info+0x11e>
        size_array[j] = curr->size - METADATA;
  100fb1:	48 8b 38             	mov    (%rax),%rdi
  100fb4:	48 8d 4f d8          	lea    -0x28(%rdi),%rcx
  100fb8:	49 89 4c 15 00       	mov    %rcx,0x0(%r13,%rdx,1)
        ptr_array[j] = curr->payload; 
  100fbd:	48 8b 48 10          	mov    0x10(%rax),%rcx
  100fc1:	48 89 4c 15 d8       	mov    %rcx,-0x28(%rbp,%rdx,1)
        curr = curr->next;
  100fc6:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr != NULL && curr->free == 1)
  100fca:	48 83 c2 08          	add    $0x8,%rdx
  100fce:	48 85 c0             	test   %rax,%rax
  100fd1:	75 d8                	jne    100fab <heap_info+0xf6>
    quickSort(size_array, 0, num_allocs-1, ptr_array);
  100fd3:	4c 8d 75 d8          	lea    -0x28(%rbp),%r14
  100fd7:	8d 53 ff             	lea    -0x1(%rbx),%edx
  100fda:	4c 89 f1             	mov    %r14,%rcx
  100fdd:	be 00 00 00 00       	mov    $0x0,%esi
  100fe2:	4c 89 ef             	mov    %r13,%rdi
  100fe5:	e8 71 fe ff ff       	callq  100e5b <quickSort>
    info->size_array = size_array;
  100fea:	4d 89 6c 24 08       	mov    %r13,0x8(%r12)
    info->ptr_array = ptr_array;
  100fef:	4d 89 74 24 10       	mov    %r14,0x10(%r12)
    if_heap_info = 0;
  100ff4:	c7 05 0a 10 00 00 00 	movl   $0x0,0x100a(%rip)        # 102008 <if_heap_info>
  100ffb:	00 00 00 
    return 0;
  100ffe:	b8 00 00 00 00       	mov    $0x0,%eax
  101003:	e9 5c ff ff ff       	jmpq   100f64 <heap_info+0xaf>
        return -1;
  101008:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10100d:	e9 52 ff ff ff       	jmpq   100f64 <heap_info+0xaf>
    info->num_allocs = num_allocs;
  101012:	c7 07 00 00 00 00    	movl   $0x0,(%rdi)
    free_list *current = head;
  101018:	48 8b 15 f1 0f 00 00 	mov    0xff1(%rip),%rdx        # 102010 <head>
    int num_allocs = 0;             // number of currently allocated sites
  10101f:	bb 00 00 00 00       	mov    $0x0,%ebx
    while (current != NULL && current->free == 0)
  101024:	48 85 d2             	test   %rdx,%rdx
  101027:	0f 85 d1 fe ff ff    	jne    100efe <heap_info+0x49>
    info->free_space = free_space;
  10102d:	41 c7 44 24 18 00 00 	movl   $0x0,0x18(%r12)
  101034:	00 00 
    info->largest_free_chunk = largest_free_chunk;  
  101036:	41 c7 44 24 1c 00 00 	movl   $0x0,0x1c(%r12)
  10103d:	00 00 
    if (num_allocs == 0)
  10103f:	e9 09 ff ff ff       	jmpq   100f4d <heap_info+0x98>
