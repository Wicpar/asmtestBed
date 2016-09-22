%include "io64.inc"

global CMAIN
global _isNotPowerOf2
global _fibonacci
section .data

section .text
CMAIN:
    mov rbp, rsp; for correct debugging
    mov rdi, 100
.rep:
    mov rcx, rdi
    push rdi
    call _fibonacci
    PRINT_UDEC 8, rax
    NEWLINE
    pop rdi
    sub rdi, 1
    jnz .rep
    ret
    
_fibonacci:      ; non-recursive so to avoid duplicate calculations
    mov rdi, rcx
    test rdi, 1
    jnz .rinit
    test rdi, rdi
    jz .end
    xor rax, rax
    mov rcx, 1    ;using ecx because it is considered volitile
    jmp .loopFib
.rinit:           ;aligning to parity so to improve performance
    mov rcx, 1
    mov rax, 1
    sub rdi, 1
    jz .end
.loopFib:
    add rax, rcx
    add rcx, rax
    sub rdi, 2
    jnz .loopFib
.end:
    ret
    
_isNotPowerOf2:
    mov rax, rcx
    sub rax, 1
    and rax, rcx
    ret
    
