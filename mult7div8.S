.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:
  movsbl %dil, %eax        # a32 = a, sign-extended to 32 bits
  movl %eax, %ecx          # mult = a32
  sall $3, %ecx            # mult = mult * 8
  subl %eax, %ecx          # mult = mult - a32  (now 7a)
  movsbl %cl, %ecx         # truncate mult to 8 bits (char)
  movb $0, (%rsi)          # *overflow = 0
  testl %eax, %eax         # is a32 == 0?
  je .Lm_divide            # yes -> DIVIDE
  testl %ecx, %ecx         # is mult == 0?
  je .Lm_divide            # yes -> DIVIDE
  movl %eax, %edx          # t = a32
  xorl %ecx, %edx          # t = a32 XOR mult
  jns .Lm_divide           # same sign -> DIVIDE (no overflow)
  movb $1, (%rsi)          # *overflow = 1
.Lm_divide:
  movl %ecx, %eax          # result = mult
  testl %eax, %eax         # is result negative?
  jns .Lm_shift            # not negative -> SHIFT
  addl $7, %eax            # add bias for negative numbers
.Lm_shift:
  sarl $3, %eax            # result = result / 8
  ret


# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
