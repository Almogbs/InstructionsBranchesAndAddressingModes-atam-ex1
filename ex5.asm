.global _start

.section .text
_start:
    movq head, %rax     # rax = head
    leaq head, %r15     # r15 = head --> will contain the parent of rax
    movq src, %r8       # r8 = src
    movq dst, %r9       # r9 = dst

    cmpq %r8, %r9       # checks if dst == src
    je end

    cmpq $0, %rax       # checks if the list is empty
    je end

    xorq %r10, %r10     # r10 = 0 >> will store src's parent address
    xorq %r11, %r11     # r11 = 0 >> will store dst's parent address

loop: 
    cmpq %r8, (%rax)   # if rax == src: set src parent
    je set_src

    cmpq %r9, (%rax)   # if rax == dst: set dst parent
    je set_dst

loop_continue:
    cmpq $0, 8(%rax)   # keep looping while rax->next != NULL
    je swap_nodes      # otherwise, try swaping the nodes

    movq %rax, %r15    # update parent 
    movq 8(%rax), %rax # rax = rax->next
    jmp loop

set_src:    
    movq %r15, %r10
    jmp loop_continue

set_dst:
    cmpq $0, %r10      # checks if dst comes before dst
    je end

    movq %r15, %r11
    jmp loop_continue

swap_nodes:
    cmpq $0, %r11      # if dst wasn't in the list: exit
    je end
    cmpq $0, %r10      # if src wasn't in the list: exit
    je end

    movq $8, %rax
    xorq %rdx, %rdx
    leaq head, %rbx
    cmpq %rbx, %r10
    cmove (%rbx), %r12
    cmovne 8(%r10), %r12 # r12 = src
    cmovne %rax, %rdx
    addq %rdx, %r10
    movq 8(%r12), %r14 # r14 = src->next
    movq 8(%r11), %r13 # r13 = dst
    movq 8(%r13), %r15 # r15 = dst->next
    addq $8, %r11


    movq %r12, (%r11)  # dst_parent->next = src
    movq %r13, (%r10)  # src_parent->next = dst

    movq 8(%r12), %r14 # r14 = src->next
    movq 8(%r13), %r15 # r15 = dst->next

    movq %r15, 8(%r12) # src->next = dst->next
    movq %r14, 8(%r13) # dst->next = src->next

end:
    

