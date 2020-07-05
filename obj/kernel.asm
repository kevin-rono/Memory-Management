
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	pushq  $0x0
        popfq
   4000c:	9d                   	popfq  
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmpq   40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	pushq  $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	pushq  $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	pushq  $0x0
        pushq $32
   40038:	6a 20                	pushq  $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	pushq  $0x0
        pushq $48
   4003e:	6a 30                	pushq  $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	pushq  $0x0
        pushq $49
   40044:	6a 31                	pushq  $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	pushq  $0x0
        pushq $50
   4004a:	6a 32                	pushq  $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	pushq  $0x0
        pushq $51
   40050:	6a 33                	pushq  $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	pushq  $0x0
        pushq $52
   40056:	6a 34                	pushq  $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	pushq  $0x0
        pushq $53
   4005c:	6a 35                	pushq  $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	pushq  $0x0
        pushq $54
   40062:	6a 36                	pushq  $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	pushq  $0x0
        pushq $55
   40068:	6a 37                	pushq  $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	pushq  $0x0
        pushq $56
   4006e:	6a 38                	pushq  $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	pushq  $0x0
        pushq $57
   40074:	6a 39                	pushq  $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	pushq  $0x0
        pushq $58
   4007a:	6a 3a                	pushq  $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	pushq  $0x0
        pushq $59
   40080:	6a 3b                	pushq  $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	pushq  $0x0
        pushq $60
   40086:	6a 3c                	pushq  $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	pushq  $0x0
        pushq $61
   4008c:	6a 3d                	pushq  $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	pushq  $0x0
        pushq $62
   40092:	6a 3e                	pushq  $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	pushq  $0x0
        pushq $63
   40098:	6a 3f                	pushq  $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	pushq  $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	pushq  %gs
        pushq %fs
   400a2:	0f a0                	pushq  %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 3f 07 00 00       	callq  40802 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	popq   %fs
        popq %gs
   400df:	0f a9                	popq   %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 08 16 00 00       	callq  41780 <hardware_init>
    pageinfo_init();
   40178:	e8 36 0c 00 00       	callq  40db3 <pageinfo_init>
    console_clear();
   4017d:	e8 98 3a 00 00       	callq  43c1a <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 c8 1a 00 00       	callq  41c54 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 20 a0 05 00       	mov    $0x5a020,%edi
   4019b:	e8 85 31 00 00       	callq  43325 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 20 a0 05 00 	lea    0x5a020(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 26                	je     40220 <kernel+0xb9>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be a6 47 04 00       	mov    $0x447a6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 87 31 00 00       	callq  43392 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 11                	jne    40220 <kernel+0xb9>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 75 00 00 00       	callq  40293 <process_setup>
   4021e:	eb 69                	jmp    40289 <kernel+0x122>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40220:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40225:	74 26                	je     4024d <kernel+0xe6>
   40227:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022b:	be ad 47 04 00       	mov    $0x447ad,%esi
   40230:	48 89 c7             	mov    %rax,%rdi
   40233:	e8 5a 31 00 00       	callq  43392 <strcmp>
   40238:	85 c0                	test   %eax,%eax
   4023a:	75 11                	jne    4024d <kernel+0xe6>
        process_setup(1, 5);
   4023c:	be 05 00 00 00       	mov    $0x5,%esi
   40241:	bf 01 00 00 00       	mov    $0x1,%edi
   40246:	e8 48 00 00 00       	callq  40293 <process_setup>
   4024b:	eb 3c                	jmp    40289 <kernel+0x122>
    } else if (command && strcmp(command, "test") == 0){
   4024d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40252:	74 26                	je     4027a <kernel+0x113>
   40254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40258:	be b8 47 04 00       	mov    $0x447b8,%esi
   4025d:	48 89 c7             	mov    %rax,%rdi
   40260:	e8 2d 31 00 00       	callq  43392 <strcmp>
   40265:	85 c0                	test   %eax,%eax
   40267:	75 11                	jne    4027a <kernel+0x113>
        process_setup(1, 6);
   40269:	be 06 00 00 00       	mov    $0x6,%esi
   4026e:	bf 01 00 00 00       	mov    $0x1,%edi
   40273:	e8 1b 00 00 00       	callq  40293 <process_setup>
   40278:	eb 0f                	jmp    40289 <kernel+0x122>
    } else {
    process_setup(1, 0);
   4027a:	be 00 00 00 00       	mov    $0x0,%esi
   4027f:	bf 01 00 00 00       	mov    $0x1,%edi
   40284:	e8 0a 00 00 00       	callq  40293 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   40289:	bf 10 a1 05 00       	mov    $0x5a110,%edi
   4028e:	e8 8f 0a 00 00       	callq  40d22 <run>

0000000000040293 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40293:	55                   	push   %rbp
   40294:	48 89 e5             	mov    %rsp,%rbp
   40297:	48 83 ec 10          	sub    $0x10,%rsp
   4029b:	89 7d fc             	mov    %edi,-0x4(%rbp)
   4029e:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402a4:	48 63 d0             	movslq %eax,%rdx
   402a7:	48 89 d0             	mov    %rdx,%rax
   402aa:	48 c1 e0 04          	shl    $0x4,%rax
   402ae:	48 29 d0             	sub    %rdx,%rax
   402b1:	48 c1 e0 04          	shl    $0x4,%rax
   402b5:	48 05 20 a0 05 00    	add    $0x5a020,%rax
   402bb:	be 00 00 00 00       	mov    $0x0,%esi
   402c0:	48 89 c7             	mov    %rax,%rdi
   402c3:	e8 e3 22 00 00       	callq  425ab <process_init>

    assert(process_config_tables(pid) == 0);
   402c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402cb:	89 c7                	mov    %eax,%edi
   402cd:	e8 66 3d 00 00       	callq  44038 <process_config_tables>
   402d2:	85 c0                	test   %eax,%eax
   402d4:	74 14                	je     402ea <process_setup+0x57>
   402d6:	ba c0 47 04 00       	mov    $0x447c0,%edx
   402db:	be 6b 00 00 00       	mov    $0x6b,%esi
   402e0:	bf e0 47 04 00       	mov    $0x447e0,%edi
   402e5:	e8 ff 2a 00 00       	callq  42de9 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   402ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402ed:	48 63 d0             	movslq %eax,%rdx
   402f0:	48 89 d0             	mov    %rdx,%rax
   402f3:	48 c1 e0 04          	shl    $0x4,%rax
   402f7:	48 29 d0             	sub    %rdx,%rax
   402fa:	48 c1 e0 04          	shl    $0x4,%rax
   402fe:	48 8d 90 20 a0 05 00 	lea    0x5a020(%rax),%rdx
   40305:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40308:	89 c6                	mov    %eax,%esi
   4030a:	48 89 d7             	mov    %rdx,%rdi
   4030d:	e8 74 40 00 00       	callq  44386 <process_load>
   40312:	85 c0                	test   %eax,%eax
   40314:	79 14                	jns    4032a <process_setup+0x97>
   40316:	ba f0 47 04 00       	mov    $0x447f0,%edx
   4031b:	be 6e 00 00 00       	mov    $0x6e,%esi
   40320:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40325:	e8 bf 2a 00 00       	callq  42de9 <assert_fail>

    process_setup_stack(&processes[pid]);
   4032a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4032d:	48 63 d0             	movslq %eax,%rdx
   40330:	48 89 d0             	mov    %rdx,%rax
   40333:	48 c1 e0 04          	shl    $0x4,%rax
   40337:	48 29 d0             	sub    %rdx,%rax
   4033a:	48 c1 e0 04          	shl    $0x4,%rax
   4033e:	48 05 20 a0 05 00    	add    $0x5a020,%rax
   40344:	48 89 c7             	mov    %rax,%rdi
   40347:	e8 72 40 00 00       	callq  443be <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4034c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4034f:	48 63 d0             	movslq %eax,%rdx
   40352:	48 89 d0             	mov    %rdx,%rax
   40355:	48 c1 e0 04          	shl    $0x4,%rax
   40359:	48 29 d0             	sub    %rdx,%rax
   4035c:	48 c1 e0 04          	shl    $0x4,%rax
   40360:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   40366:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   4036c:	90                   	nop
   4036d:	c9                   	leaveq 
   4036e:	c3                   	retq   

000000000004036f <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   4036f:	55                   	push   %rbp
   40370:	48 89 e5             	mov    %rsp,%rbp
   40373:	48 83 ec 10          	sub    $0x10,%rsp
   40377:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4037b:	89 f0                	mov    %esi,%eax
   4037d:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40380:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40384:	25 ff 0f 00 00       	and    $0xfff,%eax
   40389:	48 85 c0             	test   %rax,%rax
   4038c:	75 20                	jne    403ae <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   4038e:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40395:	00 
   40396:	77 16                	ja     403ae <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4039c:	48 c1 e8 0c          	shr    $0xc,%rax
   403a0:	48 98                	cltq   
   403a2:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   403a9:	00 
   403aa:	84 c0                	test   %al,%al
   403ac:	74 07                	je     403b5 <assign_physical_page+0x46>
        return -1;
   403ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403b3:	eb 2c                	jmp    403e1 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403b9:	48 c1 e8 0c          	shr    $0xc,%rax
   403bd:	48 98                	cltq   
   403bf:	c6 84 00 41 af 05 00 	movb   $0x1,0x5af41(%rax,%rax,1)
   403c6:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   403c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403cb:	48 c1 e8 0c          	shr    $0xc,%rax
   403cf:	48 98                	cltq   
   403d1:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   403d5:	88 94 00 40 af 05 00 	mov    %dl,0x5af40(%rax,%rax,1)
        return 0;
   403dc:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   403e1:	c9                   	leaveq 
   403e2:	c3                   	retq   

00000000000403e3 <syscall_fork>:


pid_t syscall_fork() {
   403e3:	55                   	push   %rbp
   403e4:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   403e7:	48 8b 05 32 ab 01 00 	mov    0x1ab32(%rip),%rax        # 5af20 <current>
   403ee:	48 89 c7             	mov    %rax,%rdi
   403f1:	e8 7b 40 00 00       	callq  44471 <process_fork>
}
   403f6:	5d                   	pop    %rbp
   403f7:	c3                   	retq   

00000000000403f8 <syscall_exit>:


void syscall_exit() {
   403f8:	55                   	push   %rbp
   403f9:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   403fc:	48 8b 05 1d ab 01 00 	mov    0x1ab1d(%rip),%rax        # 5af20 <current>
   40403:	8b 00                	mov    (%rax),%eax
   40405:	89 c7                	mov    %eax,%edi
   40407:	e8 4a 39 00 00       	callq  43d56 <process_free>
}
   4040c:	90                   	nop
   4040d:	5d                   	pop    %rbp
   4040e:	c3                   	retq   

000000000004040f <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   4040f:	55                   	push   %rbp
   40410:	48 89 e5             	mov    %rsp,%rbp
   40413:	48 83 ec 10          	sub    $0x10,%rsp
   40417:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4041b:	48 8b 05 fe aa 01 00 	mov    0x1aafe(%rip),%rax        # 5af20 <current>
   40422:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40426:	48 89 d6             	mov    %rdx,%rsi
   40429:	48 89 c7             	mov    %rax,%rdi
   4042c:	e8 d2 42 00 00       	callq  44703 <process_page_alloc>
}
   40431:	c9                   	leaveq 
   40432:	c3                   	retq   

0000000000040433 <syscall_read_serial>:


int syscall_read_serial(proc * p) {
   40433:	55                   	push   %rbp
   40434:	48 89 e5             	mov    %rsp,%rbp
   40437:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
   4043e:	48 89 bd 48 ff ff ff 	mov    %rdi,-0xb8(%rbp)
    uintptr_t addr = p->p_registers.reg_rdi;
   40445:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
   4044c:	48 8b 40 48          	mov    0x48(%rax),%rax
   40450:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   40454:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
   4045b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40462:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40466:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4046a:	48 89 ce             	mov    %rcx,%rsi
   4046d:	48 89 c7             	mov    %rax,%rdi
   40470:	e8 49 1d 00 00       	callq  421be <virtual_memory_lookup>
    char str[128];
    for(int  i = 0 ; i < 128 ; i++){
   40475:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4047c:	eb 56                	jmp    404d4 <syscall_read_serial+0xa1>
    int ret = 0;
   4047e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    while((ret = scan_port(str + i)) == 0);
   40485:	90                   	nop
   40486:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40489:	48 98                	cltq   
   4048b:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
   40492:	48 01 d0             	add    %rdx,%rax
   40495:	48 89 c7             	mov    %rax,%rdi
   40498:	e8 82 25 00 00       	callq  42a1f <scan_port>
   4049d:	89 45 ec             	mov    %eax,-0x14(%rbp)
   404a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   404a4:	74 e0                	je     40486 <syscall_read_serial+0x53>
    if(ret == -1){
   404a6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   404aa:	75 24                	jne    404d0 <syscall_read_serial+0x9d>
        memcpy((void *)map.pa, str, i);
   404ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   404af:	48 63 d0             	movslq %eax,%rdx
   404b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404b6:	48 89 c1             	mov    %rax,%rcx
   404b9:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   404c0:	48 89 c6             	mov    %rax,%rsi
   404c3:	48 89 cf             	mov    %rcx,%rdi
   404c6:	e8 f1 2d 00 00       	callq  432bc <memcpy>
        return i;
   404cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   404ce:	eb 2d                	jmp    404fd <syscall_read_serial+0xca>
    for(int  i = 0 ; i < 128 ; i++){
   404d0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   404d4:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   404d8:	7e a4                	jle    4047e <syscall_read_serial+0x4b>
    }
    }
    memcpy((void *)map.pa, str, 128);
   404da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404de:	48 89 c1             	mov    %rax,%rcx
   404e1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   404e8:	ba 80 00 00 00       	mov    $0x80,%edx
   404ed:	48 89 c6             	mov    %rax,%rsi
   404f0:	48 89 cf             	mov    %rcx,%rdi
   404f3:	e8 c4 2d 00 00       	callq  432bc <memcpy>
    return 128;
   404f8:	b8 80 00 00 00       	mov    $0x80,%eax
}
   404fd:	c9                   	leaveq 
   404fe:	c3                   	retq   

00000000000404ff <syscall_mapping>:

void syscall_mapping(proc* p){
   404ff:	55                   	push   %rbp
   40500:	48 89 e5             	mov    %rsp,%rbp
   40503:	48 83 ec 70          	sub    $0x70,%rsp
   40507:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4050b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4050f:	48 8b 40 48          	mov    0x48(%rax),%rax
   40513:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40517:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4051b:	48 8b 40 40          	mov    0x40(%rax),%rax
   4051f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40523:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40527:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4052e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40532:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40536:	48 89 ce             	mov    %rcx,%rsi
   40539:	48 89 c7             	mov    %rax,%rdi
   4053c:	e8 7d 1c 00 00       	callq  421be <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40541:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40544:	48 98                	cltq   
   40546:	83 e0 06             	and    $0x6,%eax
   40549:	48 83 f8 06          	cmp    $0x6,%rax
   4054d:	75 73                	jne    405c2 <syscall_mapping+0xc3>
    return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   4054f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40553:	48 83 c0 17          	add    $0x17,%rax
   40557:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   4055b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4055f:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40566:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4056a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4056e:	48 89 ce             	mov    %rcx,%rsi
   40571:	48 89 c7             	mov    %rax,%rdi
   40574:	e8 45 1c 00 00       	callq  421be <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40579:	8b 45 c8             	mov    -0x38(%rbp),%eax
   4057c:	48 98                	cltq   
   4057e:	83 e0 03             	and    $0x3,%eax
   40581:	48 83 f8 03          	cmp    $0x3,%rax
   40585:	75 3e                	jne    405c5 <syscall_mapping+0xc6>
    return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40587:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4058b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40592:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40596:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4059a:	48 89 ce             	mov    %rcx,%rsi
   4059d:	48 89 c7             	mov    %rax,%rdi
   405a0:	e8 19 1c 00 00       	callq  421be <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   405a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   405a9:	48 89 c1             	mov    %rax,%rcx
   405ac:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   405b0:	ba 18 00 00 00       	mov    $0x18,%edx
   405b5:	48 89 c6             	mov    %rax,%rsi
   405b8:	48 89 cf             	mov    %rcx,%rdi
   405bb:	e8 fc 2c 00 00       	callq  432bc <memcpy>
   405c0:	eb 04                	jmp    405c6 <syscall_mapping+0xc7>
    return;
   405c2:	90                   	nop
   405c3:	eb 01                	jmp    405c6 <syscall_mapping+0xc7>
    return;
   405c5:	90                   	nop
}
   405c6:	c9                   	leaveq 
   405c7:	c3                   	retq   

00000000000405c8 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405c8:	55                   	push   %rbp
   405c9:	48 89 e5             	mov    %rsp,%rbp
   405cc:	48 83 ec 18          	sub    $0x18,%rsp
   405d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   405d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405d8:	48 8b 40 48          	mov    0x48(%rax),%rax
   405dc:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   405df:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405e3:	75 14                	jne    405f9 <syscall_mem_tog+0x31>
    disp_global = !disp_global;
   405e5:	0f b6 05 14 5a 00 00 	movzbl 0x5a14(%rip),%eax        # 46000 <start_data>
   405ec:	84 c0                	test   %al,%al
   405ee:	0f 94 c0             	sete   %al
   405f1:	88 05 09 5a 00 00    	mov    %al,0x5a09(%rip)        # 46000 <start_data>
   405f7:	eb 36                	jmp    4062f <syscall_mem_tog+0x67>
    }
    else {
    if(p < 0 || p > NPROC || p != process->p_pid)
   405f9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405fd:	78 2f                	js     4062e <syscall_mem_tog+0x66>
   405ff:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40603:	7f 29                	jg     4062e <syscall_mem_tog+0x66>
   40605:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40609:	8b 00                	mov    (%rax),%eax
   4060b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4060e:	75 1e                	jne    4062e <syscall_mem_tog+0x66>
        return;
    process->display_status = !(process->display_status);
   40610:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40614:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   4061b:	84 c0                	test   %al,%al
   4061d:	0f 94 c0             	sete   %al
   40620:	89 c2                	mov    %eax,%edx
   40622:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40626:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   4062c:	eb 01                	jmp    4062f <syscall_mem_tog+0x67>
        return;
   4062e:	90                   	nop
    }
}
   4062f:	c9                   	leaveq 
   40630:	c3                   	retq   

0000000000040631 <move_break>:
// int move_break(void *addr)
//    Moves process break to desired address.
//    Fails if addr is > PROC_STACK_TOP and if addr < PROC_START_ADDR
//    Returns 0 on success and -1 on failure. Used by the brk and sbrk.
int move_break(void *addr)
{
   40631:	55                   	push   %rbp
   40632:	48 89 e5             	mov    %rsp,%rbp
   40635:	48 83 ec 50          	sub    $0x50,%rsp
   40639:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    uintptr_t my_addr = (uintptr_t) addr;
   4063d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40641:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    // error check
    if (!addr || my_addr >= (MEMSIZE_VIRTUAL - PAGESIZE) || my_addr < current->original_break) 
   40645:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
   4064a:	74 1b                	je     40667 <move_break+0x36>
   4064c:	48 81 7d f0 ff ef 2f 	cmpq   $0x2fefff,-0x10(%rbp)
   40653:	00 
   40654:	77 11                	ja     40667 <move_break+0x36>
   40656:	48 8b 05 c3 a8 01 00 	mov    0x1a8c3(%rip),%rax        # 5af20 <current>
   4065d:	48 8b 40 10          	mov    0x10(%rax),%rax
   40661:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40665:	73 0a                	jae    40671 <move_break+0x40>
    {
        //log_printf("HERE");
        return -1;
   40667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4066c:	e9 8f 01 00 00       	jmpq   40800 <move_break+0x1cf>
    }

    uintptr_t diff = my_addr - current->program_break;
   40671:	48 8b 05 a8 a8 01 00 	mov    0x1a8a8(%rip),%rax        # 5af20 <current>
   40678:	48 8b 40 08          	mov    0x8(%rax),%rax
   4067c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40680:	48 29 c2             	sub    %rax,%rdx
   40683:	48 89 d0             	mov    %rdx,%rax
   40686:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    
    if (diff == 0)
   4068a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4068f:	75 0a                	jne    4069b <move_break+0x6a>
    {
        return 0;
   40691:	b8 00 00 00 00       	mov    $0x0,%eax
   40696:	e9 65 01 00 00       	jmpq   40800 <move_break+0x1cf>
    }
    // allocate pages up to addr
    else if (diff > 0)
   4069b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   406a0:	74 14                	je     406b6 <move_break+0x85>
    {
        current->program_break = my_addr;
   406a2:	48 8b 05 77 a8 01 00 	mov    0x1a877(%rip),%rax        # 5af20 <current>
   406a9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406ad:	48 89 50 08          	mov    %rdx,0x8(%rax)
   406b1:	e9 45 01 00 00       	jmpq   407fb <move_break+0x1ca>
    }
    else
    {
        my_addr = (uintptr_t) ROUNDUP((uint8_t*) addr, PAGESIZE);
   406b6:	48 c7 45 e0 00 10 00 	movq   $0x1000,-0x20(%rbp)
   406bd:	00 
   406be:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   406c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   406c6:	48 01 d0             	add    %rdx,%rax
   406c9:	48 83 e8 01          	sub    $0x1,%rax
   406cd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   406d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406d5:	ba 00 00 00 00       	mov    $0x0,%edx
   406da:	48 f7 75 e0          	divq   -0x20(%rbp)
   406de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406e2:	48 29 d0             	sub    %rdx,%rax
   406e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

        vamapping my_map;

        // decrement
        for (uintptr_t va = diff; va > current->program_break; va -= PAGESIZE)
   406e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   406f1:	e9 e1 00 00 00       	jmpq   407d7 <move_break+0x1a6>
        {
            // remove mappings
            my_map = virtual_memory_lookup(current->p_pagetable, va);
   406f6:	48 8b 05 23 a8 01 00 	mov    0x1a823(%rip),%rax        # 5af20 <current>
   406fd:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40704:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40708:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4070c:	48 89 ce             	mov    %rcx,%rsi
   4070f:	48 89 c7             	mov    %rax,%rdi
   40712:	e8 a7 1a 00 00       	callq  421be <virtual_memory_lookup>

            // check if shared pages

            if (my_map.perm & PTE_W)
   40717:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4071a:	48 98                	cltq   
   4071c:	83 e0 02             	and    $0x2,%eax
   4071f:	48 85 c0             	test   %rax,%rax
   40722:	74 5d                	je     40781 <move_break+0x150>
            {
                if (pageinfo[my_map.pn].refcount == 1)
   40724:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40727:	48 98                	cltq   
   40729:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   40730:	00 
   40731:	3c 01                	cmp    $0x1,%al
   40733:	75 30                	jne    40765 <move_break+0x134>
                {
                    pageinfo[my_map.pn].refcount = 0;
   40735:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40738:	48 98                	cltq   
   4073a:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   40741:	00 
                    pageinfo[my_map.pn].owner = P_FREE;
   40742:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40745:	48 98                	cltq   
   40747:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   4074e:	00 


                    my_map.pn = -1;
   4074f:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%rbp)
                    my_map.pa = (uintptr_t) -1;
   40756:	48 c7 45 c8 ff ff ff 	movq   $0xffffffffffffffff,-0x38(%rbp)
   4075d:	ff 
                    my_map.perm = 0; 
   4075e:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%rbp)
                }
                --pageinfo[my_map.pn].refcount;
   40765:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40768:	48 63 d0             	movslq %eax,%rdx
   4076b:	0f b6 94 12 41 af 05 	movzbl 0x5af41(%rdx,%rdx,1),%edx
   40772:	00 
   40773:	83 ea 01             	sub    $0x1,%edx
   40776:	48 98                	cltq   
   40778:	88 94 00 41 af 05 00 	mov    %dl,0x5af41(%rax,%rax,1)
   4077f:	eb 4e                	jmp    407cf <move_break+0x19e>
            }
            else
            {
                --pageinfo[my_map.pn].refcount;
   40781:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40784:	48 63 d0             	movslq %eax,%rdx
   40787:	0f b6 94 12 41 af 05 	movzbl 0x5af41(%rdx,%rdx,1),%edx
   4078e:	00 
   4078f:	83 ea 01             	sub    $0x1,%edx
   40792:	48 98                	cltq   
   40794:	88 94 00 41 af 05 00 	mov    %dl,0x5af41(%rax,%rax,1)

                if (pageinfo[my_map.pn].refcount == 0)
   4079b:	8b 45 c0             	mov    -0x40(%rbp),%eax
   4079e:	48 98                	cltq   
   407a0:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   407a7:	00 
   407a8:	84 c0                	test   %al,%al
   407aa:	75 23                	jne    407cf <move_break+0x19e>
                {
                    pageinfo[my_map.pn].owner = P_FREE;
   407ac:	8b 45 c0             	mov    -0x40(%rbp),%eax
   407af:	48 98                	cltq   
   407b1:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   407b8:	00 

                    my_map.pn = -1;
   407b9:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%rbp)
                    my_map.pa = (uintptr_t) -1;
   407c0:	48 c7 45 c8 ff ff ff 	movq   $0xffffffffffffffff,-0x38(%rbp)
   407c7:	ff 
                    my_map.perm = 0; 
   407c8:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%rbp)
        for (uintptr_t va = diff; va > current->program_break; va -= PAGESIZE)
   407cf:	48 81 6d f8 00 10 00 	subq   $0x1000,-0x8(%rbp)
   407d6:	00 
   407d7:	48 8b 05 42 a7 01 00 	mov    0x1a742(%rip),%rax        # 5af20 <current>
   407de:	48 8b 40 08          	mov    0x8(%rax),%rax
   407e2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   407e6:	0f 87 0a ff ff ff    	ja     406f6 <move_break+0xc5>
                }
            }      
        }

        current->program_break = my_addr;
   407ec:	48 8b 05 2d a7 01 00 	mov    0x1a72d(%rip),%rax        # 5af20 <current>
   407f3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   407f7:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    
    return 0;
   407fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40800:	c9                   	leaveq 
   40801:	c3                   	retq   

0000000000040802 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40802:	55                   	push   %rbp
   40803:	48 89 e5             	mov    %rsp,%rbp
   40806:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   4080d:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40814:	48 8b 05 05 a7 01 00 	mov    0x1a705(%rip),%rax        # 5af20 <current>
   4081b:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   40822:	48 83 c0 18          	add    $0x18,%rax
   40826:	48 89 d6             	mov    %rdx,%rsi
   40829:	ba 18 00 00 00       	mov    $0x18,%edx
   4082e:	48 89 c7             	mov    %rax,%rdi
   40831:	48 89 d1             	mov    %rdx,%rcx
   40834:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40837:	48 8b 05 02 ab 01 00 	mov    0x1ab02(%rip),%rax        # 5b340 <kernel_pagetable>
   4083e:	48 89 c7             	mov    %rax,%rdi
   40841:	e8 6f 1a 00 00       	callq  422b5 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40846:	8b 05 b0 87 07 00    	mov    0x787b0(%rip),%eax        # b8ffc <cursorpos>
   4084c:	89 c7                	mov    %eax,%edi
   4084e:	e8 22 1e 00 00       	callq  42675 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT 
   40853:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4085a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40861:	48 83 f8 0e          	cmp    $0xe,%rax
   40865:	74 14                	je     4087b <exception+0x79>
        && reg->reg_intno != INT_GPF)
   40867:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4086e:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40875:	48 83 f8 0d          	cmp    $0xd,%rax
   40879:	75 16                	jne    40891 <exception+0x8f>
        || (reg->reg_err & PFERR_USER)) {
   4087b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40882:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40889:	83 e0 04             	and    $0x4,%eax
   4088c:	48 85 c0             	test   %rax,%rax
   4088f:	74 1a                	je     408ab <exception+0xa9>
    check_virtual_memory();
   40891:	e8 b4 08 00 00       	callq  4114a <check_virtual_memory>
    if(disp_global){
   40896:	0f b6 05 63 57 00 00 	movzbl 0x5763(%rip),%eax        # 46000 <start_data>
   4089d:	84 c0                	test   %al,%al
   4089f:	74 0a                	je     408ab <exception+0xa9>
        memshow_physical();
   408a1:	e8 1c 0a 00 00       	callq  412c2 <memshow_physical>
        memshow_virtual_animate();
   408a6:	e8 40 0d 00 00       	callq  415eb <memshow_virtual_animate>
    }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   408ab:	e8 2d 23 00 00       	callq  42bdd <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408b0:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   408b7:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408be:	48 83 e8 0e          	sub    $0xe,%rax
   408c2:	48 83 f8 2c          	cmp    $0x2c,%rax
   408c6:	0f 87 a5 03 00 00    	ja     40c71 <exception+0x46f>
   408cc:	48 8b 04 c5 b0 48 04 	mov    0x448b0(,%rax,8),%rax
   408d3:	00 
   408d4:	ff e0                	jmpq   *%rax
    case INT_SYS_PANIC:
    {
        // rdi stores pointer for msg string
        {
        char msg[160];
        uintptr_t addr = current->p_registers.reg_rdi;
   408d6:	48 8b 05 43 a6 01 00 	mov    0x1a643(%rip),%rax        # 5af20 <current>
   408dd:	48 8b 40 48          	mov    0x48(%rax),%rax
   408e1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        if((void *)addr == NULL)
   408e5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   408ea:	75 0f                	jne    408fb <exception+0xf9>
            panic(NULL);
   408ec:	bf 00 00 00 00       	mov    $0x0,%edi
   408f1:	b8 00 00 00 00       	mov    $0x0,%eax
   408f6:	e8 0e 24 00 00       	callq  42d09 <panic>
        vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408fb:	48 8b 05 1e a6 01 00 	mov    0x1a61e(%rip),%rax        # 5af20 <current>
   40902:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40909:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   4090d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40911:	48 89 ce             	mov    %rcx,%rsi
   40914:	48 89 c7             	mov    %rax,%rdi
   40917:	e8 a2 18 00 00       	callq  421be <virtual_memory_lookup>
        memcpy(msg, (void *)map.pa, 160);
   4091c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40920:	48 89 c1             	mov    %rax,%rcx
   40923:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   4092a:	ba a0 00 00 00       	mov    $0xa0,%edx
   4092f:	48 89 ce             	mov    %rcx,%rsi
   40932:	48 89 c7             	mov    %rax,%rdi
   40935:	e8 82 29 00 00       	callq  432bc <memcpy>
        panic(msg);
   4093a:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40941:	48 89 c7             	mov    %rax,%rdi
   40944:	b8 00 00 00 00       	mov    $0x0,%eax
   40949:	e8 bb 23 00 00       	callq  42d09 <panic>
        panic(NULL);
        break;                  // will not be reached
    }
    case INT_SYS_GETPID:
    {
        current->p_registers.reg_rax = current->p_pid;
   4094e:	48 8b 05 cb a5 01 00 	mov    0x1a5cb(%rip),%rax        # 5af20 <current>
   40955:	8b 10                	mov    (%rax),%edx
   40957:	48 8b 05 c2 a5 01 00 	mov    0x1a5c2(%rip),%rax        # 5af20 <current>
   4095e:	48 63 d2             	movslq %edx,%rdx
   40961:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40965:	e9 17 03 00 00       	jmpq   40c81 <exception+0x47f>
    }
    case INT_SYS_FORK:
    {
        //pid_t pid = syscall_fork();
        
        current->p_registers.reg_rax = syscall_fork();
   4096a:	b8 00 00 00 00       	mov    $0x0,%eax
   4096f:	e8 6f fa ff ff       	callq  403e3 <syscall_fork>
   40974:	89 c2                	mov    %eax,%edx
   40976:	48 8b 05 a3 a5 01 00 	mov    0x1a5a3(%rip),%rax        # 5af20 <current>
   4097d:	48 63 d2             	movslq %edx,%rdx
   40980:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40984:	e9 f8 02 00 00       	jmpq   40c81 <exception+0x47f>
    }
    case INT_SYS_MAPPING:
        {
        syscall_mapping(current);
   40989:	48 8b 05 90 a5 01 00 	mov    0x1a590(%rip),%rax        # 5af20 <current>
   40990:	48 89 c7             	mov    %rax,%rdi
   40993:	e8 67 fb ff ff       	callq  404ff <syscall_mapping>
            break;
   40998:	e9 e4 02 00 00       	jmpq   40c81 <exception+0x47f>
        }

    case INT_SYS_EXIT:
    {
        syscall_exit();
   4099d:	b8 00 00 00 00       	mov    $0x0,%eax
   409a2:	e8 51 fa ff ff       	callq  403f8 <syscall_exit>
        schedule();
   409a7:	e8 fe 02 00 00       	callq  40caa <schedule>
        break;
   409ac:	e9 d0 02 00 00       	jmpq   40c81 <exception+0x47f>
    }

    case INT_SYS_YIELD:
    {
        schedule();
   409b1:	e8 f4 02 00 00       	callq  40caa <schedule>
        break;                  /* will not be reached */
   409b6:	e9 c6 02 00 00       	jmpq   40c81 <exception+0x47f>
    }

    case INT_SYS_BRK:
    {
        // move brk
        void *brk_addr = (void *) current->p_registers.reg_rdi;
   409bb:	48 8b 05 5e a5 01 00 	mov    0x1a55e(%rip),%rax        # 5af20 <current>
   409c2:	48 8b 40 48          	mov    0x48(%rax),%rax
   409c6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

        if (move_break(brk_addr) < 0)
   409ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   409ce:	48 89 c7             	mov    %rax,%rdi
   409d1:	e8 5b fc ff ff       	callq  40631 <move_break>
   409d6:	85 c0                	test   %eax,%eax
   409d8:	79 14                	jns    409ee <exception+0x1ec>
        {
            current->p_registers.reg_rax = -1;
   409da:	48 8b 05 3f a5 01 00 	mov    0x1a53f(%rip),%rax        # 5af20 <current>
   409e1:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   409e8:	ff 
        else
        {
            current->p_registers.reg_rax = 0;
        }
        
        break;
   409e9:	e9 93 02 00 00       	jmpq   40c81 <exception+0x47f>
            current->p_registers.reg_rax = 0;
   409ee:	48 8b 05 2b a5 01 00 	mov    0x1a52b(%rip),%rax        # 5af20 <current>
   409f5:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   409fc:	00 
        break;
   409fd:	e9 7f 02 00 00       	jmpq   40c81 <exception+0x47f>
    }

    case INT_SYS_SBRK:
    {
        // move brk
        intptr_t increment = (intptr_t) current->p_registers.reg_rdi;
   40a02:	48 8b 05 17 a5 01 00 	mov    0x1a517(%rip),%rax        # 5af20 <current>
   40a09:	48 8b 40 48          	mov    0x48(%rax),%rax
   40a0d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

        uint64_t temp = (uint64_t) current->program_break;
   40a11:	48 8b 05 08 a5 01 00 	mov    0x1a508(%rip),%rax        # 5af20 <current>
   40a18:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a1c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

        uintptr_t sbrk_addr = current->program_break + (uintptr_t) increment;
   40a20:	48 8b 05 f9 a4 01 00 	mov    0x1a4f9(%rip),%rax        # 5af20 <current>
   40a27:	48 8b 50 08          	mov    0x8(%rax),%rdx
   40a2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a2f:	48 01 d0             	add    %rdx,%rax
   40a32:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (move_break((void *)sbrk_addr) < 0)
   40a36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a3a:	48 89 c7             	mov    %rax,%rdi
   40a3d:	e8 ef fb ff ff       	callq  40631 <move_break>
   40a42:	85 c0                	test   %eax,%eax
   40a44:	79 14                	jns    40a5a <exception+0x258>
        {
            current->p_registers.reg_rax = (uint64_t)-1;
   40a46:	48 8b 05 d3 a4 01 00 	mov    0x1a4d3(%rip),%rax        # 5af20 <current>
   40a4d:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40a54:	ff 
        else
        {
            current->p_registers.reg_rax = temp;
        }
        
        break;
   40a55:	e9 27 02 00 00       	jmpq   40c81 <exception+0x47f>
            current->p_registers.reg_rax = temp;
   40a5a:	48 8b 05 bf a4 01 00 	mov    0x1a4bf(%rip),%rax        # 5af20 <current>
   40a61:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40a65:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40a69:	e9 13 02 00 00       	jmpq   40c81 <exception+0x47f>
    }

    case INT_SYS_MEM_TOG:
    {
        syscall_mem_tog(current);
   40a6e:	48 8b 05 ab a4 01 00 	mov    0x1a4ab(%rip),%rax        # 5af20 <current>
   40a75:	48 89 c7             	mov    %rax,%rdi
   40a78:	e8 4b fb ff ff       	callq  405c8 <syscall_mem_tog>
        break;
   40a7d:	e9 ff 01 00 00       	jmpq   40c81 <exception+0x47f>
    }

    case INT_SYS_READ_SERIAL:
    {
        current->p_registers.reg_rax = syscall_read_serial(current);
   40a82:	48 8b 05 97 a4 01 00 	mov    0x1a497(%rip),%rax        # 5af20 <current>
   40a89:	48 89 c7             	mov    %rax,%rdi
   40a8c:	e8 a2 f9 ff ff       	callq  40433 <syscall_read_serial>
   40a91:	89 c2                	mov    %eax,%edx
   40a93:	48 8b 05 86 a4 01 00 	mov    0x1a486(%rip),%rax        # 5af20 <current>
   40a9a:	48 63 d2             	movslq %edx,%rdx
   40a9d:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40aa1:	e9 db 01 00 00       	jmpq   40c81 <exception+0x47f>
    }

    case INT_TIMER:
    {
        ++ticks;
   40aa6:	8b 05 54 15 01 00    	mov    0x11554(%rip),%eax        # 52000 <ticks>
   40aac:	83 c0 01             	add    $0x1,%eax
   40aaf:	89 05 4b 15 01 00    	mov    %eax,0x1154b(%rip)        # 52000 <ticks>
        schedule();
   40ab5:	e8 f0 01 00 00       	callq  40caa <schedule>
        break;                  /* will not be reached */
   40aba:	e9 c2 01 00 00       	jmpq   40c81 <exception+0x47f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40abf:	0f 20 d0             	mov    %cr2,%rax
   40ac2:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    return val;
   40ac6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
    }

    case INT_PAGEFAULT: 
    {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40aca:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        addr = ROUNDDOWN(addr, PAGESIZE);
   40ace:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40ad2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   40ad6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ada:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40ae0:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        const char* operation = reg->reg_err & PFERR_WRITE? "write" : "read";
   40ae4:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40aeb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40af2:	83 e0 02             	and    $0x2,%eax
   40af5:	48 85 c0             	test   %rax,%rax
   40af8:	74 07                	je     40b01 <exception+0x2ff>
   40afa:	b8 23 48 04 00       	mov    $0x44823,%eax
   40aff:	eb 05                	jmp    40b06 <exception+0x304>
   40b01:	b8 29 48 04 00       	mov    $0x44829,%eax
   40b06:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

        const char* problem = reg->reg_err & PFERR_PRESENT? "protection problem" : "missing page";
   40b0a:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b11:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b18:	83 e0 01             	and    $0x1,%eax
   40b1b:	48 85 c0             	test   %rax,%rax
   40b1e:	74 07                	je     40b27 <exception+0x325>
   40b20:	b8 2e 48 04 00       	mov    $0x4482e,%eax
   40b25:	eb 05                	jmp    40b2c <exception+0x32a>
   40b27:	b8 41 48 04 00       	mov    $0x44841,%eax
   40b2c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

        if (strcmp(operation, "write") == 0 && strcmp(problem, "missing page") == 0)
   40b30:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40b34:	be 23 48 04 00       	mov    $0x44823,%esi
   40b39:	48 89 c7             	mov    %rax,%rdi
   40b3c:	e8 51 28 00 00       	callq  43392 <strcmp>
   40b41:	85 c0                	test   %eax,%eax
   40b43:	0f 85 88 00 00 00    	jne    40bd1 <exception+0x3cf>
   40b49:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b4d:	be 41 48 04 00       	mov    $0x44841,%esi
   40b52:	48 89 c7             	mov    %rax,%rdi
   40b55:	e8 38 28 00 00       	callq  43392 <strcmp>
   40b5a:	85 c0                	test   %eax,%eax
   40b5c:	75 73                	jne    40bd1 <exception+0x3cf>
        {
            // allocate and map
            uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   40b5e:	48 8b 05 bb a3 01 00 	mov    0x1a3bb(%rip),%rax        # 5af20 <current>
   40b65:	8b 00                	mov    (%rax),%eax
   40b67:	89 c7                	mov    %eax,%edi
   40b69:	e8 cf 30 00 00       	callq  43c3d <palloc>
   40b6e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)

            if(pa == (uintptr_t)NULL || virtual_memory_map(current->p_pagetable, addr, pa, PAGESIZE, PTE_W | PTE_P | PTE_U, NULL) < 0)
   40b72:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   40b77:	74 33                	je     40bac <exception+0x3aa>
   40b79:	48 8b 05 a0 a3 01 00 	mov    0x1a3a0(%rip),%rax        # 5af20 <current>
   40b80:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40b87:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   40b8b:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40b8f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   40b95:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b9b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40ba0:	48 89 c7             	mov    %rax,%rdi
   40ba3:	e8 1f 12 00 00       	callq  41dc7 <virtual_memory_map>
   40ba8:	85 c0                	test   %eax,%eax
   40baa:	79 0f                	jns    40bbb <exception+0x3b9>
            {
                syscall_exit();
   40bac:	b8 00 00 00 00       	mov    $0x0,%eax
   40bb1:	e8 42 f8 ff ff       	callq  403f8 <syscall_exit>

                break;
   40bb6:	e9 c6 00 00 00       	jmpq   40c81 <exception+0x47f>
            }
            
            current->p_state = P_RUNNABLE;
   40bbb:	48 8b 05 5e a3 01 00 	mov    0x1a35e(%rip),%rax        # 5af20 <current>
   40bc2:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40bc9:	00 00 00 

            break;
   40bcc:	e9 b0 00 00 00       	jmpq   40c81 <exception+0x47f>
        }

        if (!(reg->reg_err & PFERR_USER)) {
   40bd1:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40bd8:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40bdf:	83 e0 04             	and    $0x4,%eax
   40be2:	48 85 c0             	test   %rax,%rax
   40be5:	75 2f                	jne    40c16 <exception+0x414>
        panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40be7:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40bee:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40bf5:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40bf9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40bfd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40c01:	49 89 f0             	mov    %rsi,%r8
   40c04:	48 89 c6             	mov    %rax,%rsi
   40c07:	bf 50 48 04 00       	mov    $0x44850,%edi
   40c0c:	b8 00 00 00 00       	mov    $0x0,%eax
   40c11:	e8 f3 20 00 00       	callq  42d09 <panic>
            addr, operation, problem, reg->reg_rip);
        }

        console_printf(CPOS(24, 0), 0x0C00,
   40c16:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c1d:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
            "Process %d page fault for %p (%s %s, rip=%p)!\n",
            current->p_pid, addr, operation, problem, reg->reg_rip);
   40c24:	48 8b 05 f5 a2 01 00 	mov    0x1a2f5(%rip),%rax        # 5af20 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40c2b:	8b 00                	mov    (%rax),%eax
   40c2d:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   40c31:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40c35:	52                   	push   %rdx
   40c36:	ff 75 b8             	pushq  -0x48(%rbp)
   40c39:	49 89 f1             	mov    %rsi,%r9
   40c3c:	49 89 c8             	mov    %rcx,%r8
   40c3f:	89 c1                	mov    %eax,%ecx
   40c41:	ba 80 48 04 00       	mov    $0x44880,%edx
   40c46:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c4b:	bf 80 07 00 00       	mov    $0x780,%edi
   40c50:	b8 00 00 00 00       	mov    $0x0,%eax
   40c55:	e8 09 2f 00 00       	callq  43b63 <console_printf>
   40c5a:	48 83 c4 10          	add    $0x10,%rsp

        current->p_state = P_BROKEN;
   40c5e:	48 8b 05 bb a2 01 00 	mov    0x1a2bb(%rip),%rax        # 5af20 <current>
   40c65:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40c6c:	00 00 00 
        break;
   40c6f:	eb 10                	jmp    40c81 <exception+0x47f>
    }

    default:
    default_exception(current);
   40c71:	48 8b 05 a8 a2 01 00 	mov    0x1a2a8(%rip),%rax        # 5af20 <current>
   40c78:	48 89 c7             	mov    %rax,%rdi
   40c7b:	e8 99 21 00 00       	callq  42e19 <default_exception>
        break;                  /* will not be reached */
   40c80:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c81:	48 8b 05 98 a2 01 00 	mov    0x1a298(%rip),%rax        # 5af20 <current>
   40c88:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c8e:	83 f8 01             	cmp    $0x1,%eax
   40c91:	75 0f                	jne    40ca2 <exception+0x4a0>
        run(current);
   40c93:	48 8b 05 86 a2 01 00 	mov    0x1a286(%rip),%rax        # 5af20 <current>
   40c9a:	48 89 c7             	mov    %rax,%rdi
   40c9d:	e8 80 00 00 00       	callq  40d22 <run>
    } else {
        schedule();
   40ca2:	e8 03 00 00 00       	callq  40caa <schedule>
    }
}
   40ca7:	90                   	nop
   40ca8:	c9                   	leaveq 
   40ca9:	c3                   	retq   

0000000000040caa <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40caa:	55                   	push   %rbp
   40cab:	48 89 e5             	mov    %rsp,%rbp
   40cae:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40cb2:	48 8b 05 67 a2 01 00 	mov    0x1a267(%rip),%rax        # 5af20 <current>
   40cb9:	8b 00                	mov    (%rax),%eax
   40cbb:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40cbe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cc1:	8d 50 01             	lea    0x1(%rax),%edx
   40cc4:	89 d0                	mov    %edx,%eax
   40cc6:	c1 f8 1f             	sar    $0x1f,%eax
   40cc9:	c1 e8 1c             	shr    $0x1c,%eax
   40ccc:	01 c2                	add    %eax,%edx
   40cce:	83 e2 0f             	and    $0xf,%edx
   40cd1:	29 c2                	sub    %eax,%edx
   40cd3:	89 d0                	mov    %edx,%eax
   40cd5:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40cd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cdb:	48 63 d0             	movslq %eax,%rdx
   40cde:	48 89 d0             	mov    %rdx,%rax
   40ce1:	48 c1 e0 04          	shl    $0x4,%rax
   40ce5:	48 29 d0             	sub    %rdx,%rax
   40ce8:	48 c1 e0 04          	shl    $0x4,%rax
   40cec:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   40cf2:	8b 00                	mov    (%rax),%eax
   40cf4:	83 f8 01             	cmp    $0x1,%eax
   40cf7:	75 22                	jne    40d1b <schedule+0x71>
            run(&processes[pid]);
   40cf9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cfc:	48 63 d0             	movslq %eax,%rdx
   40cff:	48 89 d0             	mov    %rdx,%rax
   40d02:	48 c1 e0 04          	shl    $0x4,%rax
   40d06:	48 29 d0             	sub    %rdx,%rax
   40d09:	48 c1 e0 04          	shl    $0x4,%rax
   40d0d:	48 05 20 a0 05 00    	add    $0x5a020,%rax
   40d13:	48 89 c7             	mov    %rax,%rdi
   40d16:	e8 07 00 00 00       	callq  40d22 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d1b:	e8 bd 1e 00 00       	callq  42bdd <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d20:	eb 9c                	jmp    40cbe <schedule+0x14>

0000000000040d22 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d22:	55                   	push   %rbp
   40d23:	48 89 e5             	mov    %rsp,%rbp
   40d26:	48 83 ec 10          	sub    $0x10,%rsp
   40d2a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d32:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40d38:	83 f8 01             	cmp    $0x1,%eax
   40d3b:	74 14                	je     40d51 <run+0x2f>
   40d3d:	ba 18 4a 04 00       	mov    $0x44a18,%edx
   40d42:	be f4 01 00 00       	mov    $0x1f4,%esi
   40d47:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40d4c:	e8 98 20 00 00       	callq  42de9 <assert_fail>
    current = p;
   40d51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d55:	48 89 05 c4 a1 01 00 	mov    %rax,0x1a1c4(%rip)        # 5af20 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40d5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d60:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40d62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d66:	8b 00                	mov    (%rax),%eax
   40d68:	83 c0 02             	add    $0x2,%eax
   40d6b:	48 98                	cltq   
   40d6d:	0f b7 84 00 80 47 04 	movzwl 0x44780(%rax,%rax,1),%eax
   40d74:	00 
    console_printf(CPOS(24, 79),
   40d75:	0f b7 c0             	movzwl %ax,%eax
   40d78:	89 d1                	mov    %edx,%ecx
   40d7a:	ba 31 4a 04 00       	mov    $0x44a31,%edx
   40d7f:	89 c6                	mov    %eax,%esi
   40d81:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d86:	b8 00 00 00 00       	mov    $0x0,%eax
   40d8b:	e8 d3 2d 00 00       	callq  43b63 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d94:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d9b:	48 89 c7             	mov    %rax,%rdi
   40d9e:	e8 12 15 00 00       	callq  422b5 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40da3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40da7:	48 83 c0 18          	add    $0x18,%rax
   40dab:	48 89 c7             	mov    %rax,%rdi
   40dae:	e8 10 f3 ff ff       	callq  400c3 <exception_return>

0000000000040db3 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40db3:	55                   	push   %rbp
   40db4:	48 89 e5             	mov    %rsp,%rbp
   40db7:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40dbb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40dc2:	00 
   40dc3:	e9 81 00 00 00       	jmpq   40e49 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40dc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dcc:	48 89 c7             	mov    %rax,%rdi
   40dcf:	e8 12 16 00 00       	callq  423e6 <physical_memory_isreserved>
   40dd4:	85 c0                	test   %eax,%eax
   40dd6:	74 09                	je     40de1 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40dd8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40ddf:	eb 2f                	jmp    40e10 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40de1:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40de8:	00 
   40de9:	76 0b                	jbe    40df6 <pageinfo_init+0x43>
   40deb:	b8 48 b3 05 00       	mov    $0x5b348,%eax
   40df0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40df4:	72 0a                	jb     40e00 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40df6:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40dfd:	00 
   40dfe:	75 09                	jne    40e09 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40e00:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40e07:	eb 07                	jmp    40e10 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40e09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e14:	48 c1 e8 0c          	shr    $0xc,%rax
   40e18:	89 c1                	mov    %eax,%ecx
   40e1a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e1d:	89 c2                	mov    %eax,%edx
   40e1f:	48 63 c1             	movslq %ecx,%rax
   40e22:	88 94 00 40 af 05 00 	mov    %dl,0x5af40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e29:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e2d:	0f 95 c2             	setne  %dl
   40e30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e34:	48 c1 e8 0c          	shr    $0xc,%rax
   40e38:	48 98                	cltq   
   40e3a:	88 94 00 41 af 05 00 	mov    %dl,0x5af41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e41:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e48:	00 
   40e49:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e50:	00 
   40e51:	0f 86 71 ff ff ff    	jbe    40dc8 <pageinfo_init+0x15>
    }
}
   40e57:	90                   	nop
   40e58:	90                   	nop
   40e59:	c9                   	leaveq 
   40e5a:	c3                   	retq   

0000000000040e5b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e5b:	55                   	push   %rbp
   40e5c:	48 89 e5             	mov    %rsp,%rbp
   40e5f:	48 83 ec 50          	sub    $0x50,%rsp
   40e63:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e67:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e6b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40e71:	48 89 c2             	mov    %rax,%rdx
   40e74:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e78:	48 39 c2             	cmp    %rax,%rdx
   40e7b:	74 14                	je     40e91 <check_page_table_mappings+0x36>
   40e7d:	ba 38 4a 04 00       	mov    $0x44a38,%edx
   40e82:	be 22 02 00 00       	mov    $0x222,%esi
   40e87:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40e8c:	e8 58 1f 00 00       	callq  42de9 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e91:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40e98:	00 
   40e99:	e9 9a 00 00 00       	jmpq   40f38 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40e9e:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ea2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ea6:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40eaa:	48 89 ce             	mov    %rcx,%rsi
   40ead:	48 89 c7             	mov    %rax,%rdi
   40eb0:	e8 09 13 00 00       	callq  421be <virtual_memory_lookup>
        if (vam.pa != va) {
   40eb5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40eb9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ebd:	74 27                	je     40ee6 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ebf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ec3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ec7:	49 89 d0             	mov    %rdx,%r8
   40eca:	48 89 c1             	mov    %rax,%rcx
   40ecd:	ba 57 4a 04 00       	mov    $0x44a57,%edx
   40ed2:	be 00 c0 00 00       	mov    $0xc000,%esi
   40ed7:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40edc:	b8 00 00 00 00       	mov    $0x0,%eax
   40ee1:	e8 7d 2c 00 00       	callq  43b63 <console_printf>
        }
        assert(vam.pa == va);
   40ee6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40eea:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40eee:	74 14                	je     40f04 <check_page_table_mappings+0xa9>
   40ef0:	ba 61 4a 04 00       	mov    $0x44a61,%edx
   40ef5:	be 2b 02 00 00       	mov    $0x22b,%esi
   40efa:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40eff:	e8 e5 1e 00 00       	callq  42de9 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f04:	b8 00 60 04 00       	mov    $0x46000,%eax
   40f09:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f0d:	72 21                	jb     40f30 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40f0f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f12:	48 98                	cltq   
   40f14:	83 e0 02             	and    $0x2,%eax
   40f17:	48 85 c0             	test   %rax,%rax
   40f1a:	75 14                	jne    40f30 <check_page_table_mappings+0xd5>
   40f1c:	ba 6e 4a 04 00       	mov    $0x44a6e,%edx
   40f21:	be 2d 02 00 00       	mov    $0x22d,%esi
   40f26:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40f2b:	e8 b9 1e 00 00       	callq  42de9 <assert_fail>
         va += PAGESIZE) {
   40f30:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f37:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f38:	b8 48 b3 05 00       	mov    $0x5b348,%eax
   40f3d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f41:	0f 82 57 ff ff ff    	jb     40e9e <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f47:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f4e:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f4f:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f53:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f57:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f5b:	48 89 ce             	mov    %rcx,%rsi
   40f5e:	48 89 c7             	mov    %rax,%rdi
   40f61:	e8 58 12 00 00       	callq  421be <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40f66:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40f6a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40f6e:	74 14                	je     40f84 <check_page_table_mappings+0x129>
   40f70:	ba 7f 4a 04 00       	mov    $0x44a7f,%edx
   40f75:	be 34 02 00 00       	mov    $0x234,%esi
   40f7a:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40f7f:	e8 65 1e 00 00       	callq  42de9 <assert_fail>
    assert(vam.perm & PTE_W);
   40f84:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40f87:	48 98                	cltq   
   40f89:	83 e0 02             	and    $0x2,%eax
   40f8c:	48 85 c0             	test   %rax,%rax
   40f8f:	75 14                	jne    40fa5 <check_page_table_mappings+0x14a>
   40f91:	ba 6e 4a 04 00       	mov    $0x44a6e,%edx
   40f96:	be 35 02 00 00       	mov    $0x235,%esi
   40f9b:	bf e0 47 04 00       	mov    $0x447e0,%edi
   40fa0:	e8 44 1e 00 00       	callq  42de9 <assert_fail>
}
   40fa5:	90                   	nop
   40fa6:	c9                   	leaveq 
   40fa7:	c3                   	retq   

0000000000040fa8 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40fa8:	55                   	push   %rbp
   40fa9:	48 89 e5             	mov    %rsp,%rbp
   40fac:	48 83 ec 20          	sub    $0x20,%rsp
   40fb0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fb4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40fb7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40fba:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40fbd:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40fc4:	48 8b 05 75 a3 01 00 	mov    0x1a375(%rip),%rax        # 5b340 <kernel_pagetable>
   40fcb:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40fcf:	75 67                	jne    41038 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40fd1:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40fd8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40fdf:	eb 51                	jmp    41032 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40fe1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40fe4:	48 63 d0             	movslq %eax,%rdx
   40fe7:	48 89 d0             	mov    %rdx,%rax
   40fea:	48 c1 e0 04          	shl    $0x4,%rax
   40fee:	48 29 d0             	sub    %rdx,%rax
   40ff1:	48 c1 e0 04          	shl    $0x4,%rax
   40ff5:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   40ffb:	8b 00                	mov    (%rax),%eax
   40ffd:	85 c0                	test   %eax,%eax
   40fff:	74 2d                	je     4102e <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41001:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41004:	48 63 d0             	movslq %eax,%rdx
   41007:	48 89 d0             	mov    %rdx,%rax
   4100a:	48 c1 e0 04          	shl    $0x4,%rax
   4100e:	48 29 d0             	sub    %rdx,%rax
   41011:	48 c1 e0 04          	shl    $0x4,%rax
   41015:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   4101b:	48 8b 10             	mov    (%rax),%rdx
   4101e:	48 8b 05 1b a3 01 00 	mov    0x1a31b(%rip),%rax        # 5b340 <kernel_pagetable>
   41025:	48 39 c2             	cmp    %rax,%rdx
   41028:	75 04                	jne    4102e <check_page_table_ownership+0x86>
                ++expected_refcount;
   4102a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4102e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41032:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41036:	7e a9                	jle    40fe1 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41038:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4103b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4103e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41042:	be 00 00 00 00       	mov    $0x0,%esi
   41047:	48 89 c7             	mov    %rax,%rdi
   4104a:	e8 03 00 00 00       	callq  41052 <check_page_table_ownership_level>
}
   4104f:	90                   	nop
   41050:	c9                   	leaveq 
   41051:	c3                   	retq   

0000000000041052 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41052:	55                   	push   %rbp
   41053:	48 89 e5             	mov    %rsp,%rbp
   41056:	48 83 ec 30          	sub    $0x30,%rsp
   4105a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4105e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41061:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41064:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41067:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4106b:	48 c1 e8 0c          	shr    $0xc,%rax
   4106f:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41074:	7e 14                	jle    4108a <check_page_table_ownership_level+0x38>
   41076:	ba 90 4a 04 00       	mov    $0x44a90,%edx
   4107b:	be 52 02 00 00       	mov    $0x252,%esi
   41080:	bf e0 47 04 00       	mov    $0x447e0,%edi
   41085:	e8 5f 1d 00 00       	callq  42de9 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   4108a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4108e:	48 c1 e8 0c          	shr    $0xc,%rax
   41092:	48 98                	cltq   
   41094:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   4109b:	00 
   4109c:	0f be c0             	movsbl %al,%eax
   4109f:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   410a2:	74 14                	je     410b8 <check_page_table_ownership_level+0x66>
   410a4:	ba a8 4a 04 00       	mov    $0x44aa8,%edx
   410a9:	be 53 02 00 00       	mov    $0x253,%esi
   410ae:	bf e0 47 04 00       	mov    $0x447e0,%edi
   410b3:	e8 31 1d 00 00       	callq  42de9 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   410b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410bc:	48 c1 e8 0c          	shr    $0xc,%rax
   410c0:	48 98                	cltq   
   410c2:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   410c9:	00 
   410ca:	0f be c0             	movsbl %al,%eax
   410cd:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   410d0:	74 14                	je     410e6 <check_page_table_ownership_level+0x94>
   410d2:	ba d0 4a 04 00       	mov    $0x44ad0,%edx
   410d7:	be 54 02 00 00       	mov    $0x254,%esi
   410dc:	bf e0 47 04 00       	mov    $0x447e0,%edi
   410e1:	e8 03 1d 00 00       	callq  42de9 <assert_fail>
    if (level < 3) {
   410e6:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   410ea:	7f 5b                	jg     41147 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   410ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   410f3:	eb 49                	jmp    4113e <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   410f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410f9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410fc:	48 63 d2             	movslq %edx,%rdx
   410ff:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41103:	48 85 c0             	test   %rax,%rax
   41106:	74 32                	je     4113a <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41108:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4110c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4110f:	48 63 d2             	movslq %edx,%rdx
   41112:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41116:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4111c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41120:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41123:	8d 70 01             	lea    0x1(%rax),%esi
   41126:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41129:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4112d:	b9 01 00 00 00       	mov    $0x1,%ecx
   41132:	48 89 c7             	mov    %rax,%rdi
   41135:	e8 18 ff ff ff       	callq  41052 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4113a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4113e:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41145:	7e ae                	jle    410f5 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41147:	90                   	nop
   41148:	c9                   	leaveq 
   41149:	c3                   	retq   

000000000004114a <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   4114a:	55                   	push   %rbp
   4114b:	48 89 e5             	mov    %rsp,%rbp
   4114e:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41152:	8b 05 a0 8f 01 00    	mov    0x18fa0(%rip),%eax        # 5a0f8 <processes+0xd8>
   41158:	85 c0                	test   %eax,%eax
   4115a:	74 14                	je     41170 <check_virtual_memory+0x26>
   4115c:	ba 00 4b 04 00       	mov    $0x44b00,%edx
   41161:	be 67 02 00 00       	mov    $0x267,%esi
   41166:	bf e0 47 04 00       	mov    $0x447e0,%edi
   4116b:	e8 79 1c 00 00       	callq  42de9 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41170:	48 8b 05 c9 a1 01 00 	mov    0x1a1c9(%rip),%rax        # 5b340 <kernel_pagetable>
   41177:	48 89 c7             	mov    %rax,%rdi
   4117a:	e8 dc fc ff ff       	callq  40e5b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4117f:	48 8b 05 ba a1 01 00 	mov    0x1a1ba(%rip),%rax        # 5b340 <kernel_pagetable>
   41186:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4118b:	48 89 c7             	mov    %rax,%rdi
   4118e:	e8 15 fe ff ff       	callq  40fa8 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41193:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4119a:	e9 9c 00 00 00       	jmpq   4123b <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4119f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411a2:	48 63 d0             	movslq %eax,%rdx
   411a5:	48 89 d0             	mov    %rdx,%rax
   411a8:	48 c1 e0 04          	shl    $0x4,%rax
   411ac:	48 29 d0             	sub    %rdx,%rax
   411af:	48 c1 e0 04          	shl    $0x4,%rax
   411b3:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   411b9:	8b 00                	mov    (%rax),%eax
   411bb:	85 c0                	test   %eax,%eax
   411bd:	74 78                	je     41237 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   411bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411c2:	48 63 d0             	movslq %eax,%rdx
   411c5:	48 89 d0             	mov    %rdx,%rax
   411c8:	48 c1 e0 04          	shl    $0x4,%rax
   411cc:	48 29 d0             	sub    %rdx,%rax
   411cf:	48 c1 e0 04          	shl    $0x4,%rax
   411d3:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   411d9:	48 8b 10             	mov    (%rax),%rdx
   411dc:	48 8b 05 5d a1 01 00 	mov    0x1a15d(%rip),%rax        # 5b340 <kernel_pagetable>
   411e3:	48 39 c2             	cmp    %rax,%rdx
   411e6:	74 4f                	je     41237 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   411e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411eb:	48 63 d0             	movslq %eax,%rdx
   411ee:	48 89 d0             	mov    %rdx,%rax
   411f1:	48 c1 e0 04          	shl    $0x4,%rax
   411f5:	48 29 d0             	sub    %rdx,%rax
   411f8:	48 c1 e0 04          	shl    $0x4,%rax
   411fc:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   41202:	48 8b 00             	mov    (%rax),%rax
   41205:	48 89 c7             	mov    %rax,%rdi
   41208:	e8 4e fc ff ff       	callq  40e5b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4120d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41210:	48 63 d0             	movslq %eax,%rdx
   41213:	48 89 d0             	mov    %rdx,%rax
   41216:	48 c1 e0 04          	shl    $0x4,%rax
   4121a:	48 29 d0             	sub    %rdx,%rax
   4121d:	48 c1 e0 04          	shl    $0x4,%rax
   41221:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   41227:	48 8b 00             	mov    (%rax),%rax
   4122a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4122d:	89 d6                	mov    %edx,%esi
   4122f:	48 89 c7             	mov    %rax,%rdi
   41232:	e8 71 fd ff ff       	callq  40fa8 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41237:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4123b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4123f:	0f 8e 5a ff ff ff    	jle    4119f <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41245:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4124c:	eb 67                	jmp    412b5 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4124e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41251:	48 98                	cltq   
   41253:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   4125a:	00 
   4125b:	84 c0                	test   %al,%al
   4125d:	7e 52                	jle    412b1 <check_virtual_memory+0x167>
   4125f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41262:	48 98                	cltq   
   41264:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   4126b:	00 
   4126c:	84 c0                	test   %al,%al
   4126e:	78 41                	js     412b1 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41270:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41273:	48 98                	cltq   
   41275:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   4127c:	00 
   4127d:	0f be c0             	movsbl %al,%eax
   41280:	48 63 d0             	movslq %eax,%rdx
   41283:	48 89 d0             	mov    %rdx,%rax
   41286:	48 c1 e0 04          	shl    $0x4,%rax
   4128a:	48 29 d0             	sub    %rdx,%rax
   4128d:	48 c1 e0 04          	shl    $0x4,%rax
   41291:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   41297:	8b 00                	mov    (%rax),%eax
   41299:	85 c0                	test   %eax,%eax
   4129b:	75 14                	jne    412b1 <check_virtual_memory+0x167>
   4129d:	ba 20 4b 04 00       	mov    $0x44b20,%edx
   412a2:	be 7e 02 00 00       	mov    $0x27e,%esi
   412a7:	bf e0 47 04 00       	mov    $0x447e0,%edi
   412ac:	e8 38 1b 00 00       	callq  42de9 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   412b5:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   412bc:	7e 90                	jle    4124e <check_virtual_memory+0x104>
        }
    }
}
   412be:	90                   	nop
   412bf:	90                   	nop
   412c0:	c9                   	leaveq 
   412c1:	c3                   	retq   

00000000000412c2 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   412c2:	55                   	push   %rbp
   412c3:	48 89 e5             	mov    %rsp,%rbp
   412c6:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   412ca:	ba 50 4b 04 00       	mov    $0x44b50,%edx
   412cf:	be 00 0f 00 00       	mov    $0xf00,%esi
   412d4:	bf 20 00 00 00       	mov    $0x20,%edi
   412d9:	b8 00 00 00 00       	mov    $0x0,%eax
   412de:	e8 80 28 00 00       	callq  43b63 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   412ea:	e9 f2 00 00 00       	jmpq   413e1 <memshow_physical+0x11f>
        if (pn % 64 == 0) {
   412ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412f2:	83 e0 3f             	and    $0x3f,%eax
   412f5:	85 c0                	test   %eax,%eax
   412f7:	75 3c                	jne    41335 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   412f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412fc:	c1 e0 0c             	shl    $0xc,%eax
   412ff:	89 c1                	mov    %eax,%ecx
   41301:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41304:	8d 50 3f             	lea    0x3f(%rax),%edx
   41307:	85 c0                	test   %eax,%eax
   41309:	0f 48 c2             	cmovs  %edx,%eax
   4130c:	c1 f8 06             	sar    $0x6,%eax
   4130f:	8d 50 01             	lea    0x1(%rax),%edx
   41312:	89 d0                	mov    %edx,%eax
   41314:	c1 e0 02             	shl    $0x2,%eax
   41317:	01 d0                	add    %edx,%eax
   41319:	c1 e0 04             	shl    $0x4,%eax
   4131c:	83 c0 03             	add    $0x3,%eax
   4131f:	ba 60 4b 04 00       	mov    $0x44b60,%edx
   41324:	be 00 0f 00 00       	mov    $0xf00,%esi
   41329:	89 c7                	mov    %eax,%edi
   4132b:	b8 00 00 00 00       	mov    $0x0,%eax
   41330:	e8 2e 28 00 00       	callq  43b63 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41335:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41338:	48 98                	cltq   
   4133a:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   41341:	00 
   41342:	0f be c0             	movsbl %al,%eax
   41345:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41348:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4134b:	48 98                	cltq   
   4134d:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   41354:	00 
   41355:	84 c0                	test   %al,%al
   41357:	75 07                	jne    41360 <memshow_physical+0x9e>
            owner = PO_FREE;
   41359:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41360:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41363:	83 c0 02             	add    $0x2,%eax
   41366:	48 98                	cltq   
   41368:	0f b7 84 00 80 47 04 	movzwl 0x44780(%rax,%rax,1),%eax
   4136f:	00 
   41370:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41374:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41377:	48 98                	cltq   
   41379:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   41380:	00 
   41381:	3c 01                	cmp    $0x1,%al
   41383:	7e 1a                	jle    4139f <memshow_physical+0xdd>
   41385:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4138a:	48 c1 e8 0c          	shr    $0xc,%rax
   4138e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41391:	74 0c                	je     4139f <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41393:	b8 53 00 00 00       	mov    $0x53,%eax
   41398:	80 cc 0f             	or     $0xf,%ah
   4139b:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
        color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4139f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413a2:	8d 50 3f             	lea    0x3f(%rax),%edx
   413a5:	85 c0                	test   %eax,%eax
   413a7:	0f 48 c2             	cmovs  %edx,%eax
   413aa:	c1 f8 06             	sar    $0x6,%eax
   413ad:	8d 50 01             	lea    0x1(%rax),%edx
   413b0:	89 d0                	mov    %edx,%eax
   413b2:	c1 e0 02             	shl    $0x2,%eax
   413b5:	01 d0                	add    %edx,%eax
   413b7:	c1 e0 04             	shl    $0x4,%eax
   413ba:	89 c1                	mov    %eax,%ecx
   413bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413bf:	99                   	cltd   
   413c0:	c1 ea 1a             	shr    $0x1a,%edx
   413c3:	01 d0                	add    %edx,%eax
   413c5:	83 e0 3f             	and    $0x3f,%eax
   413c8:	29 d0                	sub    %edx,%eax
   413ca:	83 c0 0c             	add    $0xc,%eax
   413cd:	01 c8                	add    %ecx,%eax
   413cf:	48 98                	cltq   
   413d1:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   413d5:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   413dc:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413dd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   413e1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   413e8:	0f 8e 01 ff ff ff    	jle    412ef <memshow_physical+0x2d>
    }
}
   413ee:	90                   	nop
   413ef:	90                   	nop
   413f0:	c9                   	leaveq 
   413f1:	c3                   	retq   

00000000000413f2 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   413f2:	55                   	push   %rbp
   413f3:	48 89 e5             	mov    %rsp,%rbp
   413f6:	48 83 ec 40          	sub    $0x40,%rsp
   413fa:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   413fe:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41402:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41406:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4140c:	48 89 c2             	mov    %rax,%rdx
   4140f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41413:	48 39 c2             	cmp    %rax,%rdx
   41416:	74 14                	je     4142c <memshow_virtual+0x3a>
   41418:	ba 68 4b 04 00       	mov    $0x44b68,%edx
   4141d:	be af 02 00 00       	mov    $0x2af,%esi
   41422:	bf e0 47 04 00       	mov    $0x447e0,%edi
   41427:	e8 bd 19 00 00       	callq  42de9 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4142c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41430:	48 89 c1             	mov    %rax,%rcx
   41433:	ba 95 4b 04 00       	mov    $0x44b95,%edx
   41438:	be 00 0f 00 00       	mov    $0xf00,%esi
   4143d:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41442:	b8 00 00 00 00       	mov    $0x0,%eax
   41447:	e8 17 27 00 00       	callq  43b63 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4144c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41453:	00 
   41454:	e9 80 01 00 00       	jmpq   415d9 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41459:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4145d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41461:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41465:	48 89 ce             	mov    %rcx,%rsi
   41468:	48 89 c7             	mov    %rax,%rdi
   4146b:	e8 4e 0d 00 00       	callq  421be <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41470:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41473:	85 c0                	test   %eax,%eax
   41475:	79 0b                	jns    41482 <memshow_virtual+0x90>
            color = ' ';
   41477:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4147d:	e9 d7 00 00 00       	jmpq   41559 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41482:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41486:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4148c:	76 14                	jbe    414a2 <memshow_virtual+0xb0>
   4148e:	ba b2 4b 04 00       	mov    $0x44bb2,%edx
   41493:	be b8 02 00 00       	mov    $0x2b8,%esi
   41498:	bf e0 47 04 00       	mov    $0x447e0,%edi
   4149d:	e8 47 19 00 00       	callq  42de9 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   414a2:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414a5:	48 98                	cltq   
   414a7:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   414ae:	00 
   414af:	0f be c0             	movsbl %al,%eax
   414b2:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   414b5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414b8:	48 98                	cltq   
   414ba:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   414c1:	00 
   414c2:	84 c0                	test   %al,%al
   414c4:	75 07                	jne    414cd <memshow_virtual+0xdb>
                owner = PO_FREE;
   414c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   414cd:	8b 45 f0             	mov    -0x10(%rbp),%eax
   414d0:	83 c0 02             	add    $0x2,%eax
   414d3:	48 98                	cltq   
   414d5:	0f b7 84 00 80 47 04 	movzwl 0x44780(%rax,%rax,1),%eax
   414dc:	00 
   414dd:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   414e1:	8b 45 e0             	mov    -0x20(%rbp),%eax
   414e4:	48 98                	cltq   
   414e6:	83 e0 04             	and    $0x4,%eax
   414e9:	48 85 c0             	test   %rax,%rax
   414ec:	74 27                	je     41515 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   414ee:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414f2:	c1 e0 04             	shl    $0x4,%eax
   414f5:	66 25 00 f0          	and    $0xf000,%ax
   414f9:	89 c2                	mov    %eax,%edx
   414fb:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414ff:	c1 f8 04             	sar    $0x4,%eax
   41502:	66 25 00 0f          	and    $0xf00,%ax
   41506:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41508:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4150c:	0f b6 c0             	movzbl %al,%eax
   4150f:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41511:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41515:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41518:	48 98                	cltq   
   4151a:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   41521:	00 
   41522:	3c 01                	cmp    $0x1,%al
   41524:	7e 33                	jle    41559 <memshow_virtual+0x167>
   41526:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4152b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4152f:	74 28                	je     41559 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41531:	b8 53 00 00 00       	mov    $0x53,%eax
   41536:	89 c2                	mov    %eax,%edx
   41538:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4153c:	66 25 00 f0          	and    $0xf000,%ax
   41540:	09 d0                	or     %edx,%eax
   41542:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41546:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41549:	48 98                	cltq   
   4154b:	83 e0 04             	and    $0x4,%eax
   4154e:	48 85 c0             	test   %rax,%rax
   41551:	75 06                	jne    41559 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41553:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
        color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4155d:	48 c1 e8 0c          	shr    $0xc,%rax
   41561:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41564:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41567:	83 e0 3f             	and    $0x3f,%eax
   4156a:	85 c0                	test   %eax,%eax
   4156c:	75 34                	jne    415a2 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4156e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41571:	c1 e8 06             	shr    $0x6,%eax
   41574:	89 c2                	mov    %eax,%edx
   41576:	89 d0                	mov    %edx,%eax
   41578:	c1 e0 02             	shl    $0x2,%eax
   4157b:	01 d0                	add    %edx,%eax
   4157d:	c1 e0 04             	shl    $0x4,%eax
   41580:	05 73 03 00 00       	add    $0x373,%eax
   41585:	89 c7                	mov    %eax,%edi
   41587:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4158b:	48 89 c1             	mov    %rax,%rcx
   4158e:	ba 60 4b 04 00       	mov    $0x44b60,%edx
   41593:	be 00 0f 00 00       	mov    $0xf00,%esi
   41598:	b8 00 00 00 00       	mov    $0x0,%eax
   4159d:	e8 c1 25 00 00       	callq  43b63 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   415a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415a5:	c1 e8 06             	shr    $0x6,%eax
   415a8:	89 c2                	mov    %eax,%edx
   415aa:	89 d0                	mov    %edx,%eax
   415ac:	c1 e0 02             	shl    $0x2,%eax
   415af:	01 d0                	add    %edx,%eax
   415b1:	c1 e0 04             	shl    $0x4,%eax
   415b4:	89 c2                	mov    %eax,%edx
   415b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415b9:	83 e0 3f             	and    $0x3f,%eax
   415bc:	01 d0                	add    %edx,%eax
   415be:	05 7c 03 00 00       	add    $0x37c,%eax
   415c3:	89 c2                	mov    %eax,%edx
   415c5:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415c9:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   415d0:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   415d1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   415d8:	00 
   415d9:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   415e0:	00 
   415e1:	0f 86 72 fe ff ff    	jbe    41459 <memshow_virtual+0x67>
    }
}
   415e7:	90                   	nop
   415e8:	90                   	nop
   415e9:	c9                   	leaveq 
   415ea:	c3                   	retq   

00000000000415eb <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   415eb:	55                   	push   %rbp
   415ec:	48 89 e5             	mov    %rsp,%rbp
   415ef:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   415f3:	8b 05 0b 0a 01 00    	mov    0x10a0b(%rip),%eax        # 52004 <last_ticks.1714>
   415f9:	85 c0                	test   %eax,%eax
   415fb:	74 15                	je     41612 <memshow_virtual_animate+0x27>
   415fd:	8b 15 fd 09 01 00    	mov    0x109fd(%rip),%edx        # 52000 <ticks>
   41603:	8b 05 fb 09 01 00    	mov    0x109fb(%rip),%eax        # 52004 <last_ticks.1714>
   41609:	29 c2                	sub    %eax,%edx
   4160b:	89 d0                	mov    %edx,%eax
   4160d:	83 f8 31             	cmp    $0x31,%eax
   41610:	76 2c                	jbe    4163e <memshow_virtual_animate+0x53>
        last_ticks = ticks;
   41612:	8b 05 e8 09 01 00    	mov    0x109e8(%rip),%eax        # 52000 <ticks>
   41618:	89 05 e6 09 01 00    	mov    %eax,0x109e6(%rip)        # 52004 <last_ticks.1714>
        ++showing;
   4161e:	8b 05 e0 49 00 00    	mov    0x49e0(%rip),%eax        # 46004 <showing.1715>
   41624:	83 c0 01             	add    $0x1,%eax
   41627:	89 05 d7 49 00 00    	mov    %eax,0x49d7(%rip)        # 46004 <showing.1715>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4162d:	eb 0f                	jmp    4163e <memshow_virtual_animate+0x53>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   4162f:	8b 05 cf 49 00 00    	mov    0x49cf(%rip),%eax        # 46004 <showing.1715>
   41635:	83 c0 01             	add    $0x1,%eax
   41638:	89 05 c6 49 00 00    	mov    %eax,0x49c6(%rip)        # 46004 <showing.1715>
    while (showing <= 2*NPROC
   4163e:	8b 05 c0 49 00 00    	mov    0x49c0(%rip),%eax        # 46004 <showing.1715>
   41644:	83 f8 20             	cmp    $0x20,%eax
   41647:	7f 2e                	jg     41677 <memshow_virtual_animate+0x8c>
           && processes[showing % NPROC].p_state == P_FREE) {
   41649:	8b 05 b5 49 00 00    	mov    0x49b5(%rip),%eax        # 46004 <showing.1715>
   4164f:	99                   	cltd   
   41650:	c1 ea 1c             	shr    $0x1c,%edx
   41653:	01 d0                	add    %edx,%eax
   41655:	83 e0 0f             	and    $0xf,%eax
   41658:	29 d0                	sub    %edx,%eax
   4165a:	48 63 d0             	movslq %eax,%rdx
   4165d:	48 89 d0             	mov    %rdx,%rax
   41660:	48 c1 e0 04          	shl    $0x4,%rax
   41664:	48 29 d0             	sub    %rdx,%rax
   41667:	48 c1 e0 04          	shl    $0x4,%rax
   4166b:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   41671:	8b 00                	mov    (%rax),%eax
   41673:	85 c0                	test   %eax,%eax
   41675:	74 b8                	je     4162f <memshow_virtual_animate+0x44>
    }
    showing = showing % NPROC;
   41677:	8b 05 87 49 00 00    	mov    0x4987(%rip),%eax        # 46004 <showing.1715>
   4167d:	99                   	cltd   
   4167e:	c1 ea 1c             	shr    $0x1c,%edx
   41681:	01 d0                	add    %edx,%eax
   41683:	83 e0 0f             	and    $0xf,%eax
   41686:	29 d0                	sub    %edx,%eax
   41688:	89 05 76 49 00 00    	mov    %eax,0x4976(%rip)        # 46004 <showing.1715>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4168e:	8b 05 70 49 00 00    	mov    0x4970(%rip),%eax        # 46004 <showing.1715>
   41694:	48 63 d0             	movslq %eax,%rdx
   41697:	48 89 d0             	mov    %rdx,%rax
   4169a:	48 c1 e0 04          	shl    $0x4,%rax
   4169e:	48 29 d0             	sub    %rdx,%rax
   416a1:	48 c1 e0 04          	shl    $0x4,%rax
   416a5:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   416ab:	8b 00                	mov    (%rax),%eax
   416ad:	85 c0                	test   %eax,%eax
   416af:	74 76                	je     41727 <memshow_virtual_animate+0x13c>
   416b1:	8b 05 4d 49 00 00    	mov    0x494d(%rip),%eax        # 46004 <showing.1715>
   416b7:	48 63 d0             	movslq %eax,%rdx
   416ba:	48 89 d0             	mov    %rdx,%rax
   416bd:	48 c1 e0 04          	shl    $0x4,%rax
   416c1:	48 29 d0             	sub    %rdx,%rax
   416c4:	48 c1 e0 04          	shl    $0x4,%rax
   416c8:	48 05 08 a1 05 00    	add    $0x5a108,%rax
   416ce:	0f b6 00             	movzbl (%rax),%eax
   416d1:	84 c0                	test   %al,%al
   416d3:	74 52                	je     41727 <memshow_virtual_animate+0x13c>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   416d5:	8b 15 29 49 00 00    	mov    0x4929(%rip),%edx        # 46004 <showing.1715>
   416db:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   416df:	89 d1                	mov    %edx,%ecx
   416e1:	ba cc 4b 04 00       	mov    $0x44bcc,%edx
   416e6:	be 04 00 00 00       	mov    $0x4,%esi
   416eb:	48 89 c7             	mov    %rax,%rdi
   416ee:	b8 00 00 00 00       	mov    $0x0,%eax
   416f3:	e8 ec 24 00 00       	callq  43be4 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   416f8:	8b 05 06 49 00 00    	mov    0x4906(%rip),%eax        # 46004 <showing.1715>
   416fe:	48 63 d0             	movslq %eax,%rdx
   41701:	48 89 d0             	mov    %rdx,%rax
   41704:	48 c1 e0 04          	shl    $0x4,%rax
   41708:	48 29 d0             	sub    %rdx,%rax
   4170b:	48 c1 e0 04          	shl    $0x4,%rax
   4170f:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   41715:	48 8b 00             	mov    (%rax),%rax
   41718:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4171c:	48 89 d6             	mov    %rdx,%rsi
   4171f:	48 89 c7             	mov    %rax,%rdi
   41722:	e8 cb fc ff ff       	callq  413f2 <memshow_virtual>
    }
}
   41727:	90                   	nop
   41728:	c9                   	leaveq 
   41729:	c3                   	retq   

000000000004172a <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4172a:	55                   	push   %rbp
   4172b:	48 89 e5             	mov    %rsp,%rbp
   4172e:	48 83 ec 10          	sub    $0x10,%rsp
   41732:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41736:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   41739:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4173d:	78 06                	js     41745 <pageindex+0x1b>
   4173f:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   41743:	7e 14                	jle    41759 <pageindex+0x2f>
   41745:	ba e0 4b 04 00       	mov    $0x44be0,%edx
   4174a:	be 1e 00 00 00       	mov    $0x1e,%esi
   4174f:	bf f9 4b 04 00       	mov    $0x44bf9,%edi
   41754:	e8 90 16 00 00       	callq  42de9 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   41759:	b8 03 00 00 00       	mov    $0x3,%eax
   4175e:	2b 45 f4             	sub    -0xc(%rbp),%eax
   41761:	89 c2                	mov    %eax,%edx
   41763:	89 d0                	mov    %edx,%eax
   41765:	c1 e0 03             	shl    $0x3,%eax
   41768:	01 d0                	add    %edx,%eax
   4176a:	83 c0 0c             	add    $0xc,%eax
   4176d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41771:	89 c1                	mov    %eax,%ecx
   41773:	48 d3 ea             	shr    %cl,%rdx
   41776:	48 89 d0             	mov    %rdx,%rax
   41779:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4177e:	c9                   	leaveq 
   4177f:	c3                   	retq   

0000000000041780 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
static void virtual_memory_init(void);

void hardware_init(void) {
   41780:	55                   	push   %rbp
   41781:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41784:	e8 4f 01 00 00       	callq  418d8 <segments_init>
    interrupt_init();
   41789:	e8 b8 03 00 00       	callq  41b46 <interrupt_init>
    virtual_memory_init();
   4178e:	e8 8d 05 00 00       	callq  41d20 <virtual_memory_init>
}
   41793:	90                   	nop
   41794:	5d                   	pop    %rbp
   41795:	c3                   	retq   

0000000000041796 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41796:	55                   	push   %rbp
   41797:	48 89 e5             	mov    %rsp,%rbp
   4179a:	48 83 ec 18          	sub    $0x18,%rsp
   4179e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417a2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417a6:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   417a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417ac:	48 98                	cltq   
   417ae:	48 c1 e0 2d          	shl    $0x2d,%rax
   417b2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   417b6:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   417bd:	90 00 00 
   417c0:	48 09 c2             	or     %rax,%rdx
    *segment = type
   417c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417c7:	48 89 10             	mov    %rdx,(%rax)
}
   417ca:	90                   	nop
   417cb:	c9                   	leaveq 
   417cc:	c3                   	retq   

00000000000417cd <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   417cd:	55                   	push   %rbp
   417ce:	48 89 e5             	mov    %rsp,%rbp
   417d1:	48 83 ec 28          	sub    $0x28,%rsp
   417d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417d9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417dd:	89 55 ec             	mov    %edx,-0x14(%rbp)
   417e0:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   417e4:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   417e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417ec:	48 c1 e0 10          	shl    $0x10,%rax
   417f0:	48 89 c2             	mov    %rax,%rdx
   417f3:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   417fa:	00 00 00 
   417fd:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41800:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41804:	48 c1 e0 20          	shl    $0x20,%rax
   41808:	48 89 c1             	mov    %rax,%rcx
   4180b:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41812:	00 00 ff 
   41815:	48 21 c8             	and    %rcx,%rax
   41818:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4181b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4181f:	48 83 e8 01          	sub    $0x1,%rax
   41823:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41826:	48 09 d0             	or     %rdx,%rax
        | type
   41829:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4182d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41830:	48 63 d2             	movslq %edx,%rdx
   41833:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41837:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   4183a:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41841:	80 00 00 
   41844:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41847:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4184b:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4184e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41852:	48 83 c0 08          	add    $0x8,%rax
   41856:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4185a:	48 c1 ea 20          	shr    $0x20,%rdx
   4185e:	48 89 10             	mov    %rdx,(%rax)
}
   41861:	90                   	nop
   41862:	c9                   	leaveq 
   41863:	c3                   	retq   

0000000000041864 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41864:	55                   	push   %rbp
   41865:	48 89 e5             	mov    %rsp,%rbp
   41868:	48 83 ec 20          	sub    $0x20,%rsp
   4186c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41870:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41874:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41877:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4187b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4187f:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41882:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41886:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41889:	48 63 d2             	movslq %edx,%rdx
   4188c:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41890:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41893:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41897:	48 c1 e0 20          	shl    $0x20,%rax
   4189b:	48 89 c1             	mov    %rax,%rcx
   4189e:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   418a5:	00 ff ff 
   418a8:	48 21 c8             	and    %rcx,%rax
   418ab:	48 09 c2             	or     %rax,%rdx
   418ae:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   418b5:	80 00 00 
   418b8:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418bf:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   418c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418c6:	48 c1 e8 20          	shr    $0x20,%rax
   418ca:	48 89 c2             	mov    %rax,%rdx
   418cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418d1:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   418d5:	90                   	nop
   418d6:	c9                   	leaveq 
   418d7:	c3                   	retq   

00000000000418d8 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   418d8:	55                   	push   %rbp
   418d9:	48 89 e5             	mov    %rsp,%rbp
   418dc:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   418e0:	48 c7 05 15 17 01 00 	movq   $0x0,0x11715(%rip)        # 53000 <segments>
   418e7:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   418eb:	ba 00 00 00 00       	mov    $0x0,%edx
   418f0:	48 be 00 00 00 00 00 	movabs $0x20080000000000,%rsi
   418f7:	08 20 00 
   418fa:	bf 08 30 05 00       	mov    $0x53008,%edi
   418ff:	e8 92 fe ff ff       	callq  41796 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41904:	ba 03 00 00 00       	mov    $0x3,%edx
   41909:	48 be 00 00 00 00 00 	movabs $0x20080000000000,%rsi
   41910:	08 20 00 
   41913:	bf 10 30 05 00       	mov    $0x53010,%edi
   41918:	e8 79 fe ff ff       	callq  41796 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4191d:	ba 00 00 00 00       	mov    $0x0,%edx
   41922:	48 be 00 00 00 00 00 	movabs $0x20000000000,%rsi
   41929:	02 00 00 
   4192c:	bf 18 30 05 00       	mov    $0x53018,%edi
   41931:	e8 60 fe ff ff       	callq  41796 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41936:	ba 03 00 00 00       	mov    $0x3,%edx
   4193b:	48 be 00 00 00 00 00 	movabs $0x20000000000,%rsi
   41942:	02 00 00 
   41945:	bf 20 30 05 00       	mov    $0x53020,%edi
   4194a:	e8 47 fe ff ff       	callq  41796 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   4194f:	b8 40 40 05 00       	mov    $0x54040,%eax
   41954:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   4195a:	48 89 c1             	mov    %rax,%rcx
   4195d:	ba 00 00 00 00       	mov    $0x0,%edx
   41962:	48 be 00 00 00 00 00 	movabs $0x90000000000,%rsi
   41969:	09 00 00 
   4196c:	bf 28 30 05 00       	mov    $0x53028,%edi
   41971:	e8 57 fe ff ff       	callq  417cd <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41976:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   4197c:	b8 00 30 05 00       	mov    $0x53000,%eax
   41981:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41985:	ba 60 00 00 00       	mov    $0x60,%edx
   4198a:	be 00 00 00 00       	mov    $0x0,%esi
   4198f:	bf 40 40 05 00       	mov    $0x54040,%edi
   41994:	e8 8c 19 00 00       	callq  43325 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41999:	48 c7 05 a0 26 01 00 	movq   $0x80000,0x126a0(%rip)        # 54044 <kernel_task_descriptor+0x4>
   419a0:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   419a4:	ba 00 10 00 00       	mov    $0x1000,%edx
   419a9:	be 00 00 00 00       	mov    $0x0,%esi
   419ae:	bf 40 30 05 00       	mov    $0x53040,%edi
   419b3:	e8 6d 19 00 00       	callq  43325 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   419b8:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   419bf:	eb 30                	jmp    419f1 <segments_init+0x119>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   419c1:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   419c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419c9:	48 c1 e0 04          	shl    $0x4,%rax
   419cd:	48 05 40 30 05 00    	add    $0x53040,%rax
   419d3:	48 89 d1             	mov    %rdx,%rcx
   419d6:	ba 00 00 00 00       	mov    $0x0,%edx
   419db:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419e2:	0e 00 00 
   419e5:	48 89 c7             	mov    %rax,%rdi
   419e8:	e8 77 fe ff ff       	callq  41864 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   419ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   419f1:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   419f8:	76 c7                	jbe    419c1 <segments_init+0xe9>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   419fa:	b8 36 00 04 00       	mov    $0x40036,%eax
   419ff:	48 89 c1             	mov    %rax,%rcx
   41a02:	ba 00 00 00 00       	mov    $0x0,%edx
   41a07:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a0e:	0e 00 00 
   41a11:	bf 40 32 05 00       	mov    $0x53240,%edi
   41a16:	e8 49 fe ff ff       	callq  41864 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41a1b:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41a20:	48 89 c1             	mov    %rax,%rcx
   41a23:	ba 00 00 00 00       	mov    $0x0,%edx
   41a28:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a2f:	0e 00 00 
   41a32:	bf 10 31 05 00       	mov    $0x53110,%edi
   41a37:	e8 28 fe ff ff       	callq  41864 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41a3c:	b8 32 00 04 00       	mov    $0x40032,%eax
   41a41:	48 89 c1             	mov    %rax,%rcx
   41a44:	ba 00 00 00 00       	mov    $0x0,%edx
   41a49:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a50:	0e 00 00 
   41a53:	bf 20 31 05 00       	mov    $0x53120,%edi
   41a58:	e8 07 fe ff ff       	callq  41864 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41a5d:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41a64:	eb 3e                	jmp    41aa4 <segments_init+0x1cc>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41a66:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a69:	83 e8 30             	sub    $0x30,%eax
   41a6c:	89 c0                	mov    %eax,%eax
   41a6e:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41a75:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41a76:	48 89 c2             	mov    %rax,%rdx
   41a79:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a7c:	48 c1 e0 04          	shl    $0x4,%rax
   41a80:	48 05 40 30 05 00    	add    $0x53040,%rax
   41a86:	48 89 d1             	mov    %rdx,%rcx
   41a89:	ba 03 00 00 00       	mov    $0x3,%edx
   41a8e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a95:	0e 00 00 
   41a98:	48 89 c7             	mov    %rax,%rdi
   41a9b:	e8 c4 fd ff ff       	callq  41864 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41aa0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41aa4:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41aa8:	76 bc                	jbe    41a66 <segments_init+0x18e>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41aaa:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41ab0:	b8 40 30 05 00       	mov    $0x53040,%eax
   41ab5:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41ab9:	b8 28 00 00 00       	mov    $0x28,%eax
   41abe:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41ac2:	0f 00 d8             	ltr    %ax
   41ac5:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41ac9:	0f 20 c0             	mov    %cr0,%rax
   41acc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41ad0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41ad4:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41ad7:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41ade:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ae1:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41ae4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ae7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41aeb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41aef:	0f 22 c0             	mov    %rax,%cr0
}
   41af2:	90                   	nop
    lcr0(cr0);
}
   41af3:	90                   	nop
   41af4:	c9                   	leaveq 
   41af5:	c3                   	retq   

0000000000041af6 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41af6:	55                   	push   %rbp
   41af7:	48 89 e5             	mov    %rsp,%rbp
   41afa:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41afe:	0f b7 05 9b 25 01 00 	movzwl 0x1259b(%rip),%eax        # 540a0 <interrupts_enabled>
   41b05:	f7 d0                	not    %eax
   41b07:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41b0b:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b0f:	0f b6 c0             	movzbl %al,%eax
   41b12:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41b19:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b1c:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41b20:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41b23:	ee                   	out    %al,(%dx)
}
   41b24:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41b25:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b29:	66 c1 e8 08          	shr    $0x8,%ax
   41b2d:	0f b6 c0             	movzbl %al,%eax
   41b30:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41b37:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b3a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41b3e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41b41:	ee                   	out    %al,(%dx)
}
   41b42:	90                   	nop
}
   41b43:	90                   	nop
   41b44:	c9                   	leaveq 
   41b45:	c3                   	retq   

0000000000041b46 <interrupt_init>:

void interrupt_init(void) {
   41b46:	55                   	push   %rbp
   41b47:	48 89 e5             	mov    %rsp,%rbp
   41b4a:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41b4e:	66 c7 05 49 25 01 00 	movw   $0x0,0x12549(%rip)        # 540a0 <interrupts_enabled>
   41b55:	00 00 
    interrupt_mask();
   41b57:	e8 9a ff ff ff       	callq  41af6 <interrupt_mask>
   41b5c:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41b63:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b67:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41b6b:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41b6e:	ee                   	out    %al,(%dx)
}
   41b6f:	90                   	nop
   41b70:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41b77:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b7b:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41b7f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41b82:	ee                   	out    %al,(%dx)
}
   41b83:	90                   	nop
   41b84:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41b8b:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b8f:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41b93:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41b96:	ee                   	out    %al,(%dx)
}
   41b97:	90                   	nop
   41b98:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41b9f:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ba3:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41ba7:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41baa:	ee                   	out    %al,(%dx)
}
   41bab:	90                   	nop
   41bac:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41bb3:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bb7:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41bbb:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41bbe:	ee                   	out    %al,(%dx)
}
   41bbf:	90                   	nop
   41bc0:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41bc7:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bcb:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41bcf:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41bd2:	ee                   	out    %al,(%dx)
}
   41bd3:	90                   	nop
   41bd4:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41bdb:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bdf:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41be3:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41be6:	ee                   	out    %al,(%dx)
}
   41be7:	90                   	nop
   41be8:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41bef:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bf3:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41bf7:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41bfa:	ee                   	out    %al,(%dx)
}
   41bfb:	90                   	nop
   41bfc:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41c03:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c07:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c0b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c0e:	ee                   	out    %al,(%dx)
}
   41c0f:	90                   	nop
   41c10:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41c17:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c1b:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c1f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c22:	ee                   	out    %al,(%dx)
}
   41c23:	90                   	nop
   41c24:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41c2b:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c2f:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c33:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c36:	ee                   	out    %al,(%dx)
}
   41c37:	90                   	nop
   41c38:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41c3f:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c43:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c47:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c4a:	ee                   	out    %al,(%dx)
}
   41c4b:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41c4c:	e8 a5 fe ff ff       	callq  41af6 <interrupt_mask>
}
   41c51:	90                   	nop
   41c52:	c9                   	leaveq 
   41c53:	c3                   	retq   

0000000000041c54 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41c54:	55                   	push   %rbp
   41c55:	48 89 e5             	mov    %rsp,%rbp
   41c58:	48 83 ec 28          	sub    $0x28,%rsp
   41c5c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41c5f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c63:	0f 8e 9e 00 00 00    	jle    41d07 <timer_init+0xb3>
   41c69:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41c70:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c74:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c78:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c7b:	ee                   	out    %al,(%dx)
}
   41c7c:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41c7d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c80:	89 c2                	mov    %eax,%edx
   41c82:	c1 ea 1f             	shr    $0x1f,%edx
   41c85:	01 d0                	add    %edx,%eax
   41c87:	d1 f8                	sar    %eax
   41c89:	05 de 34 12 00       	add    $0x1234de,%eax
   41c8e:	99                   	cltd   
   41c8f:	f7 7d dc             	idivl  -0x24(%rbp)
   41c92:	89 c2                	mov    %eax,%edx
   41c94:	89 d0                	mov    %edx,%eax
   41c96:	c1 f8 1f             	sar    $0x1f,%eax
   41c99:	c1 e8 18             	shr    $0x18,%eax
   41c9c:	01 c2                	add    %eax,%edx
   41c9e:	0f b6 d2             	movzbl %dl,%edx
   41ca1:	29 c2                	sub    %eax,%edx
   41ca3:	89 d0                	mov    %edx,%eax
   41ca5:	0f b6 c0             	movzbl %al,%eax
   41ca8:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41caf:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cb2:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cb6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cb9:	ee                   	out    %al,(%dx)
}
   41cba:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41cbb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41cbe:	89 c2                	mov    %eax,%edx
   41cc0:	c1 ea 1f             	shr    $0x1f,%edx
   41cc3:	01 d0                	add    %edx,%eax
   41cc5:	d1 f8                	sar    %eax
   41cc7:	05 de 34 12 00       	add    $0x1234de,%eax
   41ccc:	99                   	cltd   
   41ccd:	f7 7d dc             	idivl  -0x24(%rbp)
   41cd0:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41cd6:	85 c0                	test   %eax,%eax
   41cd8:	0f 48 c2             	cmovs  %edx,%eax
   41cdb:	c1 f8 08             	sar    $0x8,%eax
   41cde:	0f b6 c0             	movzbl %al,%eax
   41ce1:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41ce8:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ceb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41cef:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cf2:	ee                   	out    %al,(%dx)
}
   41cf3:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41cf4:	0f b7 05 a5 23 01 00 	movzwl 0x123a5(%rip),%eax        # 540a0 <interrupts_enabled>
   41cfb:	83 c8 01             	or     $0x1,%eax
   41cfe:	66 89 05 9b 23 01 00 	mov    %ax,0x1239b(%rip)        # 540a0 <interrupts_enabled>
   41d05:	eb 11                	jmp    41d18 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41d07:	0f b7 05 92 23 01 00 	movzwl 0x12392(%rip),%eax        # 540a0 <interrupts_enabled>
   41d0e:	83 e0 fe             	and    $0xfffffffe,%eax
   41d11:	66 89 05 88 23 01 00 	mov    %ax,0x12388(%rip)        # 540a0 <interrupts_enabled>
    }
    interrupt_mask();
   41d18:	e8 d9 fd ff ff       	callq  41af6 <interrupt_mask>
}
   41d1d:	90                   	nop
   41d1e:	c9                   	leaveq 
   41d1f:	c3                   	retq   

0000000000041d20 <virtual_memory_init>:
//    `kernel_pagetable`.

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;

void virtual_memory_init(void) {
   41d20:	55                   	push   %rbp
   41d21:	48 89 e5             	mov    %rsp,%rbp
   41d24:	48 83 ec 10          	sub    $0x10,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   41d28:	48 c7 05 0d 96 01 00 	movq   $0x55000,0x1960d(%rip)        # 5b340 <kernel_pagetable>
   41d2f:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   41d33:	ba 00 50 00 00       	mov    $0x5000,%edx
   41d38:	be 00 00 00 00       	mov    $0x0,%esi
   41d3d:	bf 00 50 05 00       	mov    $0x55000,%edi
   41d42:	e8 de 15 00 00       	callq  43325 <memset>
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   41d47:	b8 00 60 05 00       	mov    $0x56000,%eax
   41d4c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   41d50:	48 89 05 a9 32 01 00 	mov    %rax,0x132a9(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   41d57:	b8 00 70 05 00       	mov    $0x57000,%eax
   41d5c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   41d60:	48 89 05 99 42 01 00 	mov    %rax,0x14299(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   41d67:	b8 00 80 05 00       	mov    $0x58000,%eax
   41d6c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   41d70:	48 89 05 89 52 01 00 	mov    %rax,0x15289(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   41d77:	b8 00 90 05 00       	mov    $0x59000,%eax
   41d7c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   41d80:	48 89 05 81 52 01 00 	mov    %rax,0x15281(%rip)        # 57008 <kernel_pagetables+0x2008>

    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   41d87:	48 8b 05 b2 95 01 00 	mov    0x195b2(%rip),%rax        # 5b340 <kernel_pagetable>
   41d8e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   41d94:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   41d9a:	b9 00 00 20 00       	mov    $0x200000,%ecx
   41d9f:	ba 00 00 00 00       	mov    $0x0,%edx
   41da4:	be 00 00 00 00       	mov    $0x0,%esi
   41da9:	48 89 c7             	mov    %rax,%rdi
   41dac:	e8 16 00 00 00       	callq  41dc7 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U, NULL);

    lcr3((uintptr_t) kernel_pagetable);
   41db1:	48 8b 05 88 95 01 00 	mov    0x19588(%rip),%rax        # 5b340 <kernel_pagetable>
   41db8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   41dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc0:	0f 22 d8             	mov    %rax,%cr3
}
   41dc3:	90                   	nop
}
   41dc4:	90                   	nop
   41dc5:	c9                   	leaveq 
   41dc6:	c3                   	retq   

0000000000041dc7 <virtual_memory_map>:
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm, x86_64_pagetable* (*allocator)(void));

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm,
                       x86_64_pagetable* (*allocator)(void)) {
   41dc7:	55                   	push   %rbp
   41dc8:	48 89 e5             	mov    %rsp,%rbp
   41dcb:	53                   	push   %rbx
   41dcc:	48 83 ec 58          	sub    $0x58,%rsp
   41dd0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41dd4:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   41dd8:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   41ddc:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   41de0:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)
   41de4:	4c 89 4d a0          	mov    %r9,-0x60(%rbp)
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   41de8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41dec:	25 ff 0f 00 00       	and    $0xfff,%eax
   41df1:	48 85 c0             	test   %rax,%rax
   41df4:	74 14                	je     41e0a <virtual_memory_map+0x43>
   41df6:	ba 02 4c 04 00       	mov    $0x44c02,%edx
   41dfb:	be 3b 01 00 00       	mov    $0x13b,%esi
   41e00:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41e05:	e8 df 0f 00 00       	callq  42de9 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   41e0a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41e0e:	25 ff 0f 00 00       	and    $0xfff,%eax
   41e13:	48 85 c0             	test   %rax,%rax
   41e16:	74 14                	je     41e2c <virtual_memory_map+0x65>
   41e18:	ba 22 4c 04 00       	mov    $0x44c22,%edx
   41e1d:	be 3c 01 00 00       	mov    $0x13c,%esi
   41e22:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41e27:	e8 bd 0f 00 00       	callq  42de9 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   41e2c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   41e30:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41e34:	48 01 d0             	add    %rdx,%rax
   41e37:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   41e3b:	76 24                	jbe    41e61 <virtual_memory_map+0x9a>
   41e3d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   41e41:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41e45:	48 01 d0             	add    %rdx,%rax
   41e48:	48 85 c0             	test   %rax,%rax
   41e4b:	74 14                	je     41e61 <virtual_memory_map+0x9a>
   41e4d:	ba 35 4c 04 00       	mov    $0x44c35,%edx
   41e52:	be 3d 01 00 00       	mov    $0x13d,%esi
   41e57:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41e5c:	e8 88 0f 00 00       	callq  42de9 <assert_fail>
    if (perm & PTE_P) {
   41e61:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41e64:	48 98                	cltq   
   41e66:	83 e0 01             	and    $0x1,%eax
   41e69:	48 85 c0             	test   %rax,%rax
   41e6c:	74 6e                	je     41edc <virtual_memory_map+0x115>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   41e6e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41e72:	25 ff 0f 00 00       	and    $0xfff,%eax
   41e77:	48 85 c0             	test   %rax,%rax
   41e7a:	74 14                	je     41e90 <virtual_memory_map+0xc9>
   41e7c:	ba 53 4c 04 00       	mov    $0x44c53,%edx
   41e81:	be 3f 01 00 00       	mov    $0x13f,%esi
   41e86:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41e8b:	e8 59 0f 00 00       	callq  42de9 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   41e90:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41e94:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41e98:	48 01 d0             	add    %rdx,%rax
   41e9b:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   41e9f:	76 14                	jbe    41eb5 <virtual_memory_map+0xee>
   41ea1:	ba 66 4c 04 00       	mov    $0x44c66,%edx
   41ea6:	be 40 01 00 00       	mov    $0x140,%esi
   41eab:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41eb0:	e8 34 0f 00 00       	callq  42de9 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   41eb5:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41eb9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41ebd:	48 01 d0             	add    %rdx,%rax
   41ec0:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   41ec6:	76 14                	jbe    41edc <virtual_memory_map+0x115>
   41ec8:	ba 74 4c 04 00       	mov    $0x44c74,%edx
   41ecd:	be 41 01 00 00       	mov    $0x141,%esi
   41ed2:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41ed7:	e8 0d 0f 00 00       	callq  42de9 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense
   41edc:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   41ee0:	78 09                	js     41eeb <virtual_memory_map+0x124>
   41ee2:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   41ee9:	7e 14                	jle    41eff <virtual_memory_map+0x138>
   41eeb:	ba 90 4c 04 00       	mov    $0x44c90,%edx
   41ef0:	be 43 01 00 00       	mov    $0x143,%esi
   41ef5:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41efa:	e8 ea 0e 00 00       	callq  42de9 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   41eff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41f03:	25 ff 0f 00 00       	and    $0xfff,%eax
   41f08:	48 85 c0             	test   %rax,%rax
   41f0b:	74 14                	je     41f21 <virtual_memory_map+0x15a>
   41f0d:	ba b0 4c 04 00       	mov    $0x44cb0,%edx
   41f12:	be 44 01 00 00       	mov    $0x144,%esi
   41f17:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   41f1c:	e8 c8 0e 00 00       	callq  42de9 <assert_fail>

    int last_index123 = -1;
   41f21:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   41f28:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   41f2f:	00 
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   41f30:	e9 ce 00 00 00       	jmpq   42003 <virtual_memory_map+0x23c>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   41f35:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41f39:	48 c1 e8 15          	shr    $0x15,%rax
   41f3d:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   41f40:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f43:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   41f46:	74 21                	je     41f69 <virtual_memory_map+0x1a2>
            l4pagetable = lookup_l4pagetable(pagetable, va, perm, allocator);
   41f48:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   41f4c:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41f4f:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   41f53:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41f57:	48 89 c7             	mov    %rax,%rdi
   41f5a:	e8 bb 00 00 00       	callq  4201a <lookup_l4pagetable>
   41f5f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   41f63:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f66:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) {
   41f69:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41f6c:	48 98                	cltq   
   41f6e:	83 e0 01             	and    $0x1,%eax
   41f71:	48 85 c0             	test   %rax,%rax
   41f74:	74 34                	je     41faa <virtual_memory_map+0x1e3>
   41f76:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41f7b:	74 2d                	je     41faa <virtual_memory_map+0x1e3>
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   41f7d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41f80:	48 63 d8             	movslq %eax,%rbx
   41f83:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41f87:	be 03 00 00 00       	mov    $0x3,%esi
   41f8c:	48 89 c7             	mov    %rax,%rdi
   41f8f:	e8 96 f7 ff ff       	callq  4172a <pageindex>
   41f94:	89 c2                	mov    %eax,%edx
   41f96:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   41f9a:	48 89 d9             	mov    %rbx,%rcx
   41f9d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41fa1:	48 63 d2             	movslq %edx,%rdx
   41fa4:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   41fa8:	eb 41                	jmp    41feb <virtual_memory_map+0x224>
        } else if (l4pagetable) {
   41faa:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41faf:	74 26                	je     41fd7 <virtual_memory_map+0x210>
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   41fb1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41fb5:	be 03 00 00 00       	mov    $0x3,%esi
   41fba:	48 89 c7             	mov    %rax,%rdi
   41fbd:	e8 68 f7 ff ff       	callq  4172a <pageindex>
   41fc2:	89 c2                	mov    %eax,%edx
   41fc4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41fc7:	48 63 c8             	movslq %eax,%rcx
   41fca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41fce:	48 63 d2             	movslq %edx,%rdx
   41fd1:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   41fd5:	eb 14                	jmp    41feb <virtual_memory_map+0x224>
        } else if (perm & PTE_P) {
   41fd7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41fda:	48 98                	cltq   
   41fdc:	83 e0 01             	and    $0x1,%eax
   41fdf:	48 85 c0             	test   %rax,%rax
   41fe2:	74 07                	je     41feb <virtual_memory_map+0x224>
            return -1;
   41fe4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41fe9:	eb 28                	jmp    42013 <virtual_memory_map+0x24c>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   41feb:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   41ff2:	00 
   41ff3:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   41ffa:	00 
   41ffb:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42002:	00 
   42003:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42008:	0f 85 27 ff ff ff    	jne    41f35 <virtual_memory_map+0x16e>
        }
    }
    return 0;
   4200e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42013:	48 83 c4 58          	add    $0x58,%rsp
   42017:	5b                   	pop    %rbx
   42018:	5d                   	pop    %rbp
   42019:	c3                   	retq   

000000000004201a <lookup_l4pagetable>:

static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm, x86_64_pagetable* (*allocator)(void)) {
   4201a:	55                   	push   %rbp
   4201b:	48 89 e5             	mov    %rsp,%rbp
   4201e:	48 83 ec 40          	sub    $0x40,%rsp
   42022:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42026:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4202a:	89 55 cc             	mov    %edx,-0x34(%rbp)
   4202d:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    x86_64_pagetable* pt = pagetable;
   42031:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42035:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42039:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42040:	e9 69 01 00 00       	jmpq   421ae <lookup_l4pagetable+0x194>
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42045:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42048:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4204c:	89 d6                	mov    %edx,%esi
   4204e:	48 89 c7             	mov    %rax,%rdi
   42051:	e8 d4 f6 ff ff       	callq  4172a <pageindex>
   42056:	89 c2                	mov    %eax,%edx
   42058:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4205c:	48 63 d2             	movslq %edx,%rdx
   4205f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42063:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (!(pe & PTE_P)) {
   42067:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4206b:	83 e0 01             	and    $0x1,%eax
   4206e:	48 85 c0             	test   %rax,%rax
   42071:	0f 85 a5 00 00 00    	jne    4211c <lookup_l4pagetable+0x102>
            // allocate a new page table page if required
            if (!(perm & PTE_P) || !allocator) {
   42077:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4207a:	48 98                	cltq   
   4207c:	83 e0 01             	and    $0x1,%eax
   4207f:	48 85 c0             	test   %rax,%rax
   42082:	74 07                	je     4208b <lookup_l4pagetable+0x71>
   42084:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42089:	75 0a                	jne    42095 <lookup_l4pagetable+0x7b>
                return NULL;
   4208b:	b8 00 00 00 00       	mov    $0x0,%eax
   42090:	e9 27 01 00 00       	jmpq   421bc <lookup_l4pagetable+0x1a2>
            }
            x86_64_pagetable* new_pt = allocator();
   42095:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42099:	ff d0                	callq  *%rax
   4209b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (!new_pt) {
   4209f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   420a4:	75 0a                	jne    420b0 <lookup_l4pagetable+0x96>
                return NULL;
   420a6:	b8 00 00 00 00       	mov    $0x0,%eax
   420ab:	e9 0c 01 00 00       	jmpq   421bc <lookup_l4pagetable+0x1a2>
            }
            assert((uintptr_t) new_pt % PAGESIZE == 0);
   420b0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   420b4:	25 ff 0f 00 00       	and    $0xfff,%eax
   420b9:	48 85 c0             	test   %rax,%rax
   420bc:	74 14                	je     420d2 <lookup_l4pagetable+0xb8>
   420be:	ba d8 4c 04 00       	mov    $0x44cd8,%edx
   420c3:	be 67 01 00 00       	mov    $0x167,%esi
   420c8:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   420cd:	e8 17 0d 00 00       	callq  42de9 <assert_fail>
            pt->entry[PAGEINDEX(va, i)] = pe =
                PTE_ADDR(new_pt) | PTE_P | PTE_W | PTE_U;
   420d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   420d6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
            pt->entry[PAGEINDEX(va, i)] = pe =
   420dc:	48 83 c8 07          	or     $0x7,%rax
   420e0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   420e4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   420eb:	89 d6                	mov    %edx,%esi
   420ed:	48 89 c7             	mov    %rax,%rdi
   420f0:	e8 35 f6 ff ff       	callq  4172a <pageindex>
   420f5:	89 c2                	mov    %eax,%edx
   420f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420fb:	48 63 d2             	movslq %edx,%rdx
   420fe:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42102:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
            memset(new_pt, 0, PAGESIZE);
   42106:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4210a:	ba 00 10 00 00       	mov    $0x1000,%edx
   4210f:	be 00 00 00 00       	mov    $0x0,%esi
   42114:	48 89 c7             	mov    %rax,%rdi
   42117:	e8 09 12 00 00       	callq  43325 <memset>
        }

        // sanity-check page entry
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4211c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42120:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42126:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4212c:	76 14                	jbe    42142 <lookup_l4pagetable+0x128>
   4212e:	ba 00 4d 04 00       	mov    $0x44d00,%edx
   42133:	be 6e 01 00 00       	mov    $0x16e,%esi
   42138:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   4213d:	e8 a7 0c 00 00       	callq  42de9 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42142:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42145:	48 98                	cltq   
   42147:	83 e0 02             	and    $0x2,%eax
   4214a:	48 85 c0             	test   %rax,%rax
   4214d:	74 20                	je     4216f <lookup_l4pagetable+0x155>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4214f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42153:	83 e0 02             	and    $0x2,%eax
   42156:	48 85 c0             	test   %rax,%rax
   42159:	75 14                	jne    4216f <lookup_l4pagetable+0x155>
   4215b:	ba 20 4d 04 00       	mov    $0x44d20,%edx
   42160:	be 70 01 00 00       	mov    $0x170,%esi
   42165:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   4216a:	e8 7a 0c 00 00       	callq  42de9 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4216f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42172:	48 98                	cltq   
   42174:	83 e0 04             	and    $0x4,%eax
   42177:	48 85 c0             	test   %rax,%rax
   4217a:	74 20                	je     4219c <lookup_l4pagetable+0x182>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4217c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42180:	83 e0 04             	and    $0x4,%eax
   42183:	48 85 c0             	test   %rax,%rax
   42186:	75 14                	jne    4219c <lookup_l4pagetable+0x182>
   42188:	ba 2b 4d 04 00       	mov    $0x44d2b,%edx
   4218d:	be 73 01 00 00       	mov    $0x173,%esi
   42192:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   42197:	e8 4d 0c 00 00       	callq  42de9 <assert_fail>
        }

        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   4219c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   421a0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   421a6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   421aa:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   421ae:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   421b2:	0f 8e 8d fe ff ff    	jle    42045 <lookup_l4pagetable+0x2b>
    }
    return pt;
   421b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   421bc:	c9                   	leaveq 
   421bd:	c3                   	retq   

00000000000421be <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   421be:	55                   	push   %rbp
   421bf:	48 89 e5             	mov    %rsp,%rbp
   421c2:	48 83 ec 50          	sub    $0x50,%rsp
   421c6:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   421ca:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   421ce:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   421d2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   421d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   421da:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   421e1:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   421e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   421e9:	eb 41                	jmp    4222c <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   421eb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421ee:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   421f2:	89 d6                	mov    %edx,%esi
   421f4:	48 89 c7             	mov    %rax,%rdi
   421f7:	e8 2e f5 ff ff       	callq  4172a <pageindex>
   421fc:	89 c2                	mov    %eax,%edx
   421fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42202:	48 63 d2             	movslq %edx,%rdx
   42205:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42209:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4220d:	83 e2 06             	and    $0x6,%edx
   42210:	48 f7 d2             	not    %rdx
   42213:	48 21 d0             	and    %rdx,%rax
   42216:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   4221a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4221e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42224:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42228:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   4222c:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42230:	7f 0c                	jg     4223e <virtual_memory_lookup+0x80>
   42232:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42236:	83 e0 01             	and    $0x1,%eax
   42239:	48 85 c0             	test   %rax,%rax
   4223c:	75 ad                	jne    421eb <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4223e:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42245:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   4224c:	ff 
   4224d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42254:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42258:	83 e0 01             	and    $0x1,%eax
   4225b:	48 85 c0             	test   %rax,%rax
   4225e:	74 34                	je     42294 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42260:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42264:	48 c1 e8 0c          	shr    $0xc,%rax
   42268:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   4226b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4226f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42275:	48 89 c2             	mov    %rax,%rdx
   42278:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4227c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42281:	48 09 d0             	or     %rdx,%rax
   42284:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42288:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4228c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42291:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42294:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42298:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4229c:	48 89 10             	mov    %rdx,(%rax)
   4229f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   422a3:	48 89 50 08          	mov    %rdx,0x8(%rax)
   422a7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   422ab:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   422af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   422b3:	c9                   	leaveq 
   422b4:	c3                   	retq   

00000000000422b5 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   422b5:	55                   	push   %rbp
   422b6:	48 89 e5             	mov    %rsp,%rbp
   422b9:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   422bd:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   422c1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   422c5:	25 ff 0f 00 00       	and    $0xfff,%eax
   422ca:	48 85 c0             	test   %rax,%rax
   422cd:	74 14                	je     422e3 <set_pagetable+0x2e>
   422cf:	ba 36 4d 04 00       	mov    $0x44d36,%edx
   422d4:	be 97 01 00 00       	mov    $0x197,%esi
   422d9:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   422de:	e8 06 0b 00 00       	callq  42de9 <assert_fail>
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   422e3:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   422e8:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   422ec:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   422f0:	48 89 ce             	mov    %rcx,%rsi
   422f3:	48 89 c7             	mov    %rax,%rdi
   422f6:	e8 c3 fe ff ff       	callq  421be <virtual_memory_lookup>
   422fb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   422ff:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42304:	48 39 d0             	cmp    %rdx,%rax
   42307:	74 14                	je     4231d <set_pagetable+0x68>
   42309:	ba 58 4d 04 00       	mov    $0x44d58,%edx
   4230e:	be 98 01 00 00       	mov    $0x198,%esi
   42313:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   42318:	e8 cc 0a 00 00       	callq  42de9 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4231d:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42321:	48 8b 0d 18 90 01 00 	mov    0x19018(%rip),%rcx        # 5b340 <kernel_pagetable>
   42328:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4232c:	48 89 ce             	mov    %rcx,%rsi
   4232f:	48 89 c7             	mov    %rax,%rdi
   42332:	e8 87 fe ff ff       	callq  421be <virtual_memory_lookup>
   42337:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4233b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4233f:	48 39 c2             	cmp    %rax,%rdx
   42342:	74 14                	je     42358 <set_pagetable+0xa3>
   42344:	ba c0 4d 04 00       	mov    $0x44dc0,%edx
   42349:	be 9a 01 00 00       	mov    $0x19a,%esi
   4234e:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   42353:	e8 91 0a 00 00       	callq  42de9 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42358:	48 8b 05 e1 8f 01 00 	mov    0x18fe1(%rip),%rax        # 5b340 <kernel_pagetable>
   4235f:	48 89 c2             	mov    %rax,%rdx
   42362:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42366:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4236a:	48 89 ce             	mov    %rcx,%rsi
   4236d:	48 89 c7             	mov    %rax,%rdi
   42370:	e8 49 fe ff ff       	callq  421be <virtual_memory_lookup>
   42375:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42379:	48 8b 15 c0 8f 01 00 	mov    0x18fc0(%rip),%rdx        # 5b340 <kernel_pagetable>
   42380:	48 39 d0             	cmp    %rdx,%rax
   42383:	74 14                	je     42399 <set_pagetable+0xe4>
   42385:	ba 20 4e 04 00       	mov    $0x44e20,%edx
   4238a:	be 9c 01 00 00       	mov    $0x19c,%esi
   4238f:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   42394:	e8 50 0a 00 00       	callq  42de9 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42399:	ba c7 1d 04 00       	mov    $0x41dc7,%edx
   4239e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   423a2:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   423a6:	48 89 ce             	mov    %rcx,%rsi
   423a9:	48 89 c7             	mov    %rax,%rdi
   423ac:	e8 0d fe ff ff       	callq  421be <virtual_memory_lookup>
   423b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   423b5:	ba c7 1d 04 00       	mov    $0x41dc7,%edx
   423ba:	48 39 d0             	cmp    %rdx,%rax
   423bd:	74 14                	je     423d3 <set_pagetable+0x11e>
   423bf:	ba 88 4e 04 00       	mov    $0x44e88,%edx
   423c4:	be 9e 01 00 00       	mov    $0x19e,%esi
   423c9:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   423ce:	e8 16 0a 00 00       	callq  42de9 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   423d3:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   423d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423df:	0f 22 d8             	mov    %rax,%cr3
}
   423e2:	90                   	nop
}
   423e3:	90                   	nop
   423e4:	c9                   	leaveq 
   423e5:	c3                   	retq   

00000000000423e6 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   423e6:	55                   	push   %rbp
   423e7:	48 89 e5             	mov    %rsp,%rbp
   423ea:	48 83 ec 08          	sub    $0x8,%rsp
   423ee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   423f2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   423f7:	74 14                	je     4240d <physical_memory_isreserved+0x27>
   423f9:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   42400:	00 
   42401:	76 11                	jbe    42414 <physical_memory_isreserved+0x2e>
   42403:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   4240a:	00 
   4240b:	77 07                	ja     42414 <physical_memory_isreserved+0x2e>
   4240d:	b8 01 00 00 00       	mov    $0x1,%eax
   42412:	eb 05                	jmp    42419 <physical_memory_isreserved+0x33>
   42414:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42419:	c9                   	leaveq 
   4241a:	c3                   	retq   

000000000004241b <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   4241b:	55                   	push   %rbp
   4241c:	48 89 e5             	mov    %rsp,%rbp
   4241f:	48 83 ec 10          	sub    $0x10,%rsp
   42423:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42426:	89 75 f8             	mov    %esi,-0x8(%rbp)
   42429:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4242c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4242f:	c1 e0 10             	shl    $0x10,%eax
   42432:	89 c2                	mov    %eax,%edx
   42434:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42437:	c1 e0 0b             	shl    $0xb,%eax
   4243a:	09 c2                	or     %eax,%edx
   4243c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4243f:	c1 e0 08             	shl    $0x8,%eax
   42442:	09 d0                	or     %edx,%eax
}
   42444:	c9                   	leaveq 
   42445:	c3                   	retq   

0000000000042446 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42446:	55                   	push   %rbp
   42447:	48 89 e5             	mov    %rsp,%rbp
   4244a:	48 83 ec 18          	sub    $0x18,%rsp
   4244e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42451:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42454:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42457:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4245a:	09 d0                	or     %edx,%eax
   4245c:	0d 00 00 00 80       	or     $0x80000000,%eax
   42461:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42468:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   4246b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4246e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42471:	ef                   	out    %eax,(%dx)
}
   42472:	90                   	nop
   42473:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   4247a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4247d:	89 c2                	mov    %eax,%edx
   4247f:	ed                   	in     (%dx),%eax
   42480:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42483:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42486:	c9                   	leaveq 
   42487:	c3                   	retq   

0000000000042488 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42488:	55                   	push   %rbp
   42489:	48 89 e5             	mov    %rsp,%rbp
   4248c:	48 83 ec 28          	sub    $0x28,%rsp
   42490:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42493:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42496:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4249d:	eb 73                	jmp    42512 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   4249f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   424a6:	eb 60                	jmp    42508 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   424a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   424af:	eb 4a                	jmp    424fb <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   424b1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424b4:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   424b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424ba:	89 ce                	mov    %ecx,%esi
   424bc:	89 c7                	mov    %eax,%edi
   424be:	e8 58 ff ff ff       	callq  4241b <pci_make_configaddr>
   424c3:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   424c6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424c9:	be 00 00 00 00       	mov    $0x0,%esi
   424ce:	89 c7                	mov    %eax,%edi
   424d0:	e8 71 ff ff ff       	callq  42446 <pci_config_readl>
   424d5:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   424d8:	8b 45 d8             	mov    -0x28(%rbp),%eax
   424db:	c1 e0 10             	shl    $0x10,%eax
   424de:	0b 45 dc             	or     -0x24(%rbp),%eax
   424e1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   424e4:	75 05                	jne    424eb <pci_find_device+0x63>
                    return configaddr;
   424e6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424e9:	eb 35                	jmp    42520 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   424eb:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   424ef:	75 06                	jne    424f7 <pci_find_device+0x6f>
   424f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   424f5:	74 0c                	je     42503 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   424f7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   424fb:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   424ff:	75 b0                	jne    424b1 <pci_find_device+0x29>
   42501:	eb 01                	jmp    42504 <pci_find_device+0x7c>
                    break;
   42503:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   42504:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42508:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   4250c:	75 9a                	jne    424a8 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   4250e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42512:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42519:	75 84                	jne    4249f <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   4251b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42520:	c9                   	leaveq 
   42521:	c3                   	retq   

0000000000042522 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   42522:	55                   	push   %rbp
   42523:	48 89 e5             	mov    %rsp,%rbp
   42526:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   4252a:	be 13 71 00 00       	mov    $0x7113,%esi
   4252f:	bf 86 80 00 00       	mov    $0x8086,%edi
   42534:	e8 4f ff ff ff       	callq  42488 <pci_find_device>
   42539:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4253c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   42540:	78 30                	js     42572 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42542:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42545:	be 40 00 00 00       	mov    $0x40,%esi
   4254a:	89 c7                	mov    %eax,%edi
   4254c:	e8 f5 fe ff ff       	callq  42446 <pci_config_readl>
   42551:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42556:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42559:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4255c:	83 c0 04             	add    $0x4,%eax
   4255f:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42562:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42568:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4256c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4256f:	66 ef                	out    %ax,(%dx)
}
   42571:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42572:	ba ee 4e 04 00       	mov    $0x44eee,%edx
   42577:	be 00 c0 00 00       	mov    $0xc000,%esi
   4257c:	bf 80 07 00 00       	mov    $0x780,%edi
   42581:	b8 00 00 00 00       	mov    $0x0,%eax
   42586:	e8 d8 15 00 00       	callq  43b63 <console_printf>
 spinloop: goto spinloop;
   4258b:	eb fe                	jmp    4258b <poweroff+0x69>

000000000004258d <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4258d:	55                   	push   %rbp
   4258e:	48 89 e5             	mov    %rsp,%rbp
   42591:	48 83 ec 10          	sub    $0x10,%rsp
   42595:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   4259c:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   425a0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425a4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   425a7:	ee                   	out    %al,(%dx)
}
   425a8:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   425a9:	eb fe                	jmp    425a9 <reboot+0x1c>

00000000000425ab <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   425ab:	55                   	push   %rbp
   425ac:	48 89 e5             	mov    %rsp,%rbp
   425af:	48 83 ec 10          	sub    $0x10,%rsp
   425b3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425b7:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   425ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425be:	48 83 c0 18          	add    $0x18,%rax
   425c2:	ba c0 00 00 00       	mov    $0xc0,%edx
   425c7:	be 00 00 00 00       	mov    $0x0,%esi
   425cc:	48 89 c7             	mov    %rax,%rdi
   425cf:	e8 51 0d 00 00       	callq  43325 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   425d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425d8:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   425df:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   425e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425e5:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   425ec:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   425f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425f4:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   425fb:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   425ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42603:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   4260a:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   4260c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42610:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   42617:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   4261b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4261e:	83 e0 01             	and    $0x1,%eax
   42621:	85 c0                	test   %eax,%eax
   42623:	74 1c                	je     42641 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42625:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42629:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   42630:	80 cc 30             	or     $0x30,%ah
   42633:	48 89 c2             	mov    %rax,%rdx
   42636:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4263a:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42641:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42644:	83 e0 02             	and    $0x2,%eax
   42647:	85 c0                	test   %eax,%eax
   42649:	74 1c                	je     42667 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   4264b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4264f:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   42656:	80 e4 fd             	and    $0xfd,%ah
   42659:	48 89 c2             	mov    %rax,%rdx
   4265c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42660:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   42667:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4266b:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   42672:	90                   	nop
   42673:	c9                   	leaveq 
   42674:	c3                   	retq   

0000000000042675 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42675:	55                   	push   %rbp
   42676:	48 89 e5             	mov    %rsp,%rbp
   42679:	48 83 ec 28          	sub    $0x28,%rsp
   4267d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42680:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42684:	78 09                	js     4268f <console_show_cursor+0x1a>
   42686:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4268d:	7e 07                	jle    42696 <console_show_cursor+0x21>
        cpos = 0;
   4268f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42696:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4269d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426a1:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   426a5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   426a8:	ee                   	out    %al,(%dx)
}
   426a9:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   426aa:	8b 45 dc             	mov    -0x24(%rbp),%eax
   426ad:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   426b3:	85 c0                	test   %eax,%eax
   426b5:	0f 48 c2             	cmovs  %edx,%eax
   426b8:	c1 f8 08             	sar    $0x8,%eax
   426bb:	0f b6 c0             	movzbl %al,%eax
   426be:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   426c5:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426c8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   426cc:	8b 55 ec             	mov    -0x14(%rbp),%edx
   426cf:	ee                   	out    %al,(%dx)
}
   426d0:	90                   	nop
   426d1:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   426d8:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426dc:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   426e0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   426e3:	ee                   	out    %al,(%dx)
}
   426e4:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   426e5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   426e8:	99                   	cltd   
   426e9:	c1 ea 18             	shr    $0x18,%edx
   426ec:	01 d0                	add    %edx,%eax
   426ee:	0f b6 c0             	movzbl %al,%eax
   426f1:	29 d0                	sub    %edx,%eax
   426f3:	0f b6 c0             	movzbl %al,%eax
   426f6:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   426fd:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42700:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42704:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42707:	ee                   	out    %al,(%dx)
}
   42708:	90                   	nop
}
   42709:	90                   	nop
   4270a:	c9                   	leaveq 
   4270b:	c3                   	retq   

000000000004270c <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4270c:	55                   	push   %rbp
   4270d:	48 89 e5             	mov    %rsp,%rbp
   42710:	48 83 ec 20          	sub    $0x20,%rsp
   42714:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4271b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4271e:	89 c2                	mov    %eax,%edx
   42720:	ec                   	in     (%dx),%al
   42721:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42724:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42728:	0f b6 c0             	movzbl %al,%eax
   4272b:	83 e0 01             	and    $0x1,%eax
   4272e:	85 c0                	test   %eax,%eax
   42730:	75 0a                	jne    4273c <keyboard_readc+0x30>
        return -1;
   42732:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42737:	e9 e5 01 00 00       	jmpq   42921 <keyboard_readc+0x215>
   4273c:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42743:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42746:	89 c2                	mov    %eax,%edx
   42748:	ec                   	in     (%dx),%al
   42749:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4274c:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42750:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42753:	0f b6 05 a6 78 01 00 	movzbl 0x178a6(%rip),%eax        # 5a000 <last_escape.1676>
   4275a:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4275d:	c6 05 9c 78 01 00 00 	movb   $0x0,0x1789c(%rip)        # 5a000 <last_escape.1676>

    if (data == 0xE0) {         // mode shift
   42764:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42768:	75 11                	jne    4277b <keyboard_readc+0x6f>
        last_escape = 0x80;
   4276a:	c6 05 8f 78 01 00 80 	movb   $0x80,0x1788f(%rip)        # 5a000 <last_escape.1676>
        return 0;
   42771:	b8 00 00 00 00       	mov    $0x0,%eax
   42776:	e9 a6 01 00 00       	jmpq   42921 <keyboard_readc+0x215>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4277b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4277f:	84 c0                	test   %al,%al
   42781:	79 5e                	jns    427e1 <keyboard_readc+0xd5>
        int ch = keymap[(data & 0x7F) | escape];
   42783:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42787:	83 e0 7f             	and    $0x7f,%eax
   4278a:	89 c2                	mov    %eax,%edx
   4278c:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42790:	09 d0                	or     %edx,%eax
   42792:	48 98                	cltq   
   42794:	0f b6 80 20 4f 04 00 	movzbl 0x44f20(%rax),%eax
   4279b:	0f b6 c0             	movzbl %al,%eax
   4279e:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   427a1:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   427a8:	7e 2d                	jle    427d7 <keyboard_readc+0xcb>
   427aa:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   427b1:	7f 24                	jg     427d7 <keyboard_readc+0xcb>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   427b3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   427b6:	2d fa 00 00 00       	sub    $0xfa,%eax
   427bb:	ba 01 00 00 00       	mov    $0x1,%edx
   427c0:	89 c1                	mov    %eax,%ecx
   427c2:	d3 e2                	shl    %cl,%edx
   427c4:	89 d0                	mov    %edx,%eax
   427c6:	f7 d0                	not    %eax
   427c8:	0f b6 15 32 78 01 00 	movzbl 0x17832(%rip),%edx        # 5a001 <modifiers.1675>
   427cf:	21 d0                	and    %edx,%eax
   427d1:	88 05 2a 78 01 00    	mov    %al,0x1782a(%rip)        # 5a001 <modifiers.1675>
        }
        return 0;
   427d7:	b8 00 00 00 00       	mov    $0x0,%eax
   427dc:	e9 40 01 00 00       	jmpq   42921 <keyboard_readc+0x215>
    }

    int ch = (unsigned char) keymap[data | escape];
   427e1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   427e5:	0a 45 fa             	or     -0x6(%rbp),%al
   427e8:	0f b6 c0             	movzbl %al,%eax
   427eb:	48 98                	cltq   
   427ed:	0f b6 80 20 4f 04 00 	movzbl 0x44f20(%rax),%eax
   427f4:	0f b6 c0             	movzbl %al,%eax
   427f7:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   427fa:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   427fe:	7e 57                	jle    42857 <keyboard_readc+0x14b>
   42800:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42804:	7f 51                	jg     42857 <keyboard_readc+0x14b>
        if (modifiers & MOD_CONTROL) {
   42806:	0f b6 05 f4 77 01 00 	movzbl 0x177f4(%rip),%eax        # 5a001 <modifiers.1675>
   4280d:	0f b6 c0             	movzbl %al,%eax
   42810:	83 e0 02             	and    $0x2,%eax
   42813:	85 c0                	test   %eax,%eax
   42815:	74 09                	je     42820 <keyboard_readc+0x114>
            ch -= 0x60;
   42817:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4281b:	e9 fd 00 00 00       	jmpq   4291d <keyboard_readc+0x211>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42820:	0f b6 05 da 77 01 00 	movzbl 0x177da(%rip),%eax        # 5a001 <modifiers.1675>
   42827:	0f b6 c0             	movzbl %al,%eax
   4282a:	83 e0 01             	and    $0x1,%eax
   4282d:	85 c0                	test   %eax,%eax
   4282f:	0f 94 c2             	sete   %dl
   42832:	0f b6 05 c8 77 01 00 	movzbl 0x177c8(%rip),%eax        # 5a001 <modifiers.1675>
   42839:	0f b6 c0             	movzbl %al,%eax
   4283c:	83 e0 08             	and    $0x8,%eax
   4283f:	85 c0                	test   %eax,%eax
   42841:	0f 94 c0             	sete   %al
   42844:	31 d0                	xor    %edx,%eax
   42846:	84 c0                	test   %al,%al
   42848:	0f 84 cf 00 00 00    	je     4291d <keyboard_readc+0x211>
            ch -= 0x20;
   4284e:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42852:	e9 c6 00 00 00       	jmpq   4291d <keyboard_readc+0x211>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42857:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4285e:	7e 30                	jle    42890 <keyboard_readc+0x184>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42860:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42863:	2d fa 00 00 00       	sub    $0xfa,%eax
   42868:	ba 01 00 00 00       	mov    $0x1,%edx
   4286d:	89 c1                	mov    %eax,%ecx
   4286f:	d3 e2                	shl    %cl,%edx
   42871:	89 d0                	mov    %edx,%eax
   42873:	89 c2                	mov    %eax,%edx
   42875:	0f b6 05 85 77 01 00 	movzbl 0x17785(%rip),%eax        # 5a001 <modifiers.1675>
   4287c:	31 d0                	xor    %edx,%eax
   4287e:	88 05 7d 77 01 00    	mov    %al,0x1777d(%rip)        # 5a001 <modifiers.1675>
        ch = 0;
   42884:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4288b:	e9 8e 00 00 00       	jmpq   4291e <keyboard_readc+0x212>
    } else if (ch >= KEY_SHIFT) {
   42890:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42897:	7e 2d                	jle    428c6 <keyboard_readc+0x1ba>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42899:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4289c:	2d fa 00 00 00       	sub    $0xfa,%eax
   428a1:	ba 01 00 00 00       	mov    $0x1,%edx
   428a6:	89 c1                	mov    %eax,%ecx
   428a8:	d3 e2                	shl    %cl,%edx
   428aa:	89 d0                	mov    %edx,%eax
   428ac:	89 c2                	mov    %eax,%edx
   428ae:	0f b6 05 4c 77 01 00 	movzbl 0x1774c(%rip),%eax        # 5a001 <modifiers.1675>
   428b5:	09 d0                	or     %edx,%eax
   428b7:	88 05 44 77 01 00    	mov    %al,0x17744(%rip)        # 5a001 <modifiers.1675>
        ch = 0;
   428bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428c4:	eb 58                	jmp    4291e <keyboard_readc+0x212>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   428c6:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   428ca:	7e 31                	jle    428fd <keyboard_readc+0x1f1>
   428cc:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   428d3:	7f 28                	jg     428fd <keyboard_readc+0x1f1>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   428d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428d8:	8d 50 80             	lea    -0x80(%rax),%edx
   428db:	0f b6 05 1f 77 01 00 	movzbl 0x1771f(%rip),%eax        # 5a001 <modifiers.1675>
   428e2:	0f b6 c0             	movzbl %al,%eax
   428e5:	83 e0 03             	and    $0x3,%eax
   428e8:	48 98                	cltq   
   428ea:	48 63 d2             	movslq %edx,%rdx
   428ed:	0f b6 84 90 20 50 04 	movzbl 0x45020(%rax,%rdx,4),%eax
   428f4:	00 
   428f5:	0f b6 c0             	movzbl %al,%eax
   428f8:	89 45 fc             	mov    %eax,-0x4(%rbp)
   428fb:	eb 21                	jmp    4291e <keyboard_readc+0x212>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   428fd:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42901:	7f 1b                	jg     4291e <keyboard_readc+0x212>
   42903:	0f b6 05 f7 76 01 00 	movzbl 0x176f7(%rip),%eax        # 5a001 <modifiers.1675>
   4290a:	0f b6 c0             	movzbl %al,%eax
   4290d:	83 e0 02             	and    $0x2,%eax
   42910:	85 c0                	test   %eax,%eax
   42912:	74 0a                	je     4291e <keyboard_readc+0x212>
        ch = 0;
   42914:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4291b:	eb 01                	jmp    4291e <keyboard_readc+0x212>
        if (modifiers & MOD_CONTROL) {
   4291d:	90                   	nop
    }

    return ch;
   4291e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42921:	c9                   	leaveq 
   42922:	c3                   	retq   

0000000000042923 <delay>:


#define IO_SERIAL_PORT_DATA     0x3f8
#define IO_SERIAL_PORT_STATUS   0x3f9

static void delay(void) {
   42923:	55                   	push   %rbp
   42924:	48 89 e5             	mov    %rsp,%rbp
   42927:	48 83 ec 20          	sub    $0x20,%rsp
   4292b:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42932:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42935:	89 c2                	mov    %eax,%edx
   42937:	ec                   	in     (%dx),%al
   42938:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4293b:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42942:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42945:	89 c2                	mov    %eax,%edx
   42947:	ec                   	in     (%dx),%al
   42948:	88 45 eb             	mov    %al,-0x15(%rbp)
   4294b:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42952:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42955:	89 c2                	mov    %eax,%edx
   42957:	ec                   	in     (%dx),%al
   42958:	88 45 f3             	mov    %al,-0xd(%rbp)
   4295b:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42962:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42965:	89 c2                	mov    %eax,%edx
   42967:	ec                   	in     (%dx),%al
   42968:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4296b:	90                   	nop
   4296c:	c9                   	leaveq 
   4296d:	c3                   	retq   

000000000004296e <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4296e:	55                   	push   %rbp
   4296f:	48 89 e5             	mov    %rsp,%rbp
   42972:	48 83 ec 40          	sub    $0x40,%rsp
   42976:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4297a:	89 f0                	mov    %esi,%eax
   4297c:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4297f:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42982:	8b 05 7c 76 01 00    	mov    0x1767c(%rip),%eax        # 5a004 <initialized.1689>
   42988:	85 c0                	test   %eax,%eax
   4298a:	75 1e                	jne    429aa <parallel_port_putc+0x3c>
   4298c:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42993:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42997:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4299b:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4299e:	ee                   	out    %al,(%dx)
}
   4299f:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   429a0:	c7 05 5a 76 01 00 01 	movl   $0x1,0x1765a(%rip)        # 5a004 <initialized.1689>
   429a7:	00 00 00 
    }

    for (int i = 0;
   429aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   429b1:	eb 09                	jmp    429bc <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   429b3:	e8 6b ff ff ff       	callq  42923 <delay>
         ++i) {
   429b8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    for (int i = 0;
   429bc:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   429c3:	7f 18                	jg     429dd <parallel_port_putc+0x6f>
   429c5:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   429cc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   429cf:	89 c2                	mov    %eax,%edx
   429d1:	ec                   	in     (%dx),%al
   429d2:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   429d5:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   429d9:	84 c0                	test   %al,%al
   429db:	79 d6                	jns    429b3 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   429dd:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   429e1:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   429e8:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429eb:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   429ef:	8b 55 d8             	mov    -0x28(%rbp),%edx
   429f2:	ee                   	out    %al,(%dx)
}
   429f3:	90                   	nop
   429f4:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   429fb:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429ff:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42a03:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42a06:	ee                   	out    %al,(%dx)
}
   42a07:	90                   	nop
   42a08:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42a0f:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a13:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42a17:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42a1a:	ee                   	out    %al,(%dx)
}
   42a1b:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42a1c:	90                   	nop
   42a1d:	c9                   	leaveq 
   42a1e:	c3                   	retq   

0000000000042a1f <scan_port>:
#define INIT 0
#define CHAR 1
#define END  2

// Very flimsy serial input
int scan_port(char * c){
   42a1f:	55                   	push   %rbp
   42a20:	48 89 e5             	mov    %rsp,%rbp
   42a23:	48 83 ec 18          	sub    $0x18,%rsp
   42a27:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42a2b:	c7 45 fc f8 03 00 00 	movl   $0x3f8,-0x4(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42a32:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42a35:	89 c2                	mov    %eax,%edx
   42a37:	ec                   	in     (%dx),%al
   42a38:	88 45 fb             	mov    %al,-0x5(%rbp)
    return data;
   42a3b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
    static int status = INIT;
    *c = inb(IO_SERIAL_PORT_DATA);
   42a3f:	89 c2                	mov    %eax,%edx
   42a41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a45:	88 10                	mov    %dl,(%rax)
    if(status == INIT && *c){
   42a47:	8b 05 bb 75 01 00    	mov    0x175bb(%rip),%eax        # 5a008 <status.1697>
   42a4d:	85 c0                	test   %eax,%eax
   42a4f:	75 15                	jne    42a66 <scan_port+0x47>
   42a51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a55:	0f b6 00             	movzbl (%rax),%eax
   42a58:	84 c0                	test   %al,%al
   42a5a:	74 0a                	je     42a66 <scan_port+0x47>
        status = CHAR;
   42a5c:	c7 05 a2 75 01 00 01 	movl   $0x1,0x175a2(%rip)        # 5a008 <status.1697>
   42a63:	00 00 00 
    }
    if(status == INIT)
   42a66:	8b 05 9c 75 01 00    	mov    0x1759c(%rip),%eax        # 5a008 <status.1697>
   42a6c:	85 c0                	test   %eax,%eax
   42a6e:	75 07                	jne    42a77 <scan_port+0x58>
        return 0;
   42a70:	b8 00 00 00 00       	mov    $0x0,%eax
   42a75:	eb 33                	jmp    42aaa <scan_port+0x8b>
    if(status == CHAR){
   42a77:	8b 05 8b 75 01 00    	mov    0x1758b(%rip),%eax        # 5a008 <status.1697>
   42a7d:	83 f8 01             	cmp    $0x1,%eax
   42a80:	75 23                	jne    42aa5 <scan_port+0x86>
        if(*c == '\0'){
   42a82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a86:	0f b6 00             	movzbl (%rax),%eax
   42a89:	84 c0                	test   %al,%al
   42a8b:	75 11                	jne    42a9e <scan_port+0x7f>
            status = END;
   42a8d:	c7 05 71 75 01 00 02 	movl   $0x2,0x17571(%rip)        # 5a008 <status.1697>
   42a94:	00 00 00 
            return -1;
   42a97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a9c:	eb 0c                	jmp    42aaa <scan_port+0x8b>
        }
        return 1;
   42a9e:	b8 01 00 00 00       	mov    $0x1,%eax
   42aa3:	eb 05                	jmp    42aaa <scan_port+0x8b>
    }
    return -1;
   42aa5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42aaa:	c9                   	leaveq 
   42aab:	c3                   	retq   

0000000000042aac <log_vprintf>:


void log_vprintf(const char* format, va_list val) {
   42aac:	55                   	push   %rbp
   42aad:	48 89 e5             	mov    %rsp,%rbp
   42ab0:	48 83 ec 20          	sub    $0x20,%rsp
   42ab4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42ab8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42abc:	48 c7 45 f8 6e 29 04 	movq   $0x4296e,-0x8(%rbp)
   42ac3:	00 
    printer_vprintf(&p, 0, format, val);
   42ac4:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42ac8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42acc:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42ad0:	be 00 00 00 00       	mov    $0x0,%esi
   42ad5:	48 89 c7             	mov    %rax,%rdi
   42ad8:	e8 58 09 00 00       	callq  43435 <printer_vprintf>
}
   42add:	90                   	nop
   42ade:	c9                   	leaveq 
   42adf:	c3                   	retq   

0000000000042ae0 <log_printf>:

void log_printf(const char* format, ...) {
   42ae0:	55                   	push   %rbp
   42ae1:	48 89 e5             	mov    %rsp,%rbp
   42ae4:	48 83 ec 60          	sub    $0x60,%rsp
   42ae8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42aec:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42af0:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42af4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42af8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42afc:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42b00:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42b07:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b0b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42b0f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b13:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42b17:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42b1b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42b1f:	48 89 d6             	mov    %rdx,%rsi
   42b22:	48 89 c7             	mov    %rax,%rdi
   42b25:	e8 82 ff ff ff       	callq  42aac <log_vprintf>
    va_end(val);
}
   42b2a:	90                   	nop
   42b2b:	c9                   	leaveq 
   42b2c:	c3                   	retq   

0000000000042b2d <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42b2d:	55                   	push   %rbp
   42b2e:	48 89 e5             	mov    %rsp,%rbp
   42b31:	48 83 ec 40          	sub    $0x40,%rsp
   42b35:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42b38:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42b3b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42b3f:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42b43:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42b47:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42b4b:	48 8b 0a             	mov    (%rdx),%rcx
   42b4e:	48 89 08             	mov    %rcx,(%rax)
   42b51:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42b55:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42b59:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42b5d:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42b61:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42b65:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b69:	48 89 d6             	mov    %rdx,%rsi
   42b6c:	48 89 c7             	mov    %rax,%rdi
   42b6f:	e8 38 ff ff ff       	callq  42aac <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42b74:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42b78:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42b7c:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42b7f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b82:	89 c7                	mov    %eax,%edi
   42b84:	e8 95 0f 00 00       	callq  43b1e <console_vprintf>
}
   42b89:	c9                   	leaveq 
   42b8a:	c3                   	retq   

0000000000042b8b <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42b8b:	55                   	push   %rbp
   42b8c:	48 89 e5             	mov    %rsp,%rbp
   42b8f:	48 83 ec 60          	sub    $0x60,%rsp
   42b93:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42b96:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42b99:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42b9d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42ba1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42ba5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42ba9:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42bb0:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42bb4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42bb8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42bbc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42bc0:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42bc4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42bc8:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42bcb:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bce:	89 c7                	mov    %eax,%edi
   42bd0:	e8 58 ff ff ff       	callq  42b2d <error_vprintf>
   42bd5:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42bd8:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42bdb:	c9                   	leaveq 
   42bdc:	c3                   	retq   

0000000000042bdd <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42bdd:	55                   	push   %rbp
   42bde:	48 89 e5             	mov    %rsp,%rbp
   42be1:	53                   	push   %rbx
   42be2:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42be6:	e8 21 fb ff ff       	callq  4270c <keyboard_readc>
   42beb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't') {
   42bee:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42bf2:	74 16                	je     42c0a <check_keyboard+0x2d>
   42bf4:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42bf8:	74 10                	je     42c0a <check_keyboard+0x2d>
   42bfa:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42bfe:	74 0a                	je     42c0a <check_keyboard+0x2d>
   42c00:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42c04:	0f 85 d9 00 00 00    	jne    42ce3 <check_keyboard+0x106>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42c0a:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42c11:	00 
        memset(pt, 0, PAGESIZE * 3);
   42c12:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c16:	ba 00 30 00 00       	mov    $0x3000,%edx
   42c1b:	be 00 00 00 00       	mov    $0x0,%esi
   42c20:	48 89 c7             	mov    %rax,%rdi
   42c23:	e8 fd 06 00 00       	callq  43325 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42c28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c2c:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42c33:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c37:	48 05 00 10 00 00    	add    $0x1000,%rax
   42c3d:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42c44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c48:	48 05 00 20 00 00    	add    $0x2000,%rax
   42c4e:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42c55:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c59:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c5d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c61:	0f 22 d8             	mov    %rax,%cr3
}
   42c64:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42c65:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42c6c:	48 c7 45 e8 78 50 04 	movq   $0x45078,-0x18(%rbp)
   42c73:	00 
        if (c == 'a') {
   42c74:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42c78:	75 0a                	jne    42c84 <check_keyboard+0xa7>
            argument = "allocator";
   42c7a:	48 c7 45 e8 7f 50 04 	movq   $0x4507f,-0x18(%rbp)
   42c81:	00 
   42c82:	eb 1e                	jmp    42ca2 <check_keyboard+0xc5>
        } else if (c == 'c') {
   42c84:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42c88:	75 0a                	jne    42c94 <check_keyboard+0xb7>
            argument = "alloctests";
   42c8a:	48 c7 45 e8 89 50 04 	movq   $0x45089,-0x18(%rbp)
   42c91:	00 
   42c92:	eb 0e                	jmp    42ca2 <check_keyboard+0xc5>
        } else if(c == 't'){
   42c94:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42c98:	75 08                	jne    42ca2 <check_keyboard+0xc5>
            argument = "test";
   42c9a:	48 c7 45 e8 94 50 04 	movq   $0x45094,-0x18(%rbp)
   42ca1:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42ca2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ca6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42caa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42caf:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42cb3:	76 14                	jbe    42cc9 <check_keyboard+0xec>
   42cb5:	ba 99 50 04 00       	mov    $0x45099,%edx
   42cba:	be 11 03 00 00       	mov    $0x311,%esi
   42cbf:	bf 15 4c 04 00       	mov    $0x44c15,%edi
   42cc4:	e8 20 01 00 00       	callq  42de9 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42cc9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ccd:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42cd0:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42cd4:	48 89 c3             	mov    %rax,%rbx
   42cd7:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42cdc:	e9 1f d3 ff ff       	jmpq   40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't') {
   42ce1:	eb 11                	jmp    42cf4 <check_keyboard+0x117>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42ce3:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42ce7:	74 06                	je     42cef <check_keyboard+0x112>
   42ce9:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42ced:	75 05                	jne    42cf4 <check_keyboard+0x117>
        poweroff();
   42cef:	e8 2e f8 ff ff       	callq  42522 <poweroff>
    }
    return c;
   42cf4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42cf7:	48 83 c4 48          	add    $0x48,%rsp
   42cfb:	5b                   	pop    %rbx
   42cfc:	5d                   	pop    %rbp
   42cfd:	c3                   	retq   

0000000000042cfe <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42cfe:	55                   	push   %rbp
   42cff:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42d02:	e8 d6 fe ff ff       	callq  42bdd <check_keyboard>
   42d07:	eb f9                	jmp    42d02 <fail+0x4>

0000000000042d09 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42d09:	55                   	push   %rbp
   42d0a:	48 89 e5             	mov    %rsp,%rbp
   42d0d:	48 83 ec 60          	sub    $0x60,%rsp
   42d11:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42d15:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42d19:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42d1d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42d21:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42d25:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42d29:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42d30:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42d34:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42d38:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42d3c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42d40:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42d45:	0f 84 80 00 00 00    	je     42dcb <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42d4b:	ba b5 50 04 00       	mov    $0x450b5,%edx
   42d50:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d55:	bf 30 07 00 00       	mov    $0x730,%edi
   42d5a:	b8 00 00 00 00       	mov    $0x0,%eax
   42d5f:	e8 27 fe ff ff       	callq  42b8b <error_printf>
   42d64:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42d67:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42d6b:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42d6f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d72:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d77:	89 c7                	mov    %eax,%edi
   42d79:	e8 af fd ff ff       	callq  42b2d <error_vprintf>
   42d7e:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42d81:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42d84:	48 63 c1             	movslq %ecx,%rax
   42d87:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42d8e:	48 c1 e8 20          	shr    $0x20,%rax
   42d92:	89 c2                	mov    %eax,%edx
   42d94:	c1 fa 05             	sar    $0x5,%edx
   42d97:	89 c8                	mov    %ecx,%eax
   42d99:	c1 f8 1f             	sar    $0x1f,%eax
   42d9c:	29 c2                	sub    %eax,%edx
   42d9e:	89 d0                	mov    %edx,%eax
   42da0:	c1 e0 02             	shl    $0x2,%eax
   42da3:	01 d0                	add    %edx,%eax
   42da5:	c1 e0 04             	shl    $0x4,%eax
   42da8:	29 c1                	sub    %eax,%ecx
   42daa:	89 ca                	mov    %ecx,%edx
   42dac:	85 d2                	test   %edx,%edx
   42dae:	74 34                	je     42de4 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42db0:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42db3:	ba bd 50 04 00       	mov    $0x450bd,%edx
   42db8:	be 00 c0 00 00       	mov    $0xc000,%esi
   42dbd:	89 c7                	mov    %eax,%edi
   42dbf:	b8 00 00 00 00       	mov    $0x0,%eax
   42dc4:	e8 c2 fd ff ff       	callq  42b8b <error_printf>
   42dc9:	eb 19                	jmp    42de4 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42dcb:	ba bf 50 04 00       	mov    $0x450bf,%edx
   42dd0:	be 00 c0 00 00       	mov    $0xc000,%esi
   42dd5:	bf 30 07 00 00       	mov    $0x730,%edi
   42dda:	b8 00 00 00 00       	mov    $0x0,%eax
   42ddf:	e8 a7 fd ff ff       	callq  42b8b <error_printf>
    }

    va_end(val);
    fail();
   42de4:	e8 15 ff ff ff       	callq  42cfe <fail>

0000000000042de9 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42de9:	55                   	push   %rbp
   42dea:	48 89 e5             	mov    %rsp,%rbp
   42ded:	48 83 ec 20          	sub    $0x20,%rsp
   42df1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42df5:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42df8:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42dfc:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42e00:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42e03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e07:	48 89 c6             	mov    %rax,%rsi
   42e0a:	bf c5 50 04 00       	mov    $0x450c5,%edi
   42e0f:	b8 00 00 00 00       	mov    $0x0,%eax
   42e14:	e8 f0 fe ff ff       	callq  42d09 <panic>

0000000000042e19 <default_exception>:
}

void default_exception(proc* p){
   42e19:	55                   	push   %rbp
   42e1a:	48 89 e5             	mov    %rsp,%rbp
   42e1d:	48 83 ec 20          	sub    $0x20,%rsp
   42e21:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42e25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e29:	48 83 c0 18          	add    $0x18,%rax
   42e2d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42e31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e35:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42e3c:	48 89 c6             	mov    %rax,%rsi
   42e3f:	bf e3 50 04 00       	mov    $0x450e3,%edi
   42e44:	b8 00 00 00 00       	mov    $0x0,%eax
   42e49:	e8 bb fe ff ff       	callq  42d09 <panic>

0000000000042e4e <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42e4e:	55                   	push   %rbp
   42e4f:	48 89 e5             	mov    %rsp,%rbp
   42e52:	48 83 ec 40          	sub    $0x40,%rsp
   42e56:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42e5a:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42e5d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42e61:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42e68:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42e6c:	78 08                	js     42e76 <program_load+0x28>
   42e6e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42e71:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42e74:	7c 14                	jl     42e8a <program_load+0x3c>
   42e76:	ba 00 51 04 00       	mov    $0x45100,%edx
   42e7b:	be 3a 00 00 00       	mov    $0x3a,%esi
   42e80:	bf 30 51 04 00       	mov    $0x45130,%edi
   42e85:	e8 5f ff ff ff       	callq  42de9 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42e8a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42e8d:	48 98                	cltq   
   42e8f:	48 c1 e0 04          	shl    $0x4,%rax
   42e93:	48 05 20 60 04 00    	add    $0x46020,%rax
   42e99:	48 8b 00             	mov    (%rax),%rax
   42e9c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42ea0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ea4:	8b 00                	mov    (%rax),%eax
   42ea6:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42eab:	74 14                	je     42ec1 <program_load+0x73>
   42ead:	ba 3b 51 04 00       	mov    $0x4513b,%edx
   42eb2:	be 3c 00 00 00       	mov    $0x3c,%esi
   42eb7:	bf 30 51 04 00       	mov    $0x45130,%edi
   42ebc:	e8 28 ff ff ff       	callq  42de9 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42ec1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ec5:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42ec9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ecd:	48 01 d0             	add    %rdx,%rax
   42ed0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42ed4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42edb:	e9 b5 00 00 00       	jmpq   42f95 <program_load+0x147>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42ee0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42ee3:	48 63 d0             	movslq %eax,%rdx
   42ee6:	48 89 d0             	mov    %rdx,%rax
   42ee9:	48 c1 e0 03          	shl    $0x3,%rax
   42eed:	48 29 d0             	sub    %rdx,%rax
   42ef0:	48 c1 e0 03          	shl    $0x3,%rax
   42ef4:	48 89 c2             	mov    %rax,%rdx
   42ef7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42efb:	48 01 d0             	add    %rdx,%rax
   42efe:	8b 00                	mov    (%rax),%eax
   42f00:	83 f8 01             	cmp    $0x1,%eax
   42f03:	0f 85 88 00 00 00    	jne    42f91 <program_load+0x143>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42f09:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f0c:	48 63 d0             	movslq %eax,%rdx
   42f0f:	48 89 d0             	mov    %rdx,%rax
   42f12:	48 c1 e0 03          	shl    $0x3,%rax
   42f16:	48 29 d0             	sub    %rdx,%rax
   42f19:	48 c1 e0 03          	shl    $0x3,%rax
   42f1d:	48 89 c2             	mov    %rax,%rdx
   42f20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f24:	48 01 d0             	add    %rdx,%rax
   42f27:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42f2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f2f:	48 01 d0             	add    %rdx,%rax
   42f32:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            if (i == eh->e_phnum-1)
   42f36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f3a:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42f3e:	0f b7 c0             	movzwl %ax,%eax
   42f41:	83 e8 01             	sub    $0x1,%eax
   42f44:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42f47:	75 0a                	jne    42f53 <program_load+0x105>
            {
                new_brk = 1;
   42f49:	c7 05 b9 70 01 00 01 	movl   $0x1,0x170b9(%rip)        # 5a00c <new_brk>
   42f50:	00 00 00 
            }

            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42f53:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f56:	48 63 d0             	movslq %eax,%rdx
   42f59:	48 89 d0             	mov    %rdx,%rax
   42f5c:	48 c1 e0 03          	shl    $0x3,%rax
   42f60:	48 29 d0             	sub    %rdx,%rax
   42f63:	48 c1 e0 03          	shl    $0x3,%rax
   42f67:	48 89 c2             	mov    %rax,%rdx
   42f6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f6e:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42f72:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42f76:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f7a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f7e:	48 89 c7             	mov    %rax,%rdi
   42f81:	e8 3d 00 00 00       	callq  42fc3 <program_load_segment>
   42f86:	85 c0                	test   %eax,%eax
   42f88:	79 07                	jns    42f91 <program_load+0x143>
                return -1;
   42f8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f8f:	eb 30                	jmp    42fc1 <program_load+0x173>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f91:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42f95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f99:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42f9d:	0f b7 c0             	movzwl %ax,%eax
   42fa0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42fa3:	0f 8c 37 ff ff ff    	jl     42ee0 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42fa9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fad:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42fb1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fb5:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42fbc:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42fc1:	c9                   	leaveq 
   42fc2:	c3                   	retq   

0000000000042fc3 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42fc3:	55                   	push   %rbp
   42fc4:	48 89 e5             	mov    %rsp,%rbp
   42fc7:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
   42fce:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
   42fd2:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
   42fd6:	48 89 95 78 ff ff ff 	mov    %rdx,-0x88(%rbp)
   42fdd:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42fe4:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42fe8:	48 8b 40 10          	mov    0x10(%rax),%rax
   42fec:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42ff0:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42ff4:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42ff8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ffc:	48 01 d0             	add    %rdx,%rax
   42fff:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43003:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43007:	48 8b 50 28          	mov    0x28(%rax),%rdx
   4300b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4300f:	48 01 d0             	add    %rdx,%rax
   43012:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43016:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   4301d:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4301e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43022:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43026:	e9 86 00 00 00       	jmpq   430b1 <program_load_segment+0xee>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   4302b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4302f:	8b 00                	mov    (%rax),%eax
   43031:	89 c7                	mov    %eax,%edi
   43033:	e8 05 0c 00 00       	callq  43c3d <palloc>
   43038:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   4303c:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43041:	74 34                	je     43077 <program_load_segment+0xb4>
   43043:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43047:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4304e:	48 8b 8d 70 ff ff ff 	mov    -0x90(%rbp),%rcx
   43055:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   43059:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4305d:	49 89 c9             	mov    %rcx,%r9
   43060:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43066:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4306b:	48 89 c7             	mov    %rax,%rdi
   4306e:	e8 54 ed ff ff       	callq  41dc7 <virtual_memory_map>
   43073:	85 c0                	test   %eax,%eax
   43075:	79 32                	jns    430a9 <program_load_segment+0xe6>
                                            PTE_W | PTE_P | PTE_U, allocator) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   43077:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4307b:	8b 00                	mov    (%rax),%eax
   4307d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43081:	49 89 d0             	mov    %rdx,%r8
   43084:	89 c1                	mov    %eax,%ecx
   43086:	ba 58 51 04 00       	mov    $0x45158,%edx
   4308b:	be 00 c0 00 00       	mov    $0xc000,%esi
   43090:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43095:	b8 00 00 00 00       	mov    $0x0,%eax
   4309a:	e8 c4 0a 00 00       	callq  43b63 <console_printf>
                "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   4309f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   430a4:	e9 71 01 00 00       	jmpq   4321a <program_load_segment+0x257>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430a9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430b0:	00 
   430b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430b5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   430b9:	0f 82 6c ff ff ff    	jb     4302b <program_load_segment+0x68>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   430bf:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430c3:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430ca:	48 89 c7             	mov    %rax,%rdi
   430cd:	e8 e3 f1 ff ff       	callq  422b5 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   430d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430d6:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   430da:	48 89 c2             	mov    %rax,%rdx
   430dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430e1:	48 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%rcx
   430e8:	48 89 ce             	mov    %rcx,%rsi
   430eb:	48 89 c7             	mov    %rax,%rdi
   430ee:	e8 c9 01 00 00       	callq  432bc <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   430f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   430f7:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   430fb:	48 89 c2             	mov    %rax,%rdx
   430fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43102:	be 00 00 00 00       	mov    $0x0,%esi
   43107:	48 89 c7             	mov    %rax,%rdi
   4310a:	e8 16 02 00 00       	callq  43325 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4310f:	48 8b 05 2a 82 01 00 	mov    0x1822a(%rip),%rax        # 5b340 <kernel_pagetable>
   43116:	48 89 c7             	mov    %rax,%rdi
   43119:	e8 97 f1 ff ff       	callq  422b5 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4311e:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43122:	8b 40 04             	mov    0x4(%rax),%eax
   43125:	83 e0 02             	and    $0x2,%eax
   43128:	85 c0                	test   %eax,%eax
   4312a:	75 6a                	jne    43196 <program_load_segment+0x1d3>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4312c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43130:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43134:	eb 56                	jmp    4318c <program_load_segment+0x1c9>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43136:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4313a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43141:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43145:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43149:	48 89 ce             	mov    %rcx,%rsi
   4314c:	48 89 c7             	mov    %rax,%rdi
   4314f:	e8 6a f0 ff ff       	callq  421be <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43154:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43158:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4315c:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43163:	48 8b 8d 70 ff ff ff 	mov    -0x90(%rbp),%rcx
   4316a:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4316e:	49 89 c9             	mov    %rcx,%r9
   43171:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43177:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4317c:	48 89 c7             	mov    %rax,%rdi
   4317f:	e8 43 ec ff ff       	callq  41dc7 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43184:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   4318b:	00 
   4318c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43190:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43194:	72 a0                	jb     43136 <program_load_segment+0x173>
                                        PTE_P | PTE_U, allocator);
        }
    }

    if (new_brk == 1)
   43196:	8b 05 70 6e 01 00    	mov    0x16e70(%rip),%eax        # 5a00c <new_brk>
   4319c:	83 f8 01             	cmp    $0x1,%eax
   4319f:	75 74                	jne    43215 <program_load_segment+0x252>
    {
        p->program_break = (uintptr_t) ROUNDUP((uint8_t*) end_mem, PAGESIZE);
   431a1:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   431a8:	00 
   431a9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   431ad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431b1:	48 01 d0             	add    %rdx,%rax
   431b4:	48 83 e8 01          	sub    $0x1,%rax
   431b8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   431bc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431c0:	ba 00 00 00 00       	mov    $0x0,%edx
   431c5:	48 f7 75 d0          	divq   -0x30(%rbp)
   431c9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431cd:	48 29 d0             	sub    %rdx,%rax
   431d0:	48 89 c2             	mov    %rax,%rdx
   431d3:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431d7:	48 89 50 08          	mov    %rdx,0x8(%rax)
        p->original_break = (uintptr_t) ROUNDUP((uint8_t*) end_mem, PAGESIZE);
   431db:	48 c7 45 c0 00 10 00 	movq   $0x1000,-0x40(%rbp)
   431e2:	00 
   431e3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   431e7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   431eb:	48 01 d0             	add    %rdx,%rax
   431ee:	48 83 e8 01          	sub    $0x1,%rax
   431f2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   431f6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   431fa:	ba 00 00 00 00       	mov    $0x0,%edx
   431ff:	48 f7 75 c0          	divq   -0x40(%rbp)
   43203:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43207:	48 29 d0             	sub    %rdx,%rax
   4320a:	48 89 c2             	mov    %rax,%rdx
   4320d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43211:	48 89 50 10          	mov    %rdx,0x10(%rax)
    }

    return 0;
   43215:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4321a:	c9                   	leaveq 
   4321b:	c3                   	retq   

000000000004321c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4321c:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4321f:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
   43226:	00 
   43227:	72 08                	jb     43231 <console_putc+0x15>
        cp->cursor = console;
   43229:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
   43230:	00 
    }
    if (c == '\n') {
   43231:	40 80 fe 0a          	cmp    $0xa,%sil
   43235:	74 17                	je     4324e <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   43237:	48 8b 47 08          	mov    0x8(%rdi),%rax
   4323b:	48 8d 50 02          	lea    0x2(%rax),%rdx
   4323f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   43243:	40 0f b6 f6          	movzbl %sil,%esi
   43247:	44 09 c6             	or     %r8d,%esi
   4324a:	66 89 30             	mov    %si,(%rax)
    }
}
   4324d:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
   4324e:	48 8b 77 08          	mov    0x8(%rdi),%rsi
   43252:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
   43259:	48 89 f1             	mov    %rsi,%rcx
   4325c:	48 d1 f9             	sar    %rcx
   4325f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43266:	66 66 66 
   43269:	48 89 c8             	mov    %rcx,%rax
   4326c:	48 f7 ea             	imul   %rdx
   4326f:	48 c1 fa 05          	sar    $0x5,%rdx
   43273:	48 c1 fe 3f          	sar    $0x3f,%rsi
   43277:	48 29 f2             	sub    %rsi,%rdx
   4327a:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   4327e:	48 c1 e0 04          	shl    $0x4,%rax
   43282:	89 ca                	mov    %ecx,%edx
   43284:	29 c2                	sub    %eax,%edx
   43286:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
   43288:	44 89 c6             	mov    %r8d,%esi
   4328b:	83 ce 20             	or     $0x20,%esi
   4328e:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
   43292:	4c 8d 41 02          	lea    0x2(%rcx),%r8
   43296:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   4329a:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
   4329d:	83 c0 01             	add    $0x1,%eax
   432a0:	83 f8 50             	cmp    $0x50,%eax
   432a3:	75 e9                	jne    4328e <console_putc+0x72>
   432a5:	c3                   	retq   

00000000000432a6 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   432a6:	48 8b 47 08          	mov    0x8(%rdi),%rax
   432aa:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   432ae:	73 0b                	jae    432bb <string_putc+0x15>
        *sp->s++ = c;
   432b0:	48 8d 50 01          	lea    0x1(%rax),%rdx
   432b4:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   432b8:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   432bb:	c3                   	retq   

00000000000432bc <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   432bc:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   432bf:	48 85 d2             	test   %rdx,%rdx
   432c2:	74 17                	je     432db <memcpy+0x1f>
   432c4:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   432c9:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   432ce:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   432d2:	48 83 c1 01          	add    $0x1,%rcx
   432d6:	48 39 d1             	cmp    %rdx,%rcx
   432d9:	75 ee                	jne    432c9 <memcpy+0xd>
}
   432db:	c3                   	retq   

00000000000432dc <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   432dc:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   432df:	48 39 fe             	cmp    %rdi,%rsi
   432e2:	72 1d                	jb     43301 <memmove+0x25>
        while (n-- > 0) {
   432e4:	b9 00 00 00 00       	mov    $0x0,%ecx
   432e9:	48 85 d2             	test   %rdx,%rdx
   432ec:	74 12                	je     43300 <memmove+0x24>
            *d++ = *s++;
   432ee:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   432f2:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   432f6:	48 83 c1 01          	add    $0x1,%rcx
   432fa:	48 39 ca             	cmp    %rcx,%rdx
   432fd:	75 ef                	jne    432ee <memmove+0x12>
}
   432ff:	c3                   	retq   
   43300:	c3                   	retq   
    if (s < d && s + n > d) {
   43301:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   43305:	48 39 cf             	cmp    %rcx,%rdi
   43308:	73 da                	jae    432e4 <memmove+0x8>
        while (n-- > 0) {
   4330a:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   4330e:	48 85 d2             	test   %rdx,%rdx
   43311:	74 ec                	je     432ff <memmove+0x23>
            *--d = *--s;
   43313:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   43317:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   4331a:	48 83 e9 01          	sub    $0x1,%rcx
   4331e:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   43322:	75 ef                	jne    43313 <memmove+0x37>
   43324:	c3                   	retq   

0000000000043325 <memset>:
void* memset(void* v, int c, size_t n) {
   43325:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43328:	48 85 d2             	test   %rdx,%rdx
   4332b:	74 13                	je     43340 <memset+0x1b>
   4332d:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
   43331:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
   43334:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43337:	48 83 c2 01          	add    $0x1,%rdx
   4333b:	48 39 d1             	cmp    %rdx,%rcx
   4333e:	75 f4                	jne    43334 <memset+0xf>
}
   43340:	c3                   	retq   

0000000000043341 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   43341:	80 3f 00             	cmpb   $0x0,(%rdi)
   43344:	74 10                	je     43356 <strlen+0x15>
   43346:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   4334b:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   4334f:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   43353:	75 f6                	jne    4334b <strlen+0xa>
   43355:	c3                   	retq   
   43356:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4335b:	c3                   	retq   

000000000004335c <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4335c:	b8 00 00 00 00       	mov    $0x0,%eax
   43361:	48 85 f6             	test   %rsi,%rsi
   43364:	74 10                	je     43376 <strnlen+0x1a>
   43366:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   4336a:	74 09                	je     43375 <strnlen+0x19>
        ++n;
   4336c:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43370:	48 39 c6             	cmp    %rax,%rsi
   43373:	75 f1                	jne    43366 <strnlen+0xa>
}
   43375:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43376:	48 89 f0             	mov    %rsi,%rax
   43379:	c3                   	retq   

000000000004337a <strcpy>:
char* strcpy(char* dst, const char* src) {
   4337a:	48 89 f8             	mov    %rdi,%rax
   4337d:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   43382:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   43386:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   43389:	48 83 c2 01          	add    $0x1,%rdx
   4338d:	84 c9                	test   %cl,%cl
   4338f:	75 f1                	jne    43382 <strcpy+0x8>
}
   43391:	c3                   	retq   

0000000000043392 <strcmp>:
    while (*a && *b && *a == *b) {
   43392:	0f b6 17             	movzbl (%rdi),%edx
   43395:	84 d2                	test   %dl,%dl
   43397:	74 1a                	je     433b3 <strcmp+0x21>
   43399:	0f b6 06             	movzbl (%rsi),%eax
   4339c:	38 d0                	cmp    %dl,%al
   4339e:	75 13                	jne    433b3 <strcmp+0x21>
   433a0:	84 c0                	test   %al,%al
   433a2:	74 0f                	je     433b3 <strcmp+0x21>
        ++a, ++b;
   433a4:	48 83 c7 01          	add    $0x1,%rdi
   433a8:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   433ac:	0f b6 17             	movzbl (%rdi),%edx
   433af:	84 d2                	test   %dl,%dl
   433b1:	75 e6                	jne    43399 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   433b3:	0f b6 0e             	movzbl (%rsi),%ecx
   433b6:	38 ca                	cmp    %cl,%dl
   433b8:	0f 97 c0             	seta   %al
   433bb:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   433be:	83 d8 00             	sbb    $0x0,%eax
}
   433c1:	c3                   	retq   

00000000000433c2 <strchr>:
    while (*s && *s != (char) c) {
   433c2:	0f b6 07             	movzbl (%rdi),%eax
   433c5:	84 c0                	test   %al,%al
   433c7:	74 10                	je     433d9 <strchr+0x17>
   433c9:	40 38 f0             	cmp    %sil,%al
   433cc:	74 18                	je     433e6 <strchr+0x24>
        ++s;
   433ce:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   433d2:	0f b6 07             	movzbl (%rdi),%eax
   433d5:	84 c0                	test   %al,%al
   433d7:	75 f0                	jne    433c9 <strchr+0x7>
        return NULL;
   433d9:	40 84 f6             	test   %sil,%sil
   433dc:	b8 00 00 00 00       	mov    $0x0,%eax
   433e1:	48 0f 44 c7          	cmove  %rdi,%rax
}
   433e5:	c3                   	retq   
   433e6:	48 89 f8             	mov    %rdi,%rax
   433e9:	c3                   	retq   

00000000000433ea <rand>:
    if (!rand_seed_set) {
   433ea:	83 3d 23 6c 01 00 00 	cmpl   $0x0,0x16c23(%rip)        # 5a014 <rand_seed_set>
   433f1:	74 1b                	je     4340e <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   433f3:	69 05 13 6c 01 00 0d 	imul   $0x19660d,0x16c13(%rip),%eax        # 5a010 <rand_seed>
   433fa:	66 19 00 
   433fd:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43402:	89 05 08 6c 01 00    	mov    %eax,0x16c08(%rip)        # 5a010 <rand_seed>
    return rand_seed & RAND_MAX;
   43408:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4340d:	c3                   	retq   
    rand_seed = seed;
   4340e:	c7 05 f8 6b 01 00 9e 	movl   $0x30d4879e,0x16bf8(%rip)        # 5a010 <rand_seed>
   43415:	87 d4 30 
    rand_seed_set = 1;
   43418:	c7 05 f2 6b 01 00 01 	movl   $0x1,0x16bf2(%rip)        # 5a014 <rand_seed_set>
   4341f:	00 00 00 
}
   43422:	eb cf                	jmp    433f3 <rand+0x9>

0000000000043424 <srand>:
    rand_seed = seed;
   43424:	89 3d e6 6b 01 00    	mov    %edi,0x16be6(%rip)        # 5a010 <rand_seed>
    rand_seed_set = 1;
   4342a:	c7 05 e0 6b 01 00 01 	movl   $0x1,0x16be0(%rip)        # 5a014 <rand_seed_set>
   43431:	00 00 00 
}
   43434:	c3                   	retq   

0000000000043435 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43435:	55                   	push   %rbp
   43436:	48 89 e5             	mov    %rsp,%rbp
   43439:	41 57                	push   %r15
   4343b:	41 56                	push   %r14
   4343d:	41 55                	push   %r13
   4343f:	41 54                	push   %r12
   43441:	53                   	push   %rbx
   43442:	48 83 ec 58          	sub    $0x58,%rsp
   43446:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   4344a:	0f b6 02             	movzbl (%rdx),%eax
   4344d:	84 c0                	test   %al,%al
   4344f:	0f 84 ba 06 00 00    	je     43b0f <printer_vprintf+0x6da>
   43455:	49 89 fe             	mov    %rdi,%r14
   43458:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   4345b:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
   43462:	41 89 f7             	mov    %esi,%r15d
   43465:	e9 a5 04 00 00       	jmpq   4390f <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
   4346a:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   4346f:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   43475:	45 84 e4             	test   %r12b,%r12b
   43478:	0f 84 85 06 00 00    	je     43b03 <printer_vprintf+0x6ce>
        int flags = 0;
   4347e:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   43484:	41 0f be f4          	movsbl %r12b,%esi
   43488:	bf 91 53 04 00       	mov    $0x45391,%edi
   4348d:	e8 30 ff ff ff       	callq  433c2 <strchr>
   43492:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   43495:	48 85 c0             	test   %rax,%rax
   43498:	74 55                	je     434ef <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
   4349a:	48 81 e9 91 53 04 00 	sub    $0x45391,%rcx
   434a1:	b8 01 00 00 00       	mov    $0x1,%eax
   434a6:	d3 e0                	shl    %cl,%eax
   434a8:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   434ab:	48 83 c3 01          	add    $0x1,%rbx
   434af:	44 0f b6 23          	movzbl (%rbx),%r12d
   434b3:	45 84 e4             	test   %r12b,%r12b
   434b6:	75 cc                	jne    43484 <printer_vprintf+0x4f>
   434b8:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   434bc:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   434c2:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   434c9:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   434cc:	0f 84 a9 00 00 00    	je     4357b <printer_vprintf+0x146>
        int length = 0;
   434d2:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   434d7:	0f b6 13             	movzbl (%rbx),%edx
   434da:	8d 42 bd             	lea    -0x43(%rdx),%eax
   434dd:	3c 37                	cmp    $0x37,%al
   434df:	0f 87 c5 04 00 00    	ja     439aa <printer_vprintf+0x575>
   434e5:	0f b6 c0             	movzbl %al,%eax
   434e8:	ff 24 c5 a0 51 04 00 	jmpq   *0x451a0(,%rax,8)
   434ef:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
   434f3:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   434f8:	3c 08                	cmp    $0x8,%al
   434fa:	77 2f                	ja     4352b <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   434fc:	0f b6 03             	movzbl (%rbx),%eax
   434ff:	8d 50 d0             	lea    -0x30(%rax),%edx
   43502:	80 fa 09             	cmp    $0x9,%dl
   43505:	77 5e                	ja     43565 <printer_vprintf+0x130>
   43507:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   4350d:	48 83 c3 01          	add    $0x1,%rbx
   43511:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   43516:	0f be c0             	movsbl %al,%eax
   43519:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4351e:	0f b6 03             	movzbl (%rbx),%eax
   43521:	8d 50 d0             	lea    -0x30(%rax),%edx
   43524:	80 fa 09             	cmp    $0x9,%dl
   43527:	76 e4                	jbe    4350d <printer_vprintf+0xd8>
   43529:	eb 97                	jmp    434c2 <printer_vprintf+0x8d>
        } else if (*format == '*') {
   4352b:	41 80 fc 2a          	cmp    $0x2a,%r12b
   4352f:	75 3f                	jne    43570 <printer_vprintf+0x13b>
            width = va_arg(val, int);
   43531:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43535:	8b 01                	mov    (%rcx),%eax
   43537:	83 f8 2f             	cmp    $0x2f,%eax
   4353a:	77 17                	ja     43553 <printer_vprintf+0x11e>
   4353c:	89 c2                	mov    %eax,%edx
   4353e:	48 03 51 10          	add    0x10(%rcx),%rdx
   43542:	83 c0 08             	add    $0x8,%eax
   43545:	89 01                	mov    %eax,(%rcx)
   43547:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   4354a:	48 83 c3 01          	add    $0x1,%rbx
   4354e:	e9 6f ff ff ff       	jmpq   434c2 <printer_vprintf+0x8d>
            width = va_arg(val, int);
   43553:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43557:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   4355b:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4355f:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43563:	eb e2                	jmp    43547 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43565:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   4356b:	e9 52 ff ff ff       	jmpq   434c2 <printer_vprintf+0x8d>
        int width = -1;
   43570:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   43576:	e9 47 ff ff ff       	jmpq   434c2 <printer_vprintf+0x8d>
            ++format;
   4357b:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   4357f:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43583:	8d 48 d0             	lea    -0x30(%rax),%ecx
   43586:	80 f9 09             	cmp    $0x9,%cl
   43589:	76 13                	jbe    4359e <printer_vprintf+0x169>
            } else if (*format == '*') {
   4358b:	3c 2a                	cmp    $0x2a,%al
   4358d:	74 32                	je     435c1 <printer_vprintf+0x18c>
            ++format;
   4358f:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   43592:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   43599:	e9 34 ff ff ff       	jmpq   434d2 <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4359e:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
   435a3:	48 83 c2 01          	add    $0x1,%rdx
   435a7:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
   435aa:	0f be c0             	movsbl %al,%eax
   435ad:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   435b1:	0f b6 02             	movzbl (%rdx),%eax
   435b4:	8d 48 d0             	lea    -0x30(%rax),%ecx
   435b7:	80 f9 09             	cmp    $0x9,%cl
   435ba:	76 e7                	jbe    435a3 <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
   435bc:	48 89 d3             	mov    %rdx,%rbx
   435bf:	eb 1c                	jmp    435dd <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
   435c1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435c5:	8b 07                	mov    (%rdi),%eax
   435c7:	83 f8 2f             	cmp    $0x2f,%eax
   435ca:	77 23                	ja     435ef <printer_vprintf+0x1ba>
   435cc:	89 c2                	mov    %eax,%edx
   435ce:	48 03 57 10          	add    0x10(%rdi),%rdx
   435d2:	83 c0 08             	add    $0x8,%eax
   435d5:	89 07                	mov    %eax,(%rdi)
   435d7:	8b 32                	mov    (%rdx),%esi
                ++format;
   435d9:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   435dd:	85 f6                	test   %esi,%esi
   435df:	b8 00 00 00 00       	mov    $0x0,%eax
   435e4:	0f 48 f0             	cmovs  %eax,%esi
   435e7:	89 75 9c             	mov    %esi,-0x64(%rbp)
   435ea:	e9 e3 fe ff ff       	jmpq   434d2 <printer_vprintf+0x9d>
                precision = va_arg(val, int);
   435ef:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435f3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   435f7:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435fb:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435ff:	eb d6                	jmp    435d7 <printer_vprintf+0x1a2>
        switch (*format) {
   43601:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43606:	e9 f1 00 00 00       	jmpq   436fc <printer_vprintf+0x2c7>
            ++format;
   4360b:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   4360f:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
   43612:	e9 c0 fe ff ff       	jmpq   434d7 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43617:	85 c9                	test   %ecx,%ecx
   43619:	74 55                	je     43670 <printer_vprintf+0x23b>
   4361b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4361f:	8b 01                	mov    (%rcx),%eax
   43621:	83 f8 2f             	cmp    $0x2f,%eax
   43624:	77 38                	ja     4365e <printer_vprintf+0x229>
   43626:	89 c2                	mov    %eax,%edx
   43628:	48 03 51 10          	add    0x10(%rcx),%rdx
   4362c:	83 c0 08             	add    $0x8,%eax
   4362f:	89 01                	mov    %eax,(%rcx)
   43631:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43634:	48 89 d0             	mov    %rdx,%rax
   43637:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   4363b:	49 89 d0             	mov    %rdx,%r8
   4363e:	49 f7 d8             	neg    %r8
   43641:	25 80 00 00 00       	and    $0x80,%eax
   43646:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4364a:	0b 45 a8             	or     -0x58(%rbp),%eax
   4364d:	83 c8 60             	or     $0x60,%eax
   43650:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   43653:	41 bc 93 51 04 00    	mov    $0x45193,%r12d
            break;
   43659:	e9 35 01 00 00       	jmpq   43793 <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4365e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43662:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43666:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4366a:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4366e:	eb c1                	jmp    43631 <printer_vprintf+0x1fc>
   43670:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43674:	8b 07                	mov    (%rdi),%eax
   43676:	83 f8 2f             	cmp    $0x2f,%eax
   43679:	77 10                	ja     4368b <printer_vprintf+0x256>
   4367b:	89 c2                	mov    %eax,%edx
   4367d:	48 03 57 10          	add    0x10(%rdi),%rdx
   43681:	83 c0 08             	add    $0x8,%eax
   43684:	89 07                	mov    %eax,(%rdi)
   43686:	48 63 12             	movslq (%rdx),%rdx
   43689:	eb a9                	jmp    43634 <printer_vprintf+0x1ff>
   4368b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4368f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43693:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43697:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4369b:	eb e9                	jmp    43686 <printer_vprintf+0x251>
        int base = 10;
   4369d:	be 0a 00 00 00       	mov    $0xa,%esi
   436a2:	eb 58                	jmp    436fc <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   436a4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   436a8:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   436ac:	48 8d 42 08          	lea    0x8(%rdx),%rax
   436b0:	48 89 41 08          	mov    %rax,0x8(%rcx)
   436b4:	eb 60                	jmp    43716 <printer_vprintf+0x2e1>
   436b6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   436ba:	8b 01                	mov    (%rcx),%eax
   436bc:	83 f8 2f             	cmp    $0x2f,%eax
   436bf:	77 10                	ja     436d1 <printer_vprintf+0x29c>
   436c1:	89 c2                	mov    %eax,%edx
   436c3:	48 03 51 10          	add    0x10(%rcx),%rdx
   436c7:	83 c0 08             	add    $0x8,%eax
   436ca:	89 01                	mov    %eax,(%rcx)
   436cc:	44 8b 02             	mov    (%rdx),%r8d
   436cf:	eb 48                	jmp    43719 <printer_vprintf+0x2e4>
   436d1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   436d5:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   436d9:	48 8d 42 08          	lea    0x8(%rdx),%rax
   436dd:	48 89 47 08          	mov    %rax,0x8(%rdi)
   436e1:	eb e9                	jmp    436cc <printer_vprintf+0x297>
   436e3:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   436e6:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   436ed:	bf 80 53 04 00       	mov    $0x45380,%edi
   436f2:	e9 e6 02 00 00       	jmpq   439dd <printer_vprintf+0x5a8>
            base = 16;
   436f7:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   436fc:	85 c9                	test   %ecx,%ecx
   436fe:	74 b6                	je     436b6 <printer_vprintf+0x281>
   43700:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43704:	8b 07                	mov    (%rdi),%eax
   43706:	83 f8 2f             	cmp    $0x2f,%eax
   43709:	77 99                	ja     436a4 <printer_vprintf+0x26f>
   4370b:	89 c2                	mov    %eax,%edx
   4370d:	48 03 57 10          	add    0x10(%rdi),%rdx
   43711:	83 c0 08             	add    $0x8,%eax
   43714:	89 07                	mov    %eax,(%rdi)
   43716:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43719:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   4371d:	85 f6                	test   %esi,%esi
   4371f:	79 c2                	jns    436e3 <printer_vprintf+0x2ae>
        base = -base;
   43721:	41 89 f1             	mov    %esi,%r9d
   43724:	f7 de                	neg    %esi
   43726:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   4372d:	bf 60 53 04 00       	mov    $0x45360,%edi
   43732:	e9 a6 02 00 00       	jmpq   439dd <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
   43737:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4373b:	8b 07                	mov    (%rdi),%eax
   4373d:	83 f8 2f             	cmp    $0x2f,%eax
   43740:	77 1c                	ja     4375e <printer_vprintf+0x329>
   43742:	89 c2                	mov    %eax,%edx
   43744:	48 03 57 10          	add    0x10(%rdi),%rdx
   43748:	83 c0 08             	add    $0x8,%eax
   4374b:	89 07                	mov    %eax,(%rdi)
   4374d:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43750:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   43757:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   4375c:	eb c3                	jmp    43721 <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
   4375e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43762:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43766:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4376a:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4376e:	eb dd                	jmp    4374d <printer_vprintf+0x318>
            data = va_arg(val, char*);
   43770:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43774:	8b 01                	mov    (%rcx),%eax
   43776:	83 f8 2f             	cmp    $0x2f,%eax
   43779:	0f 87 a9 01 00 00    	ja     43928 <printer_vprintf+0x4f3>
   4377f:	89 c2                	mov    %eax,%edx
   43781:	48 03 51 10          	add    0x10(%rcx),%rdx
   43785:	83 c0 08             	add    $0x8,%eax
   43788:	89 01                	mov    %eax,(%rcx)
   4378a:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   4378d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   43793:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43796:	83 e0 20             	and    $0x20,%eax
   43799:	89 45 8c             	mov    %eax,-0x74(%rbp)
   4379c:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   437a2:	0f 85 25 02 00 00    	jne    439cd <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   437a8:	8b 45 a8             	mov    -0x58(%rbp),%eax
   437ab:	89 45 88             	mov    %eax,-0x78(%rbp)
   437ae:	83 e0 60             	and    $0x60,%eax
   437b1:	83 f8 60             	cmp    $0x60,%eax
   437b4:	0f 84 58 02 00 00    	je     43a12 <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   437ba:	8b 45 a8             	mov    -0x58(%rbp),%eax
   437bd:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   437c0:	48 c7 45 a0 93 51 04 	movq   $0x45193,-0x60(%rbp)
   437c7:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   437c8:	83 f8 21             	cmp    $0x21,%eax
   437cb:	0f 84 7d 02 00 00    	je     43a4e <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   437d1:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   437d4:	89 c8                	mov    %ecx,%eax
   437d6:	f7 d0                	not    %eax
   437d8:	c1 e8 1f             	shr    $0x1f,%eax
   437db:	89 45 84             	mov    %eax,-0x7c(%rbp)
   437de:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   437e2:	0f 85 a2 02 00 00    	jne    43a8a <printer_vprintf+0x655>
   437e8:	84 c0                	test   %al,%al
   437ea:	0f 84 9a 02 00 00    	je     43a8a <printer_vprintf+0x655>
            len = strnlen(data, precision);
   437f0:	48 63 f1             	movslq %ecx,%rsi
   437f3:	4c 89 e7             	mov    %r12,%rdi
   437f6:	e8 61 fb ff ff       	callq  4335c <strnlen>
   437fb:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   437fe:	8b 45 88             	mov    -0x78(%rbp),%eax
   43801:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   43804:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4380b:	83 f8 22             	cmp    $0x22,%eax
   4380e:	0f 84 ae 02 00 00    	je     43ac2 <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
   43814:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43818:	e8 24 fb ff ff       	callq  43341 <strlen>
   4381d:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43820:	03 55 98             	add    -0x68(%rbp),%edx
   43823:	41 29 d5             	sub    %edx,%r13d
   43826:	44 89 ea             	mov    %r13d,%edx
   43829:	29 c2                	sub    %eax,%edx
   4382b:	89 55 8c             	mov    %edx,-0x74(%rbp)
   4382e:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43831:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   43835:	75 2d                	jne    43864 <printer_vprintf+0x42f>
   43837:	85 d2                	test   %edx,%edx
   43839:	7e 29                	jle    43864 <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
   4383b:	44 89 fa             	mov    %r15d,%edx
   4383e:	be 20 00 00 00       	mov    $0x20,%esi
   43843:	4c 89 f7             	mov    %r14,%rdi
   43846:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43849:	41 83 ed 01          	sub    $0x1,%r13d
   4384d:	45 85 ed             	test   %r13d,%r13d
   43850:	7f e9                	jg     4383b <printer_vprintf+0x406>
   43852:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   43855:	85 ff                	test   %edi,%edi
   43857:	b8 01 00 00 00       	mov    $0x1,%eax
   4385c:	0f 4f c7             	cmovg  %edi,%eax
   4385f:	29 c7                	sub    %eax,%edi
   43861:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   43864:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   43868:	0f b6 01             	movzbl (%rcx),%eax
   4386b:	84 c0                	test   %al,%al
   4386d:	74 22                	je     43891 <printer_vprintf+0x45c>
   4386f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43873:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
   43876:	0f b6 f0             	movzbl %al,%esi
   43879:	44 89 fa             	mov    %r15d,%edx
   4387c:	4c 89 f7             	mov    %r14,%rdi
   4387f:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
   43882:	48 83 c3 01          	add    $0x1,%rbx
   43886:	0f b6 03             	movzbl (%rbx),%eax
   43889:	84 c0                	test   %al,%al
   4388b:	75 e9                	jne    43876 <printer_vprintf+0x441>
   4388d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43891:	8b 45 9c             	mov    -0x64(%rbp),%eax
   43894:	85 c0                	test   %eax,%eax
   43896:	7e 1d                	jle    438b5 <printer_vprintf+0x480>
   43898:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4389c:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   4389e:	44 89 fa             	mov    %r15d,%edx
   438a1:	be 30 00 00 00       	mov    $0x30,%esi
   438a6:	4c 89 f7             	mov    %r14,%rdi
   438a9:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
   438ac:	83 eb 01             	sub    $0x1,%ebx
   438af:	75 ed                	jne    4389e <printer_vprintf+0x469>
   438b1:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   438b5:	8b 45 98             	mov    -0x68(%rbp),%eax
   438b8:	85 c0                	test   %eax,%eax
   438ba:	7e 2a                	jle    438e6 <printer_vprintf+0x4b1>
   438bc:	8d 40 ff             	lea    -0x1(%rax),%eax
   438bf:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
   438c4:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   438c8:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   438cb:	41 0f b6 34 24       	movzbl (%r12),%esi
   438d0:	44 89 fa             	mov    %r15d,%edx
   438d3:	4c 89 f7             	mov    %r14,%rdi
   438d6:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
   438d9:	49 83 c4 01          	add    $0x1,%r12
   438dd:	49 39 dc             	cmp    %rbx,%r12
   438e0:	75 e9                	jne    438cb <printer_vprintf+0x496>
   438e2:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   438e6:	45 85 ed             	test   %r13d,%r13d
   438e9:	7e 14                	jle    438ff <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
   438eb:	44 89 fa             	mov    %r15d,%edx
   438ee:	be 20 00 00 00       	mov    $0x20,%esi
   438f3:	4c 89 f7             	mov    %r14,%rdi
   438f6:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
   438f9:	41 83 ed 01          	sub    $0x1,%r13d
   438fd:	75 ec                	jne    438eb <printer_vprintf+0x4b6>
    for (; *format; ++format) {
   438ff:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43903:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43907:	84 c0                	test   %al,%al
   43909:	0f 84 00 02 00 00    	je     43b0f <printer_vprintf+0x6da>
        if (*format != '%') {
   4390f:	3c 25                	cmp    $0x25,%al
   43911:	0f 84 53 fb ff ff    	je     4346a <printer_vprintf+0x35>
            p->putc(p, *format, color);
   43917:	0f b6 f0             	movzbl %al,%esi
   4391a:	44 89 fa             	mov    %r15d,%edx
   4391d:	4c 89 f7             	mov    %r14,%rdi
   43920:	41 ff 16             	callq  *(%r14)
            continue;
   43923:	4c 89 e3             	mov    %r12,%rbx
   43926:	eb d7                	jmp    438ff <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
   43928:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4392c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43930:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43934:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43938:	e9 4d fe ff ff       	jmpq   4378a <printer_vprintf+0x355>
            color = va_arg(val, int);
   4393d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43941:	8b 07                	mov    (%rdi),%eax
   43943:	83 f8 2f             	cmp    $0x2f,%eax
   43946:	77 10                	ja     43958 <printer_vprintf+0x523>
   43948:	89 c2                	mov    %eax,%edx
   4394a:	48 03 57 10          	add    0x10(%rdi),%rdx
   4394e:	83 c0 08             	add    $0x8,%eax
   43951:	89 07                	mov    %eax,(%rdi)
   43953:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   43956:	eb a7                	jmp    438ff <printer_vprintf+0x4ca>
            color = va_arg(val, int);
   43958:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4395c:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43960:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43964:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43968:	eb e9                	jmp    43953 <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
   4396a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4396e:	8b 01                	mov    (%rcx),%eax
   43970:	83 f8 2f             	cmp    $0x2f,%eax
   43973:	77 23                	ja     43998 <printer_vprintf+0x563>
   43975:	89 c2                	mov    %eax,%edx
   43977:	48 03 51 10          	add    0x10(%rcx),%rdx
   4397b:	83 c0 08             	add    $0x8,%eax
   4397e:	89 01                	mov    %eax,(%rcx)
   43980:	8b 02                	mov    (%rdx),%eax
   43982:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43985:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43989:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4398d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43993:	e9 fb fd ff ff       	jmpq   43793 <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
   43998:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4399c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   439a0:	48 8d 42 08          	lea    0x8(%rdx),%rax
   439a4:	48 89 47 08          	mov    %rax,0x8(%rdi)
   439a8:	eb d6                	jmp    43980 <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
   439aa:	84 d2                	test   %dl,%dl
   439ac:	0f 85 3b 01 00 00    	jne    43aed <printer_vprintf+0x6b8>
   439b2:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   439b6:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   439ba:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   439be:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   439c2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   439c8:	e9 c6 fd ff ff       	jmpq   43793 <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
   439cd:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   439d3:	bf 80 53 04 00       	mov    $0x45380,%edi
        if (flags & FLAG_NUMERIC) {
   439d8:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   439dd:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   439e1:	4c 89 c1             	mov    %r8,%rcx
   439e4:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   439e8:	48 63 f6             	movslq %esi,%rsi
   439eb:	49 83 ec 01          	sub    $0x1,%r12
   439ef:	48 89 c8             	mov    %rcx,%rax
   439f2:	ba 00 00 00 00       	mov    $0x0,%edx
   439f7:	48 f7 f6             	div    %rsi
   439fa:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   439fe:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   43a02:	48 89 ca             	mov    %rcx,%rdx
   43a05:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   43a08:	48 39 d6             	cmp    %rdx,%rsi
   43a0b:	76 de                	jbe    439eb <printer_vprintf+0x5b6>
   43a0d:	e9 96 fd ff ff       	jmpq   437a8 <printer_vprintf+0x373>
                prefix = "-";
   43a12:	48 c7 45 a0 96 51 04 	movq   $0x45196,-0x60(%rbp)
   43a19:	00 
            if (flags & FLAG_NEGATIVE) {
   43a1a:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43a1d:	a8 80                	test   $0x80,%al
   43a1f:	0f 85 ac fd ff ff    	jne    437d1 <printer_vprintf+0x39c>
                prefix = "+";
   43a25:	48 c7 45 a0 94 51 04 	movq   $0x45194,-0x60(%rbp)
   43a2c:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43a2d:	a8 10                	test   $0x10,%al
   43a2f:	0f 85 9c fd ff ff    	jne    437d1 <printer_vprintf+0x39c>
                prefix = " ";
   43a35:	a8 08                	test   $0x8,%al
   43a37:	ba 93 51 04 00       	mov    $0x45193,%edx
   43a3c:	b8 92 51 04 00       	mov    $0x45192,%eax
   43a41:	48 0f 44 c2          	cmove  %rdx,%rax
   43a45:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43a49:	e9 83 fd ff ff       	jmpq   437d1 <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
   43a4e:	41 8d 41 10          	lea    0x10(%r9),%eax
   43a52:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   43a57:	0f 85 74 fd ff ff    	jne    437d1 <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
   43a5d:	4d 85 c0             	test   %r8,%r8
   43a60:	75 0d                	jne    43a6f <printer_vprintf+0x63a>
   43a62:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   43a69:	0f 84 62 fd ff ff    	je     437d1 <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
   43a6f:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   43a73:	ba 8f 51 04 00       	mov    $0x4518f,%edx
   43a78:	b8 98 51 04 00       	mov    $0x45198,%eax
   43a7d:	48 0f 44 c2          	cmove  %rdx,%rax
   43a81:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43a85:	e9 47 fd ff ff       	jmpq   437d1 <printer_vprintf+0x39c>
            len = strlen(data);
   43a8a:	4c 89 e7             	mov    %r12,%rdi
   43a8d:	e8 af f8 ff ff       	callq  43341 <strlen>
   43a92:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43a95:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43a99:	0f 84 5f fd ff ff    	je     437fe <printer_vprintf+0x3c9>
   43a9f:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43aa3:	0f 84 55 fd ff ff    	je     437fe <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
   43aa9:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   43aac:	89 fa                	mov    %edi,%edx
   43aae:	29 c2                	sub    %eax,%edx
   43ab0:	39 c7                	cmp    %eax,%edi
   43ab2:	b8 00 00 00 00       	mov    $0x0,%eax
   43ab7:	0f 4e d0             	cmovle %eax,%edx
   43aba:	89 55 9c             	mov    %edx,-0x64(%rbp)
   43abd:	e9 52 fd ff ff       	jmpq   43814 <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
   43ac2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43ac6:	e8 76 f8 ff ff       	callq  43341 <strlen>
   43acb:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43ace:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43ad1:	44 89 e9             	mov    %r13d,%ecx
   43ad4:	29 f9                	sub    %edi,%ecx
   43ad6:	29 c1                	sub    %eax,%ecx
   43ad8:	89 c8                	mov    %ecx,%eax
   43ada:	44 39 ea             	cmp    %r13d,%edx
   43add:	b9 00 00 00 00       	mov    $0x0,%ecx
   43ae2:	0f 4d c1             	cmovge %ecx,%eax
   43ae5:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43ae8:	e9 27 fd ff ff       	jmpq   43814 <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
   43aed:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43af0:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43af4:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43af8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43afe:	e9 90 fc ff ff       	jmpq   43793 <printer_vprintf+0x35e>
        int flags = 0;
   43b03:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   43b0a:	e9 ad f9 ff ff       	jmpq   434bc <printer_vprintf+0x87>
}
   43b0f:	48 83 c4 58          	add    $0x58,%rsp
   43b13:	5b                   	pop    %rbx
   43b14:	41 5c                	pop    %r12
   43b16:	41 5d                	pop    %r13
   43b18:	41 5e                	pop    %r14
   43b1a:	41 5f                	pop    %r15
   43b1c:	5d                   	pop    %rbp
   43b1d:	c3                   	retq   

0000000000043b1e <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43b1e:	55                   	push   %rbp
   43b1f:	48 89 e5             	mov    %rsp,%rbp
   43b22:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   43b26:	48 c7 45 f0 1c 32 04 	movq   $0x4321c,-0x10(%rbp)
   43b2d:	00 
        cpos = 0;
   43b2e:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   43b34:	b8 00 00 00 00       	mov    $0x0,%eax
   43b39:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   43b3c:	48 63 ff             	movslq %edi,%rdi
   43b3f:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   43b46:	00 
   43b47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43b4b:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   43b4f:	e8 e1 f8 ff ff       	callq  43435 <printer_vprintf>
    return cp.cursor - console;
   43b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b58:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43b5e:	48 d1 f8             	sar    %rax
}
   43b61:	c9                   	leaveq 
   43b62:	c3                   	retq   

0000000000043b63 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   43b63:	55                   	push   %rbp
   43b64:	48 89 e5             	mov    %rsp,%rbp
   43b67:	48 83 ec 50          	sub    $0x50,%rsp
   43b6b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43b6f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43b73:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   43b77:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43b7e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43b82:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43b86:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43b8a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43b8e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43b92:	e8 87 ff ff ff       	callq  43b1e <console_vprintf>
}
   43b97:	c9                   	leaveq 
   43b98:	c3                   	retq   

0000000000043b99 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43b99:	55                   	push   %rbp
   43b9a:	48 89 e5             	mov    %rsp,%rbp
   43b9d:	53                   	push   %rbx
   43b9e:	48 83 ec 28          	sub    $0x28,%rsp
   43ba2:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   43ba5:	48 c7 45 d8 a6 32 04 	movq   $0x432a6,-0x28(%rbp)
   43bac:	00 
    sp.s = s;
   43bad:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   43bb1:	48 85 f6             	test   %rsi,%rsi
   43bb4:	75 0e                	jne    43bc4 <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   43bb6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bba:	48 29 d8             	sub    %rbx,%rax
}
   43bbd:	48 83 c4 28          	add    $0x28,%rsp
   43bc1:	5b                   	pop    %rbx
   43bc2:	5d                   	pop    %rbp
   43bc3:	c3                   	retq   
        sp.end = s + size - 1;
   43bc4:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43bc9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43bcd:	be 00 00 00 00       	mov    $0x0,%esi
   43bd2:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43bd6:	e8 5a f8 ff ff       	callq  43435 <printer_vprintf>
        *sp.s = 0;
   43bdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bdf:	c6 00 00             	movb   $0x0,(%rax)
   43be2:	eb d2                	jmp    43bb6 <vsnprintf+0x1d>

0000000000043be4 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43be4:	55                   	push   %rbp
   43be5:	48 89 e5             	mov    %rsp,%rbp
   43be8:	48 83 ec 50          	sub    $0x50,%rsp
   43bec:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43bf0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43bf4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43bf8:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43bff:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43c03:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43c07:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43c0b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   43c0f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43c13:	e8 81 ff ff ff       	callq  43b99 <vsnprintf>
    va_end(val);
    return n;
}
   43c18:	c9                   	leaveq 
   43c19:	c3                   	retq   

0000000000043c1a <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43c1a:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   43c1f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   43c24:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43c29:	48 83 c0 02          	add    $0x2,%rax
   43c2d:	48 39 d0             	cmp    %rdx,%rax
   43c30:	75 f2                	jne    43c24 <console_clear+0xa>
    }
    cursorpos = 0;
   43c32:	c7 05 c0 53 07 00 00 	movl   $0x0,0x753c0(%rip)        # b8ffc <cursorpos>
   43c39:	00 00 00 
}
   43c3c:	c3                   	retq   

0000000000043c3d <palloc>:
   43c3d:	55                   	push   %rbp
   43c3e:	48 89 e5             	mov    %rsp,%rbp
   43c41:	48 83 ec 20          	sub    $0x20,%rsp
   43c45:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43c48:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43c4f:	00 
   43c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c54:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c58:	e9 95 00 00 00       	jmpq   43cf2 <palloc+0xb5>
   43c5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c61:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c65:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43c6c:	00 
   43c6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c71:	48 c1 e8 0c          	shr    $0xc,%rax
   43c75:	48 98                	cltq   
   43c77:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   43c7e:	00 
   43c7f:	84 c0                	test   %al,%al
   43c81:	75 6f                	jne    43cf2 <palloc+0xb5>
   43c83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c87:	48 c1 e8 0c          	shr    $0xc,%rax
   43c8b:	48 98                	cltq   
   43c8d:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43c94:	00 
   43c95:	84 c0                	test   %al,%al
   43c97:	75 59                	jne    43cf2 <palloc+0xb5>
   43c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c9d:	48 c1 e8 0c          	shr    $0xc,%rax
   43ca1:	89 c2                	mov    %eax,%edx
   43ca3:	48 63 c2             	movslq %edx,%rax
   43ca6:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43cad:	00 
   43cae:	83 c0 01             	add    $0x1,%eax
   43cb1:	89 c1                	mov    %eax,%ecx
   43cb3:	48 63 c2             	movslq %edx,%rax
   43cb6:	88 8c 00 41 af 05 00 	mov    %cl,0x5af41(%rax,%rax,1)
   43cbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cc1:	48 c1 e8 0c          	shr    $0xc,%rax
   43cc5:	89 c1                	mov    %eax,%ecx
   43cc7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cca:	89 c2                	mov    %eax,%edx
   43ccc:	48 63 c1             	movslq %ecx,%rax
   43ccf:	88 94 00 40 af 05 00 	mov    %dl,0x5af40(%rax,%rax,1)
   43cd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cda:	ba 00 10 00 00       	mov    $0x1000,%edx
   43cdf:	be cc 00 00 00       	mov    $0xcc,%esi
   43ce4:	48 89 c7             	mov    %rax,%rdi
   43ce7:	e8 39 f6 ff ff       	callq  43325 <memset>
   43cec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cf0:	eb 2c                	jmp    43d1e <palloc+0xe1>
   43cf2:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43cf9:	00 
   43cfa:	0f 86 5d ff ff ff    	jbe    43c5d <palloc+0x20>
   43d00:	ba 98 53 04 00       	mov    $0x45398,%edx
   43d05:	be 00 0c 00 00       	mov    $0xc00,%esi
   43d0a:	bf 80 07 00 00       	mov    $0x780,%edi
   43d0f:	b8 00 00 00 00       	mov    $0x0,%eax
   43d14:	e8 4a fe ff ff       	callq  43b63 <console_printf>
   43d19:	b8 00 00 00 00       	mov    $0x0,%eax
   43d1e:	c9                   	leaveq 
   43d1f:	c3                   	retq   

0000000000043d20 <palloc_target>:
   43d20:	55                   	push   %rbp
   43d21:	48 89 e5             	mov    %rsp,%rbp
   43d24:	48 8b 05 ed 62 01 00 	mov    0x162ed(%rip),%rax        # 5a018 <palloc_target_proc>
   43d2b:	48 85 c0             	test   %rax,%rax
   43d2e:	75 14                	jne    43d44 <palloc_target+0x24>
   43d30:	ba b1 53 04 00       	mov    $0x453b1,%edx
   43d35:	be 27 00 00 00       	mov    $0x27,%esi
   43d3a:	bf cc 53 04 00       	mov    $0x453cc,%edi
   43d3f:	e8 a5 f0 ff ff       	callq  42de9 <assert_fail>
   43d44:	48 8b 05 cd 62 01 00 	mov    0x162cd(%rip),%rax        # 5a018 <palloc_target_proc>
   43d4b:	8b 00                	mov    (%rax),%eax
   43d4d:	89 c7                	mov    %eax,%edi
   43d4f:	e8 e9 fe ff ff       	callq  43c3d <palloc>
   43d54:	5d                   	pop    %rbp
   43d55:	c3                   	retq   

0000000000043d56 <process_free>:
   43d56:	55                   	push   %rbp
   43d57:	48 89 e5             	mov    %rsp,%rbp
   43d5a:	48 83 ec 60          	sub    $0x60,%rsp
   43d5e:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43d61:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43d64:	48 63 d0             	movslq %eax,%rdx
   43d67:	48 89 d0             	mov    %rdx,%rax
   43d6a:	48 c1 e0 04          	shl    $0x4,%rax
   43d6e:	48 29 d0             	sub    %rdx,%rax
   43d71:	48 c1 e0 04          	shl    $0x4,%rax
   43d75:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   43d7b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43d81:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43d88:	00 
   43d89:	e9 ad 00 00 00       	jmpq   43e3b <process_free+0xe5>
   43d8e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43d91:	48 63 d0             	movslq %eax,%rdx
   43d94:	48 89 d0             	mov    %rdx,%rax
   43d97:	48 c1 e0 04          	shl    $0x4,%rax
   43d9b:	48 29 d0             	sub    %rdx,%rax
   43d9e:	48 c1 e0 04          	shl    $0x4,%rax
   43da2:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   43da8:	48 8b 08             	mov    (%rax),%rcx
   43dab:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43daf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43db3:	48 89 ce             	mov    %rcx,%rsi
   43db6:	48 89 c7             	mov    %rax,%rdi
   43db9:	e8 00 e4 ff ff       	callq  421be <virtual_memory_lookup>
   43dbe:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43dc1:	48 98                	cltq   
   43dc3:	83 e0 01             	and    $0x1,%eax
   43dc6:	48 85 c0             	test   %rax,%rax
   43dc9:	74 68                	je     43e33 <process_free+0xdd>
   43dcb:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43dce:	48 63 d0             	movslq %eax,%rdx
   43dd1:	0f b6 94 12 41 af 05 	movzbl 0x5af41(%rdx,%rdx,1),%edx
   43dd8:	00 
   43dd9:	83 ea 01             	sub    $0x1,%edx
   43ddc:	48 98                	cltq   
   43dde:	88 94 00 41 af 05 00 	mov    %dl,0x5af41(%rax,%rax,1)
   43de5:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43de8:	48 98                	cltq   
   43dea:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43df1:	00 
   43df2:	84 c0                	test   %al,%al
   43df4:	75 0f                	jne    43e05 <process_free+0xaf>
   43df6:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43df9:	48 98                	cltq   
   43dfb:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   43e02:	00 
   43e03:	eb 2e                	jmp    43e33 <process_free+0xdd>
   43e05:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43e08:	48 98                	cltq   
   43e0a:	0f b6 84 00 40 af 05 	movzbl 0x5af40(%rax,%rax,1),%eax
   43e11:	00 
   43e12:	0f be c0             	movsbl %al,%eax
   43e15:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43e18:	75 19                	jne    43e33 <process_free+0xdd>
   43e1a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e1e:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43e21:	48 89 c6             	mov    %rax,%rsi
   43e24:	bf d8 53 04 00       	mov    $0x453d8,%edi
   43e29:	b8 00 00 00 00       	mov    $0x0,%eax
   43e2e:	e8 ad ec ff ff       	callq  42ae0 <log_printf>
   43e33:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43e3a:	00 
   43e3b:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43e42:	00 
   43e43:	0f 86 45 ff ff ff    	jbe    43d8e <process_free+0x38>
   43e49:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43e4c:	48 63 d0             	movslq %eax,%rdx
   43e4f:	48 89 d0             	mov    %rdx,%rax
   43e52:	48 c1 e0 04          	shl    $0x4,%rax
   43e56:	48 29 d0             	sub    %rdx,%rax
   43e59:	48 c1 e0 04          	shl    $0x4,%rax
   43e5d:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   43e63:	48 8b 00             	mov    (%rax),%rax
   43e66:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43e6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e6e:	48 8b 00             	mov    (%rax),%rax
   43e71:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e77:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43e7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e7f:	48 8b 00             	mov    (%rax),%rax
   43e82:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e88:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43e8c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e90:	48 8b 00             	mov    (%rax),%rax
   43e93:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e99:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43e9d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ea1:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ea5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43eab:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43eaf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43eb3:	48 c1 e8 0c          	shr    $0xc,%rax
   43eb7:	48 98                	cltq   
   43eb9:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43ec0:	00 
   43ec1:	3c 01                	cmp    $0x1,%al
   43ec3:	74 14                	je     43ed9 <process_free+0x183>
   43ec5:	ba 10 54 04 00       	mov    $0x45410,%edx
   43eca:	be 4f 00 00 00       	mov    $0x4f,%esi
   43ecf:	bf cc 53 04 00       	mov    $0x453cc,%edi
   43ed4:	e8 10 ef ff ff       	callq  42de9 <assert_fail>
   43ed9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43edd:	48 c1 e8 0c          	shr    $0xc,%rax
   43ee1:	48 98                	cltq   
   43ee3:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   43eea:	00 
   43eeb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43eef:	48 c1 e8 0c          	shr    $0xc,%rax
   43ef3:	48 98                	cltq   
   43ef5:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   43efc:	00 
   43efd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f01:	48 c1 e8 0c          	shr    $0xc,%rax
   43f05:	48 98                	cltq   
   43f07:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43f0e:	00 
   43f0f:	3c 01                	cmp    $0x1,%al
   43f11:	74 14                	je     43f27 <process_free+0x1d1>
   43f13:	ba 38 54 04 00       	mov    $0x45438,%edx
   43f18:	be 52 00 00 00       	mov    $0x52,%esi
   43f1d:	bf cc 53 04 00       	mov    $0x453cc,%edi
   43f22:	e8 c2 ee ff ff       	callq  42de9 <assert_fail>
   43f27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f2b:	48 c1 e8 0c          	shr    $0xc,%rax
   43f2f:	48 98                	cltq   
   43f31:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   43f38:	00 
   43f39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f3d:	48 c1 e8 0c          	shr    $0xc,%rax
   43f41:	48 98                	cltq   
   43f43:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   43f4a:	00 
   43f4b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f4f:	48 c1 e8 0c          	shr    $0xc,%rax
   43f53:	48 98                	cltq   
   43f55:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43f5c:	00 
   43f5d:	3c 01                	cmp    $0x1,%al
   43f5f:	74 14                	je     43f75 <process_free+0x21f>
   43f61:	ba 60 54 04 00       	mov    $0x45460,%edx
   43f66:	be 55 00 00 00       	mov    $0x55,%esi
   43f6b:	bf cc 53 04 00       	mov    $0x453cc,%edi
   43f70:	e8 74 ee ff ff       	callq  42de9 <assert_fail>
   43f75:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f79:	48 c1 e8 0c          	shr    $0xc,%rax
   43f7d:	48 98                	cltq   
   43f7f:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   43f86:	00 
   43f87:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f8b:	48 c1 e8 0c          	shr    $0xc,%rax
   43f8f:	48 98                	cltq   
   43f91:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   43f98:	00 
   43f99:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f9d:	48 c1 e8 0c          	shr    $0xc,%rax
   43fa1:	48 98                	cltq   
   43fa3:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43faa:	00 
   43fab:	3c 01                	cmp    $0x1,%al
   43fad:	74 14                	je     43fc3 <process_free+0x26d>
   43faf:	ba 88 54 04 00       	mov    $0x45488,%edx
   43fb4:	be 58 00 00 00       	mov    $0x58,%esi
   43fb9:	bf cc 53 04 00       	mov    $0x453cc,%edi
   43fbe:	e8 26 ee ff ff       	callq  42de9 <assert_fail>
   43fc3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fc7:	48 c1 e8 0c          	shr    $0xc,%rax
   43fcb:	48 98                	cltq   
   43fcd:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   43fd4:	00 
   43fd5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fd9:	48 c1 e8 0c          	shr    $0xc,%rax
   43fdd:	48 98                	cltq   
   43fdf:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   43fe6:	00 
   43fe7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43feb:	48 c1 e8 0c          	shr    $0xc,%rax
   43fef:	48 98                	cltq   
   43ff1:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   43ff8:	00 
   43ff9:	3c 01                	cmp    $0x1,%al
   43ffb:	74 14                	je     44011 <process_free+0x2bb>
   43ffd:	ba b0 54 04 00       	mov    $0x454b0,%edx
   44002:	be 5b 00 00 00       	mov    $0x5b,%esi
   44007:	bf cc 53 04 00       	mov    $0x453cc,%edi
   4400c:	e8 d8 ed ff ff       	callq  42de9 <assert_fail>
   44011:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44015:	48 c1 e8 0c          	shr    $0xc,%rax
   44019:	48 98                	cltq   
   4401b:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   44022:	00 
   44023:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44027:	48 c1 e8 0c          	shr    $0xc,%rax
   4402b:	48 98                	cltq   
   4402d:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   44034:	00 
   44035:	90                   	nop
   44036:	c9                   	leaveq 
   44037:	c3                   	retq   

0000000000044038 <process_config_tables>:
   44038:	55                   	push   %rbp
   44039:	48 89 e5             	mov    %rsp,%rbp
   4403c:	48 83 ec 40          	sub    $0x40,%rsp
   44040:	89 7d cc             	mov    %edi,-0x34(%rbp)
   44043:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44046:	89 c7                	mov    %eax,%edi
   44048:	e8 f0 fb ff ff       	callq  43c3d <palloc>
   4404d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44051:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44054:	89 c7                	mov    %eax,%edi
   44056:	e8 e2 fb ff ff       	callq  43c3d <palloc>
   4405b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4405f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44062:	89 c7                	mov    %eax,%edi
   44064:	e8 d4 fb ff ff       	callq  43c3d <palloc>
   44069:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4406d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44070:	89 c7                	mov    %eax,%edi
   44072:	e8 c6 fb ff ff       	callq  43c3d <palloc>
   44077:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4407b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4407e:	89 c7                	mov    %eax,%edi
   44080:	e8 b8 fb ff ff       	callq  43c3d <palloc>
   44085:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   44089:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4408e:	74 20                	je     440b0 <process_config_tables+0x78>
   44090:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   44095:	74 19                	je     440b0 <process_config_tables+0x78>
   44097:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4409c:	74 12                	je     440b0 <process_config_tables+0x78>
   4409e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   440a3:	74 0b                	je     440b0 <process_config_tables+0x78>
   440a5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   440aa:	0f 85 e1 00 00 00    	jne    44191 <process_config_tables+0x159>
   440b0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   440b5:	74 24                	je     440db <process_config_tables+0xa3>
   440b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440bb:	48 c1 e8 0c          	shr    $0xc,%rax
   440bf:	48 98                	cltq   
   440c1:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   440c8:	00 
   440c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440cd:	48 c1 e8 0c          	shr    $0xc,%rax
   440d1:	48 98                	cltq   
   440d3:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   440da:	00 
   440db:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   440e0:	74 24                	je     44106 <process_config_tables+0xce>
   440e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440e6:	48 c1 e8 0c          	shr    $0xc,%rax
   440ea:	48 98                	cltq   
   440ec:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   440f3:	00 
   440f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440f8:	48 c1 e8 0c          	shr    $0xc,%rax
   440fc:	48 98                	cltq   
   440fe:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   44105:	00 
   44106:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4410b:	74 24                	je     44131 <process_config_tables+0xf9>
   4410d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44111:	48 c1 e8 0c          	shr    $0xc,%rax
   44115:	48 98                	cltq   
   44117:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   4411e:	00 
   4411f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44123:	48 c1 e8 0c          	shr    $0xc,%rax
   44127:	48 98                	cltq   
   44129:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   44130:	00 
   44131:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   44136:	74 24                	je     4415c <process_config_tables+0x124>
   44138:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4413c:	48 c1 e8 0c          	shr    $0xc,%rax
   44140:	48 98                	cltq   
   44142:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   44149:	00 
   4414a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4414e:	48 c1 e8 0c          	shr    $0xc,%rax
   44152:	48 98                	cltq   
   44154:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   4415b:	00 
   4415c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44161:	74 24                	je     44187 <process_config_tables+0x14f>
   44163:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44167:	48 c1 e8 0c          	shr    $0xc,%rax
   4416b:	48 98                	cltq   
   4416d:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   44174:	00 
   44175:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44179:	48 c1 e8 0c          	shr    $0xc,%rax
   4417d:	48 98                	cltq   
   4417f:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   44186:	00 
   44187:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4418c:	e9 f3 01 00 00       	jmpq   44384 <process_config_tables+0x34c>
   44191:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44195:	ba 00 10 00 00       	mov    $0x1000,%edx
   4419a:	be 00 00 00 00       	mov    $0x0,%esi
   4419f:	48 89 c7             	mov    %rax,%rdi
   441a2:	e8 7e f1 ff ff       	callq  43325 <memset>
   441a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441ab:	ba 00 10 00 00       	mov    $0x1000,%edx
   441b0:	be 00 00 00 00       	mov    $0x0,%esi
   441b5:	48 89 c7             	mov    %rax,%rdi
   441b8:	e8 68 f1 ff ff       	callq  43325 <memset>
   441bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441c1:	ba 00 10 00 00       	mov    $0x1000,%edx
   441c6:	be 00 00 00 00       	mov    $0x0,%esi
   441cb:	48 89 c7             	mov    %rax,%rdi
   441ce:	e8 52 f1 ff ff       	callq  43325 <memset>
   441d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   441d7:	ba 00 10 00 00       	mov    $0x1000,%edx
   441dc:	be 00 00 00 00       	mov    $0x0,%esi
   441e1:	48 89 c7             	mov    %rax,%rdi
   441e4:	e8 3c f1 ff ff       	callq  43325 <memset>
   441e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441ed:	ba 00 10 00 00       	mov    $0x1000,%edx
   441f2:	be 00 00 00 00       	mov    $0x0,%esi
   441f7:	48 89 c7             	mov    %rax,%rdi
   441fa:	e8 26 f1 ff ff       	callq  43325 <memset>
   441ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44203:	48 83 c8 07          	or     $0x7,%rax
   44207:	48 89 c2             	mov    %rax,%rdx
   4420a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4420e:	48 89 10             	mov    %rdx,(%rax)
   44211:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44215:	48 83 c8 07          	or     $0x7,%rax
   44219:	48 89 c2             	mov    %rax,%rdx
   4421c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44220:	48 89 10             	mov    %rdx,(%rax)
   44223:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44227:	48 83 c8 07          	or     $0x7,%rax
   4422b:	48 89 c2             	mov    %rax,%rdx
   4422e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44232:	48 89 10             	mov    %rdx,(%rax)
   44235:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44239:	48 83 c8 07          	or     $0x7,%rax
   4423d:	48 89 c2             	mov    %rax,%rdx
   44240:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44244:	48 89 50 08          	mov    %rdx,0x8(%rax)
   44248:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4424c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44252:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   44258:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4425d:	ba 00 00 00 00       	mov    $0x0,%edx
   44262:	be 00 00 00 00       	mov    $0x0,%esi
   44267:	48 89 c7             	mov    %rax,%rdi
   4426a:	e8 58 db ff ff       	callq  41dc7 <virtual_memory_map>
   4426f:	85 c0                	test   %eax,%eax
   44271:	75 2f                	jne    442a2 <process_config_tables+0x26a>
   44273:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   44278:	be 00 80 0b 00       	mov    $0xb8000,%esi
   4427d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44281:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44287:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4428d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44292:	48 89 c7             	mov    %rax,%rdi
   44295:	e8 2d db ff ff       	callq  41dc7 <virtual_memory_map>
   4429a:	85 c0                	test   %eax,%eax
   4429c:	0f 84 bb 00 00 00    	je     4435d <process_config_tables+0x325>
   442a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442a6:	48 c1 e8 0c          	shr    $0xc,%rax
   442aa:	48 98                	cltq   
   442ac:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   442b3:	00 
   442b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442b8:	48 c1 e8 0c          	shr    $0xc,%rax
   442bc:	48 98                	cltq   
   442be:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   442c5:	00 
   442c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442ca:	48 c1 e8 0c          	shr    $0xc,%rax
   442ce:	48 98                	cltq   
   442d0:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   442d7:	00 
   442d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442dc:	48 c1 e8 0c          	shr    $0xc,%rax
   442e0:	48 98                	cltq   
   442e2:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   442e9:	00 
   442ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442ee:	48 c1 e8 0c          	shr    $0xc,%rax
   442f2:	48 98                	cltq   
   442f4:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   442fb:	00 
   442fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44300:	48 c1 e8 0c          	shr    $0xc,%rax
   44304:	48 98                	cltq   
   44306:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   4430d:	00 
   4430e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44312:	48 c1 e8 0c          	shr    $0xc,%rax
   44316:	48 98                	cltq   
   44318:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   4431f:	00 
   44320:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44324:	48 c1 e8 0c          	shr    $0xc,%rax
   44328:	48 98                	cltq   
   4432a:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   44331:	00 
   44332:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44336:	48 c1 e8 0c          	shr    $0xc,%rax
   4433a:	48 98                	cltq   
   4433c:	c6 84 00 40 af 05 00 	movb   $0x0,0x5af40(%rax,%rax,1)
   44343:	00 
   44344:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44348:	48 c1 e8 0c          	shr    $0xc,%rax
   4434c:	48 98                	cltq   
   4434e:	c6 84 00 41 af 05 00 	movb   $0x0,0x5af41(%rax,%rax,1)
   44355:	00 
   44356:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4435b:	eb 27                	jmp    44384 <process_config_tables+0x34c>
   4435d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44360:	48 63 d0             	movslq %eax,%rdx
   44363:	48 89 d0             	mov    %rdx,%rax
   44366:	48 c1 e0 04          	shl    $0x4,%rax
   4436a:	48 29 d0             	sub    %rdx,%rax
   4436d:	48 c1 e0 04          	shl    $0x4,%rax
   44371:	48 8d 90 00 a1 05 00 	lea    0x5a100(%rax),%rdx
   44378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4437c:	48 89 02             	mov    %rax,(%rdx)
   4437f:	b8 00 00 00 00       	mov    $0x0,%eax
   44384:	c9                   	leaveq 
   44385:	c3                   	retq   

0000000000044386 <process_load>:
   44386:	55                   	push   %rbp
   44387:	48 89 e5             	mov    %rsp,%rbp
   4438a:	48 83 ec 20          	sub    $0x20,%rsp
   4438e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44392:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   44395:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44399:	48 89 05 78 5c 01 00 	mov    %rax,0x15c78(%rip)        # 5a018 <palloc_target_proc>
   443a0:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   443a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443a7:	ba 20 3d 04 00       	mov    $0x43d20,%edx
   443ac:	89 ce                	mov    %ecx,%esi
   443ae:	48 89 c7             	mov    %rax,%rdi
   443b1:	e8 98 ea ff ff       	callq  42e4e <program_load>
   443b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
   443b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   443bc:	c9                   	leaveq 
   443bd:	c3                   	retq   

00000000000443be <process_setup_stack>:
   443be:	55                   	push   %rbp
   443bf:	48 89 e5             	mov    %rsp,%rbp
   443c2:	48 83 ec 20          	sub    $0x20,%rsp
   443c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443ce:	8b 00                	mov    (%rax),%eax
   443d0:	89 c7                	mov    %eax,%edi
   443d2:	e8 66 f8 ff ff       	callq  43c3d <palloc>
   443d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   443db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443df:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   443e6:	00 00 30 00 
   443ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443ee:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   443f5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   443f9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   443ff:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44405:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4440a:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   4440f:	48 89 c7             	mov    %rax,%rdi
   44412:	e8 b0 d9 ff ff       	callq  41dc7 <virtual_memory_map>
   44417:	90                   	nop
   44418:	c9                   	leaveq 
   44419:	c3                   	retq   

000000000004441a <find_free_pid>:
   4441a:	55                   	push   %rbp
   4441b:	48 89 e5             	mov    %rsp,%rbp
   4441e:	48 83 ec 10          	sub    $0x10,%rsp
   44422:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44429:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   44430:	eb 24                	jmp    44456 <find_free_pid+0x3c>
   44432:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44435:	48 63 d0             	movslq %eax,%rdx
   44438:	48 89 d0             	mov    %rdx,%rax
   4443b:	48 c1 e0 04          	shl    $0x4,%rax
   4443f:	48 29 d0             	sub    %rdx,%rax
   44442:	48 c1 e0 04          	shl    $0x4,%rax
   44446:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   4444c:	8b 00                	mov    (%rax),%eax
   4444e:	85 c0                	test   %eax,%eax
   44450:	74 0c                	je     4445e <find_free_pid+0x44>
   44452:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44456:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4445a:	7e d6                	jle    44432 <find_free_pid+0x18>
   4445c:	eb 01                	jmp    4445f <find_free_pid+0x45>
   4445e:	90                   	nop
   4445f:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   44463:	74 05                	je     4446a <find_free_pid+0x50>
   44465:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44468:	eb 05                	jmp    4446f <find_free_pid+0x55>
   4446a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4446f:	c9                   	leaveq 
   44470:	c3                   	retq   

0000000000044471 <process_fork>:
   44471:	55                   	push   %rbp
   44472:	48 89 e5             	mov    %rsp,%rbp
   44475:	48 83 ec 40          	sub    $0x40,%rsp
   44479:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4447d:	b8 00 00 00 00       	mov    $0x0,%eax
   44482:	e8 93 ff ff ff       	callq  4441a <find_free_pid>
   44487:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4448a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   4448e:	75 0a                	jne    4449a <process_fork+0x29>
   44490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44495:	e9 67 02 00 00       	jmpq   44701 <process_fork+0x290>
   4449a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4449d:	48 63 d0             	movslq %eax,%rdx
   444a0:	48 89 d0             	mov    %rdx,%rax
   444a3:	48 c1 e0 04          	shl    $0x4,%rax
   444a7:	48 29 d0             	sub    %rdx,%rax
   444aa:	48 c1 e0 04          	shl    $0x4,%rax
   444ae:	48 05 20 a0 05 00    	add    $0x5a020,%rax
   444b4:	be 00 00 00 00       	mov    $0x0,%esi
   444b9:	48 89 c7             	mov    %rax,%rdi
   444bc:	e8 ea e0 ff ff       	callq  425ab <process_init>
   444c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   444c4:	89 c7                	mov    %eax,%edi
   444c6:	e8 6d fb ff ff       	callq  44038 <process_config_tables>
   444cb:	83 f8 ff             	cmp    $0xffffffff,%eax
   444ce:	75 0a                	jne    444da <process_fork+0x69>
   444d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   444d5:	e9 27 02 00 00       	jmpq   44701 <process_fork+0x290>
   444da:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   444e1:	00 
   444e2:	e9 79 01 00 00       	jmpq   44660 <process_fork+0x1ef>
   444e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   444eb:	8b 00                	mov    (%rax),%eax
   444ed:	48 63 d0             	movslq %eax,%rdx
   444f0:	48 89 d0             	mov    %rdx,%rax
   444f3:	48 c1 e0 04          	shl    $0x4,%rax
   444f7:	48 29 d0             	sub    %rdx,%rax
   444fa:	48 c1 e0 04          	shl    $0x4,%rax
   444fe:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   44504:	48 8b 08             	mov    (%rax),%rcx
   44507:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4450b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4450f:	48 89 ce             	mov    %rcx,%rsi
   44512:	48 89 c7             	mov    %rax,%rdi
   44515:	e8 a4 dc ff ff       	callq  421be <virtual_memory_lookup>
   4451a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4451d:	48 98                	cltq   
   4451f:	83 e0 07             	and    $0x7,%eax
   44522:	48 83 f8 07          	cmp    $0x7,%rax
   44526:	0f 85 a1 00 00 00    	jne    445cd <process_fork+0x15c>
   4452c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4452f:	89 c7                	mov    %eax,%edi
   44531:	e8 07 f7 ff ff       	callq  43c3d <palloc>
   44536:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4453a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4453f:	75 14                	jne    44555 <process_fork+0xe4>
   44541:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44544:	89 c7                	mov    %eax,%edi
   44546:	e8 0b f8 ff ff       	callq  43d56 <process_free>
   4454b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44550:	e9 ac 01 00 00       	jmpq   44701 <process_fork+0x290>
   44555:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44559:	48 89 c1             	mov    %rax,%rcx
   4455c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44560:	ba 00 10 00 00       	mov    $0x1000,%edx
   44565:	48 89 ce             	mov    %rcx,%rsi
   44568:	48 89 c7             	mov    %rax,%rdi
   4456b:	e8 4c ed ff ff       	callq  432bc <memcpy>
   44570:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   44574:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44577:	48 63 d0             	movslq %eax,%rdx
   4457a:	48 89 d0             	mov    %rdx,%rax
   4457d:	48 c1 e0 04          	shl    $0x4,%rax
   44581:	48 29 d0             	sub    %rdx,%rax
   44584:	48 c1 e0 04          	shl    $0x4,%rax
   44588:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   4458e:	48 8b 00             	mov    (%rax),%rax
   44591:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   44595:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4459b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   445a1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   445a6:	48 89 fa             	mov    %rdi,%rdx
   445a9:	48 89 c7             	mov    %rax,%rdi
   445ac:	e8 16 d8 ff ff       	callq  41dc7 <virtual_memory_map>
   445b1:	85 c0                	test   %eax,%eax
   445b3:	0f 84 9f 00 00 00    	je     44658 <process_fork+0x1e7>
   445b9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   445bc:	89 c7                	mov    %eax,%edi
   445be:	e8 93 f7 ff ff       	callq  43d56 <process_free>
   445c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   445c8:	e9 34 01 00 00       	jmpq   44701 <process_fork+0x290>
   445cd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   445d0:	48 98                	cltq   
   445d2:	83 e0 05             	and    $0x5,%eax
   445d5:	48 83 f8 05          	cmp    $0x5,%rax
   445d9:	75 7d                	jne    44658 <process_fork+0x1e7>
   445db:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   445df:	8b 45 f4             	mov    -0xc(%rbp),%eax
   445e2:	48 63 d0             	movslq %eax,%rdx
   445e5:	48 89 d0             	mov    %rdx,%rax
   445e8:	48 c1 e0 04          	shl    $0x4,%rax
   445ec:	48 29 d0             	sub    %rdx,%rax
   445ef:	48 c1 e0 04          	shl    $0x4,%rax
   445f3:	48 05 00 a1 05 00    	add    $0x5a100,%rax
   445f9:	48 8b 00             	mov    (%rax),%rax
   445fc:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   44600:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44606:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4460c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44611:	48 89 fa             	mov    %rdi,%rdx
   44614:	48 89 c7             	mov    %rax,%rdi
   44617:	e8 ab d7 ff ff       	callq  41dc7 <virtual_memory_map>
   4461c:	85 c0                	test   %eax,%eax
   4461e:	74 14                	je     44634 <process_fork+0x1c3>
   44620:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44623:	89 c7                	mov    %eax,%edi
   44625:	e8 2c f7 ff ff       	callq  43d56 <process_free>
   4462a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4462f:	e9 cd 00 00 00       	jmpq   44701 <process_fork+0x290>
   44634:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44638:	48 c1 e8 0c          	shr    $0xc,%rax
   4463c:	89 c2                	mov    %eax,%edx
   4463e:	48 63 c2             	movslq %edx,%rax
   44641:	0f b6 84 00 41 af 05 	movzbl 0x5af41(%rax,%rax,1),%eax
   44648:	00 
   44649:	83 c0 01             	add    $0x1,%eax
   4464c:	89 c1                	mov    %eax,%ecx
   4464e:	48 63 c2             	movslq %edx,%rax
   44651:	88 8c 00 41 af 05 00 	mov    %cl,0x5af41(%rax,%rax,1)
   44658:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4465f:	00 
   44660:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   44667:	00 
   44668:	0f 86 79 fe ff ff    	jbe    444e7 <process_fork+0x76>
   4466e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44672:	8b 08                	mov    (%rax),%ecx
   44674:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44677:	48 63 d0             	movslq %eax,%rdx
   4467a:	48 89 d0             	mov    %rdx,%rax
   4467d:	48 c1 e0 04          	shl    $0x4,%rax
   44681:	48 29 d0             	sub    %rdx,%rax
   44684:	48 c1 e0 04          	shl    $0x4,%rax
   44688:	48 8d b0 30 a0 05 00 	lea    0x5a030(%rax),%rsi
   4468f:	48 63 d1             	movslq %ecx,%rdx
   44692:	48 89 d0             	mov    %rdx,%rax
   44695:	48 c1 e0 04          	shl    $0x4,%rax
   44699:	48 29 d0             	sub    %rdx,%rax
   4469c:	48 c1 e0 04          	shl    $0x4,%rax
   446a0:	48 8d 90 30 a0 05 00 	lea    0x5a030(%rax),%rdx
   446a7:	48 8d 46 08          	lea    0x8(%rsi),%rax
   446ab:	48 83 c2 08          	add    $0x8,%rdx
   446af:	b9 18 00 00 00       	mov    $0x18,%ecx
   446b4:	48 89 c7             	mov    %rax,%rdi
   446b7:	48 89 d6             	mov    %rdx,%rsi
   446ba:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   446bd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   446c0:	48 63 d0             	movslq %eax,%rdx
   446c3:	48 89 d0             	mov    %rdx,%rax
   446c6:	48 c1 e0 04          	shl    $0x4,%rax
   446ca:	48 29 d0             	sub    %rdx,%rax
   446cd:	48 c1 e0 04          	shl    $0x4,%rax
   446d1:	48 05 38 a0 05 00    	add    $0x5a038,%rax
   446d7:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   446de:	8b 45 f4             	mov    -0xc(%rbp),%eax
   446e1:	48 63 d0             	movslq %eax,%rdx
   446e4:	48 89 d0             	mov    %rdx,%rax
   446e7:	48 c1 e0 04          	shl    $0x4,%rax
   446eb:	48 29 d0             	sub    %rdx,%rax
   446ee:	48 c1 e0 04          	shl    $0x4,%rax
   446f2:	48 05 f8 a0 05 00    	add    $0x5a0f8,%rax
   446f8:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   446fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44701:	c9                   	leaveq 
   44702:	c3                   	retq   

0000000000044703 <process_page_alloc>:
   44703:	55                   	push   %rbp
   44704:	48 89 e5             	mov    %rsp,%rbp
   44707:	48 83 ec 20          	sub    $0x20,%rsp
   4470b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4470f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44713:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   4471a:	00 
   4471b:	77 07                	ja     44724 <process_page_alloc+0x21>
   4471d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44722:	eb 4b                	jmp    4476f <process_page_alloc+0x6c>
   44724:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44728:	8b 00                	mov    (%rax),%eax
   4472a:	89 c7                	mov    %eax,%edi
   4472c:	e8 0c f5 ff ff       	callq  43c3d <palloc>
   44731:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44735:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4473a:	74 2e                	je     4476a <process_page_alloc+0x67>
   4473c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44740:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44744:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4474b:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   4474f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44755:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4475b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44760:	48 89 c7             	mov    %rax,%rdi
   44763:	e8 5f d6 ff ff       	callq  41dc7 <virtual_memory_map>
   44768:	eb 05                	jmp    4476f <process_page_alloc+0x6c>
   4476a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4476f:	c9                   	leaveq 
   44770:	c3                   	retq   
