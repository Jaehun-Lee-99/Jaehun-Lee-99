	.file	"decomment.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Error: line %d: unterminated comment\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$1, -12(%rbp)
	movl	$1, -8(%rbp)
	jmp	.L2
.L22:
	cmpl	$10, -4(%rbp)
	jne	.L3
	addl	$1, -12(%rbp)
.L3:
	cmpl	$0, -24(%rbp)
	jne	.L4
	movl	-32(%rbp), %eax
	orl	-28(%rbp), %eax
	testl	%eax, %eax
	jne	.L4
	cmpl	$0, -20(%rbp)
	je	.L5
	cmpl	$42, -4(%rbp)
	je	.L5
	movl	$47, %edi
	call	putchar@PLT
.L5:
	cmpl	$47, -4(%rbp)
	je	.L6
	cmpl	$47, -4(%rbp)
	jg	.L7
	cmpl	$42, -4(%rbp)
	je	.L8
	cmpl	$42, -4(%rbp)
	jg	.L7
	cmpl	$34, -4(%rbp)
	je	.L9
	cmpl	$39, -4(%rbp)
	jne	.L7
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$1, -32(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L10
.L9:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$1, -28(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L10
.L6:
	movl	$1, -20(%rbp)
	jmp	.L10
.L8:
	cmpl	$0, -20(%rbp)
	je	.L11
	movl	$1, -24(%rbp)
	movl	$32, %edi
	call	putchar@PLT
	movl	$0, -20(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L10
.L11:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$0, -20(%rbp)
	jmp	.L10
.L7:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$0, -20(%rbp)
.L10:
	jmp	.L2
.L4:
	cmpl	$0, -24(%rbp)
	jne	.L13
	cmpl	$1, -32(%rbp)
	jne	.L13
	cmpl	$39, -4(%rbp)
	jne	.L14
	movl	$0, -32(%rbp)
.L14:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	jmp	.L2
.L13:
	cmpl	$0, -24(%rbp)
	jne	.L15
	cmpl	$1, -28(%rbp)
	jne	.L15
	cmpl	$34, -4(%rbp)
	jne	.L16
	movl	$0, -28(%rbp)
.L16:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	jmp	.L2
.L15:
	cmpl	$0, -24(%rbp)
	je	.L26
	cmpl	$10, -4(%rbp)
	jne	.L17
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
.L17:
	cmpl	$42, -4(%rbp)
	je	.L18
	cmpl	$47, -4(%rbp)
	je	.L19
	jmp	.L25
.L18:
	movl	$1, -16(%rbp)
	jmp	.L2
.L19:
	cmpl	$0, -16(%rbp)
	je	.L2
	movl	$0, -24(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L2
.L25:
	movl	$0, -16(%rbp)
	jmp	.L2
.L26:
	nop
.L2:
	call	getchar@PLT
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L22
	cmpl	$1, -24(%rbp)
	jne	.L23
	movq	stderr(%rip), %rax
	movl	-8(%rbp), %edx
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L24
.L23:
	movl	$0, %eax
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
