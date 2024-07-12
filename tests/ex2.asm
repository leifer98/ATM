.global _start

.section .text
_start:
  xor %rax, %rax
  movq size(%rax), %r8    # Load size into r8
  lea data(%rax), %r9     # Load address of data into r9      # Load address of data into r9

check_type1:
  movq $0, %r11 # Initialize r11 to 0
  jmp first_loop
ascii_loop:
  incq %r11 # Increment r11
first_loop:
  cmpq %r8, %r11 # Compare r11 with r8 (size)
  jge type1 # Jump if r11 >= r8 ( i > size)
  movq %r9, %r12          # Load address of data into r12
  addq %r11, %r12         # Add r11 to r12 to get the correct byte address
  movzbq (%r12), %r13     # Load byte from data into r13b and zero-extend to 64 bits
  cmpq $0, %r13
  je type1 # Jump if byte is 0 (null terminator)
# Check for simple ASCII (letters, numbers, punctuation, spaces)
  cmpb $65, %r13b       # Compare %r13b with 65 (ASCII value of 'A')
  jl other0             # Jump to 'other0' if %r13b < 65
  cmpb $90, %r13b       # Compare %r13b with 90 (ASCII value of 'Z')
  jle ascii_loop        # Jump to ascii_loop if %r13b <= 90
other0:
  cmpb $97, %r13b       # Compare %r13b with 97 (ASCII value of 'a')
  jl other1             # Jump to 'other1' if %r13b < 97
  cmpb $122, %r13b      # Compare %r13b with 122 (ASCII value of 'z')
  jle ascii_loop        # Jump to ascii_loop if %r13b <= 122
other1:
  cmpb $48, %r13b       # Compare %r13b with 48 (ASCII value of '0')
  jl other2             # Jump to 'other2' if %r13b < 48
  cmpb $57, %r13b       # Compare %r13b with 57 (ASCII value of '9')
  jle ascii_loop        # Jump to ascii_loop if %r13b <= 57
other2:
  cmpb $44, %r13b       # Compare %r13b with 44 (ASCII value of ',')
  je ascii_loop         # Jump to ascii_loop if %r13b == 44
  cmpb $46, %r13b       # Compare %r13b with 46 (ASCII value of '.')
  je ascii_loop         # Jump to ascii_loop if %r13b == 46
  cmpb $63, %r13b       # Compare %r13b with 63 (ASCII value of '?')
  je ascii_loop         # Jump to ascii_loop if %r13b == 63
  cmpb $33, %r13b       # Compare %r13b with 33 (ASCII value of '!')
  je ascii_loop         # Jump to ascii_loop if %r13b == 33
  cmpb $32, %r13b       # Compare %r13b with 32 (ASCII value of ' ')
  je ascii_loop         # Jump to ascii_loop if %r13b == 32
  jmp ascii_loop_not1_first_loop # Unconditionally jump to ascii_loop_not1_first_loop

type1:
  movq $1, type(%rip)# Set type to 1
  jmp done

ascii_loop_not1:
  incq %r11 # Increment r11
ascii_loop_not1_first_loop:
  cmpq %r8, %r11 # Compare r11 with r8 (size)
  jge type2 # Jump if r11 >= r8 ( i > size)
  movq %r9, %r12          # Load address of data into r12
  addq %r11, %r12         # Add r11 to r12 to get the correct byte address
  movzbq (%r12), %r13     # Load byte from data into r13b and zero-extend to 64 bits
  cmpq $0, %r13
  je type2 # Jump if byte is 0 (null terminator)
  cmpb $32, %r13b # Compare %r13b with 65 (ASCII value of 'a')
  jl other3               # Jump to 'other' if %r13b < 65
  cmpb $126, %r13b        # Compare %r13b with 90 (ASCII value of 'z')
  jle ascii_loop_not1 # Jump to ascii_loop if %r13b <= 90
other3:
  jmp ascii_loop_not12

ascii_loop_not12:

type2:
  movq $2, type(%rip)# Set type to 2
  jmp done

ascii_done:

done:
  nop                     # No operation
  syscall                 # System call
