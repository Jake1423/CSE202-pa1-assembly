.global area
# a in %edi, b in %esi, c in %edx; result in %eax
area:
.global area
area:
  movl %edi, %eax          # p = a
  addl %esi, %eax          # p = p + b
  addl %edx, %eax          # p = p + c
  sarl $1, %eax            # p = p / 2
  movl %eax, %r8d          # prod = p
  movl %eax, %r9d          # t = p
  subl %edi, %r9d          # t = p - a
  imull %r9d, %r8d         # prod = prod * (p-a)
  movl %eax, %r9d          # t = p
  subl %esi, %r9d          # t = p - b
  imull %r9d, %r8d         # prod = prod * (p-b)
  movl %eax, %r9d          # t = p
  subl %edx, %r9d          # t = p - c
  imull %r9d, %r8d         # prod = prod * (p-c)
  movl %r8d, %edi          # arg for r_sqrt = prod
  call r_sqrt              # %eax = r_sqrt(prod)
  ret

r_sqrt:
  movl $-1, %eax           # result = -1
  cmpl $0, %edi            # compare x with 0
  jl .Lrs_ret              # x < 0 -> RET
  movl %edi, %eax          # result = x
  cmpl $2, %edi            # compare x with 2
  jl .Lrs_ret              # x < 2 -> RET
  pushq %rbx               # save caller's %rbx
  movl %edi, %ebx          # keep x in %ebx
  sarl $2, %edi            # x = x >> 2
  call r_sqrt              # result = r_sqrt(x/4)
  sall $1, %eax            # small = result << 1
  movl %eax, %ecx          # large = small
  incl %ecx                # large = large + 1
  movl %ecx, %edx          # sq = large
  imull %ecx, %edx         # sq = large * large
  cmpl %ebx, %edx          # compare sq with saved x (sq - x)
  jg .Lrs_pop              # sq > x -> POP (return small)
  movl %ecx, %eax          # result = large
.Lrs_pop:
  popq %rbx                # restore caller's %rbx
.Lrs_ret:
    retq

# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C)
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
