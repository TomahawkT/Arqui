	.file	"fibonacci.c"
	.intel_syntax noprefix
	.text
	.globl	fibonacci
	.type	fibonacci, @function
fibonacci:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 24
	.cfi_offset 3, -24
	mov	DWORD PTR [rbp-20], edi
	cmp	DWORD PTR [rbp-20], 0
	jne	.L2
	mov	eax, 0
	jmp	.L3
.L2:
	cmp	DWORD PTR [rbp-20], 1
	jne	.L4
	mov	eax, 1
	jmp	.L3
.L4:
	mov	eax, DWORD PTR [rbp-20]
	sub	eax, 1
	mov	edi, eax
	call	fibonacci
	mov	ebx, eax
	mov	eax, DWORD PTR [rbp-20]
	sub	eax, 2
	mov	edi, eax
	call	fibonacci
	add	eax, ebx
.L3:
	add	rsp, 24
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	fibonacci, .-fibonacci
	.section	.rodata
.LC0:
	.string	"Fibonacci de %d: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR [rbp-4], 3
	mov	eax, DWORD PTR [rbp-4]
	mov	edi, eax
	call	fibonacci
	mov	edx, eax
	mov	eax, DWORD PTR [rbp-4]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10+deb8u1) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
