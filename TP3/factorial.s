	.file	"factorial.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	DWORD PTR [rbp-20], edi
	cmp	DWORD PTR [rbp-20], 0
	jne	.L2
	mov	eax, 1
	jmp	.L3
.L2:
	mov	eax, DWORD PTR [rbp-20]
	sub	eax, 1
	mov	edi, eax
	call	factorial
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-20]
	sub	eax, 1
	mov	edi, eax
	call	factorial
	imul	eax, DWORD PTR [rbp-20]
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.ident	"GCC: (Debian 4.9.2-10+deb8u1) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
