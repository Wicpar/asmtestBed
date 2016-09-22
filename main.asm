%include "io64.inc"

global CMAIN
global _isNotPowerOf2
global _fibonacci
section .data

section .text
CMAIN:
    mov rbp, rsp; for correct debugging
    mov rcx, 100
    call _fibonacciPrint
    xor rax, rax
    ret
    
_putNbr:
    PRINT_DEC 8, rcx
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
    sub rdi, 2
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
    
    push rax
    push rcx
    push rdi
    mov rcx, rax
    call _putNbr
    pop rdi
    pop rcx
    pop rax
    
    add rcx, rax
    
    push rax
    push rcx
    push rdi
    call _putNbr
    pop rdi
    pop rcx
    pop rax
    
    sub rdi, 2
    jnz .loopFib
.end:
    ret
    
_isNotPowerOf2:
    mov rax, rcx
    sub rax, 1
    and rax, rcx
    ret
    
