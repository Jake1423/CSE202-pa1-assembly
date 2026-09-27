.global reverse
# list in %rdi (array of char*), n in %esi
reverse:
  movl $0, %ecx
  movl %esi, %r8d       # half = n
  shrl $1, %r8d         # half = half / 2
.Lrloop:
  cmpl %r8d, %ecx            # if i >= half
  jae .Lrdone                # go to end
  movl %esi, %r9d            # copies n into j
  subl %ecx, %r9d            # j = j - i
  decl %r9d                  # j = j - 1    
  movq (%rdi,%rcx,8), %r10   # temp  = list[i]   
  movq (%rdi,%r9,8), %r11    # temp2 = list[j]   
  movq %r11, (%rdi,%rcx,8)   # list[i] = temp2  
  movq %r10, (%rdi,%r9,8)    # list[j] = temp   
  incl %ecx                     # i = i + 1
  jmp .Lrloop                 # go to TOP
.Lrdone:
  retq


# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }
