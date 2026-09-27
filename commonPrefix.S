.global commonPrefix
# a in %rdi, b in %rsi; result (prefix length) in %eax
commonPrefix:
  movq $0, %rax
.Lcploop:
  movb (%rdi, %rax), %dl   #loads a[n] into %dl
  testb %dl, %dl
  je .Lcpdone
  cmpb (%rsi, %rax), %dl
  jne .Lcpdone
  incl %eax
  jmp .Lcploop
.Lcpdone:
  retq 


# length of the longest common prefix of two null-terminated strings
# int commonPrefix(char *a, char *b){ - declares function 4 byte whole number, two inputs a and b. each is a char * so it is the address of the first string
#     int n = 0; - creates variable n set it to 0
#     while(a[n] && a[n] == b[n]) - loops, a[n] is the character at position n in string a, and a[n] == b[n] this means the characters in position n in both strings are the same, 
#         n++; - if match add one
#     return n;
# }
