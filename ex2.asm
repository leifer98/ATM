.section .data
classification: .quad 0
size: .quad 0
data: .space 128

.section .text
.globl _start

_start:
    # Read the size (8 bytes) into %rax
    mov %rdi, %rax        

    # Compare size with 126 to check for Type 2
    mov $126, %rbx
    cmp %rbx, %rax
    jne check_quad

    # Check for null terminator at the end of Type 2
    mov data + 126, %rbx
    cmpb $0, (%rbx)
    jne check_quad
    mov $2, classification(%rip) # Type 2
    jmp done

check_quad:
    # Check if size is a multiple of 8 for Type 3
    mov $8, %rbx
    mov %rax, %rdx
    div %rbx
    test %rdx, %rdx
    jne check_ascii

    # Check if the last byte is not null terminator for Type 3
    mov data(%rax), %rbx
    cmpb $0, (%rbx)
    je check_ascii
    mov $3, classification(%rip) # Type 3
    jmp done

check_ascii:
    # Check if data is valid ASCII and ends with null terminator for Type 1
    mov $0, %rbx
ascii_loop:
    cmp %rbx, %rax
    jge ascii_done
    mov data(%rbx), %rcx
    cmpb $0, %rcx
    je ascii_done
    inc %rbx
    jmp ascii_loop
ascii_done:
    cmp %rbx, %rax
    jne other
    mov $1, classification(%rip) # Type 1
    jmp done

other:
    # If none of the conditions match, classify as Type 4
    mov $4, classification(%rip)

done:
    # The exit code will be handled by the test framework
    nop
