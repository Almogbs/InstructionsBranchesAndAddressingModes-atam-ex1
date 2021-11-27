.global _start

.section .text
_start:
    movq a, %rax    
    movq b, %rbx
    cmpq %rbx, %rax
    jl swap

get_gcd:
    xorq %rdx, %rdx
    movq %rbx, %rcx
    divq %rbx
    movq %rcx, %rax
    movq %rdx, %rbx
    cmpq $0, %rbx
    jne get_gcd
    jmp end

swap: 
    movq %rax, %rcx
    movq %rbx, %rax
    movq %rcx, %rbx
    jmp get_gcd

end:
    movq %rax, %r8
    movq a, %rax  
    mulq b  
    divq %r8
    movq %rax, c
