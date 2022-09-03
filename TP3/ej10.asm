SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit
_start:
    mov eax,0
    cpuid
    mov [string], ebx
    mov [string+4],edx
    mov [string+8],ecx
    mov [string+12],0
    mov ebx,[string]
    call print
    call exit


SECTION .bss
string resb 16