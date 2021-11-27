.global _start

.section .text
_start:
#your code here

    movq num, %rax
    movl $0, %ebx

loop:     

    cmp $0, %rax
    jz end
    movl %eax, %ecx
    and $1, %ecx
    add %ecx, %ebx
    shr $1, %rax
    jmp loop     
   
end: 

    movl %ebx, countBits       
    