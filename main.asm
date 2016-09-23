%include "io64.inc"

global CMAIN
global _isNotPowerOf2
global _fibonacci
section .data

section .text
CMAIN:
    mov rbp, rsp; for correct debugging
    mov rcx, 1111111111 ;change for 
    call _collatz
    mov rcx, rax
    call _putNbr
    xor rax, rax
    ret
    
_putNbr:
    PRINT_UDEC 8, rcx
    NEWLINE
    ret
    
_fibonacci:      ; non-recursive so to avoid duplicate calculations
    mov rdi, rcx
    test rdi, 1    ;TODO find a way to assemble both those tests
    jnz .rinit
    test rdi, rdi  ; test for 0 case
    jz .end
    xor rax, rax
    mov rcx, 1    ;using ecx because it is considered volitile
    jmp .loopFib
.rinit:           ;aligning to parity so to improve performance
    mov rcx, 1
    mov rax, 1
    sub rdi, 1    ; test for 1 case
    jz .end
.loopFib:
    add rax, rcx
    add rcx, rax
    sub rdi, 2    ; decrement by two to improve performance
    jnz .loopFib
.end:
    ret
    
_fibonacciPrint:      ; non-recursive so to avoid duplicate calculations
    mov rdi, rcx
    test rdi, 1    ;TODO find a way to assemble both those tests
    jnz .rinit
    test rdi, rdi  ; test for 0 case
    jz .end
    xor rax, rax
    mov rcx, 1    ;using ecx because it is considered volitile
    jmp .loopFib
.rinit:           ;aligning to parity so to improve performance
    mov rcx, 1
    mov rax, 1
    sub rdi, 1    ; test for 1 case
    jz .end
.loopFib:
    add rax, rcx
    
    push rcx
    mov rcx, rax
    call _putNbr
    pop rcx
    
    add rcx, rax
    
    call _putNbr
    
    sub rdi, 2
    jnz .loopFib
.end:
    ret
    
_factoial:
    mov rax, rcx
    test rax, rax
    jz .end
    dec rcx
.loop:
    mul rcx
    dec rcx
    jnz .loop
.end:
    ret
    
_collatz:
    xor rdi, rdi
    test rcx, rcx
    jz .end
    mov rax, rcx
    mov r8, 2
    mov r9, 3
    test rax, 1
    jnz .odd
.straight:
    shr rax, 1
    inc rdi
    cmp rax, 1
    jz .end
    test rax, 1
    jz .straight
.odd:
    mul r9
    inc rax
    inc rdi
    cmp rax, 1
    jz .end
    test rax, 1
    jz .straight
    jnz .odd
.end:
    mov rax, rdi
    ret
    
_isNotPowerOf2:
    mov rax, rcx
    sub rax, 1
    and rax, rcx
    ret
    
