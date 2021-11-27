.global _start

.section .text
_start:
    movq root, %r8        # r8 = &A
    movq new_node, %rax   # rax = new_node->data

loop:
    movq (%r8), %r9       # r9 = A->data
    cmpq %rax, %r9        # 
    je end                # if A->data == new_node->data:    jump(end)
    jl right              # if A->data < new_node->data:     jump(right)

left:
    cmpq $0, 8(%r8)       # if A->left == 0:
    je put_left           #     jump(put_left)
    movq 8(%r8), %r8      # r8 = A->left
    jmp loop              # jump(loop)

put_left:
    leaq new_node, %rbx   # rbx = new_node
    movq %rbx, 8(%r8)     # A->left = new_node
    jmp end               # jump(end)

right:
    cmpq $0, 16(%r8)
    je put_right
    movq 16(%r8), %r8
    jmp loop

put_right:
    leaq new_node, %rbx
    movq %rbx, 16(%r8)
    jmp end

end:

    