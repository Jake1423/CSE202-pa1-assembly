.global sum
# pointer to list head in %rdi; result in %rax
# struct ll { char *name; long value; struct ll *next; }
#   offset 0  : name
#   offset 8  : value
#   offset 16 : next
sum:
    movq $0, %rax           #mov 0 into %rax. %rax is where it lives and the return value.
.Lloop:
    testq %rdi, %rdi        #checks if null
    je .Ldone               #if the value equal/zero jumps to lable .Ldone
    addq 8(%rdi), %rax      #adds value in rdi to value of rax and stores in rax, needed the 8 because a node is 24 bytes of memory and the value lives in offset 8
    movq 16(%rdi), %rdi     #moves to thte next ptr and again neds the 16 because next is in offset 16
    jmp .Lloop              #auto jumps to beginning loop
.Ldone:
    retq


# sum of the elements of a linkedlist in C
# long sum(struct ll *list){ - declares the function, long means whole number 8 bytes, and struct ll *list receives one input, so receives one input from the memory address of the first node and * is 'address of' .
#    long total = 0;
#    struct ll *ptr = list; - creates a variable named pt and set it to the same address as list. 
#    while(ptr){
#        total += ptr->value; - ptr->value is value fo the node ptr points to,so total = total plus value
#        ptr = ptr->next; - next field of the node 
#    }
#    return total;
# }

