.section .data
status: .long 0
result: .long 0

.section .text
.globl _start

_start:
    # Load address into %rcx
    mov %rdi, %rcx        

    # Load index into %eax
    mov %esi, %eax        

    # Load length into %ebx
    mov %edx, %ebx        

    # Compare index with length
    cmp %ebx, %eax        
    jae out_of_bounds   

    # Index is within bounds, set status to 1
    movl $1, status(%rip)    

    # Load base address into %rax
    mov %rcx, %rax        
    # Multiply index by 4 (size of each element)
    mov $4, %ecx          
    imul %ecx            
    # Add base address to get the address of the element
    add %rdi, %rax        

    # Load value at address into %eax
    mov (%rax), %eax      
    # Store value in result
    mov %eax, result(%rip)      

    jmp done            

out_of_bounds:
    # Index is out of bounds, set status to 0
    movl $0, status(%rip)    
    # Set result to 0 (optional, for safety)
    movl $0, result(%rip)      

done:
    # Exit the program
    mov $60, %rax             
    xor %rdi, %rdi            
    syscall
