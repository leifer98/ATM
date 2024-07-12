.global _start

.section .text
_start:
#your code here
# Adress, Index, length, Legal, num,


#I am setting the registers i intend to use to be zero
xor %rax, %rax
xor %rbx, %rbx
xor %rcx, %rcx
xor %rdx, %rdx


movq (Adress),%rax
movl (Index), %ebx
movl (length), %ecx

# Check array bounds 
cmpl %ebx,%ecx
jbe ILLEGAL  #if length is smaller or equal to size it's an illegal index

# Check overflow against size
leaq (%rax,%rcx,4), %rdx
cmpq %rax, %rdx
jb ILLEGAL


# Check overflow against Index
# leaq (%rax,%ebx,4), %rdx
# cmpq %rax, %rdx
# jb ILLEGAL

movq $0x1, Legal
movq (%rax,%rbx,4), %rdx
movq %rdx, num
jmp END

ILLEGAL:
movq $0x0, Legal


END:

