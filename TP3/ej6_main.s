	.file	"ej6_main.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 200
	lea	rdx, [rbp-160]
	mov	eax, 0
	mov	ecx, 10
	mov	rdi, rdx
	rep stosq
	mov	DWORD PTR [rbp-200], 55
	lea	rdx, [rbp-320]
	mov	eax, 0
	mov	ecx, 10
	mov	rdi, rdx
	rep stosq
	mov	DWORD PTR [rbp-280], 66
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.local	arr6.2205
	.comm	arr6.2205,80,64
	.local	arr5.2204
	.comm	arr5.2204,80,64
	.ident	"GCC: (Debian 4.9.2-10+deb8u1) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
