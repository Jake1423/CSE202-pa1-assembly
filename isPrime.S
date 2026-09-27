.global isPrime
# n in %edi; result in %eax (1 = prime, 0 = not prime)
isPrime:
  cmpl $2, %edi            # compare n with 2
  jl .Lip_notprime         # n < 2 -> NOTPRIME
  testl $1, %edi           # check last bit of n
  jne .Lip_loopstart       # n is odd -> LOOPSTART
  cmpl $2, %edi            # compare n with 2
  je .Lip_prime            # n == 2 -> PRIME
  jmp .Lip_notprime        # even and not 2 -> NOTPRIME
.Lip_loopstart:
  movl $3, %ecx            # i = 3
.Lip_top:
  movl %ecx, %r8d          # sq = i
  imull %ecx, %r8d         # sq = sq * i
  cmpl %edi, %r8d          # compare sq with n (sq - n)
  jg .Lip_prime            # sq > n -> PRIME
  movl %edi, %eax          # eax = n
  cltd                     # sign-extend eax into edx
  idivl %ecx               # divide by i, remainder in %edx
  testl %edx, %edx         # is remainder 0?
  je .Lip_notprime         # remainder == 0 -> NOTPRIME
  addl $2, %ecx            # i = i + 2
  jmp .Lip_top             # go to TOP
.Lip_prime:
  movl $1, %eax            # return 1 (prime)
  ret
.Lip_notprime:
  movl $0, %eax            # return 0 (not prime)
  ret


# int isPrime(int n){
#     if(n < 2)
#         return 0;
#     if(n % 2 == 0)
#         return n == 2;
#     /* only test odd divisors i while i*i <= n */
#     for(int i = 3; i * i <= n; i += 2){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }
