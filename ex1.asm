section .text
global _start

_start:
    ; Load address into rcx
    mov rcx, rdi        

    ; Load index into eax
    mov eax, esi        

    ; Load length into ebx
    mov ebx, edx        

    ; Compare index with length
    cmp eax, ebx        
    jae out_of_bounds   

    ; Index is within bounds, set legal to 1
    mov dword [legal], 1    

    ; Load base address into rax
    mov rax, rcx        
    ; Multiply index by 4 (size of each element)
    mov ecx, 4          
    imul ecx            
    ; Add base address to get the address of the element
    add rax, rdi        

    ; Load value at address into eax
    mov eax, [rax]      
    ; Store value in num
    mov [num], eax      

    jmp done            

out_of_bounds:
    ; Index is out of bounds, set legal to 0
    mov dword [legal], 0    
    ; Set num to 0 (optional, for safety)
    mov dword [num], 0      

done:
    ; Exit the program
    mov rax, 60             
    xor rdi, rdi            
    syscall

section .bss
legal resd 1
num resd 1
