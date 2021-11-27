.global _start

.section .text
_start:
    movl num, %ecx
    cmpl $0, %ecx
    jl negative
    

loop:
    decl %ecx
    cmpl $-1, %ecx
    je end
    movb source(%ecx), %al
    movb %al, destination(%ecx)
    jmp loop

negative:
    movl num, %ebx
    movl %ebx, destination

end:
