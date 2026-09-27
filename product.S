.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:
    movl $0, %r8d
.Lploop:
    cmp %ecx, %r8d
    jae .Lpdone
    movss (%rdi, %r8, 4), %xmm0
    mulss (%rsi, %r8, 4), %xmm0
    movss %xmm0, (%rdx, %r8, 4)
    incl %r8d
    jmp .Lploop
.Lpdone:
    ret

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
