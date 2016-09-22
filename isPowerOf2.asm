global _isPowerOf2

section .text
_isPowerOf2:
    mov rax, rcx
    sub rax, 1
    and rax, rcx
    ret