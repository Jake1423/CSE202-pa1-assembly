.global gcd
# a in %edi, b in %esi; result in %eax
gcd:
  movl %edi, %eax          # eax = a
  testl %esi, %esi         # is b == 0?
  je .Lgcd_done            # b == 0 -> DONE (return a)
  cltd                     # sign-extend eax into edx
  idivl %esi               # divide a by b, remainder in %edx
  movl %esi, %edi          # new a = b
  movl %edx, %esi          # new b = remainder
  call gcd                 # recursive call, result in %eax
  .Lgcd_done:
  retq                      # return %eax


# greatest common divisor via Euclid's algorithm (recursive)
# int gcd(int a, int b){
#     if(b == 0)
#         return a;
#     /* recursive call */
#     return gcd(b, a % b);
# }