	.text
	.file	"omnibor_main.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$2, %edi
	movl	$10, %esi
	callq	add
	movl	%eax, -8(%rbp)
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 14.0.1 (git@github.com:git-bom/llvm-omnibor.git 9ba9ecef3e21d8da274e1d49324c137d0ad51a49)"
	.section	.note.omnibor,"M",@note,1
	.long	8
	.long	20
	.long	1
	.ascii	"OMNIBOR"
	.zero	1
	.ascii	"&\311\231-;\037a\r \254\315\366w\353S\317E\265T\322"
	.long	8
	.long	32
	.long	2
	.ascii	"OMNIBOR"
	.zero	1
	.ascii	"\260\020K\004`w\377\2400\316\267\025\356\335`\230\177\263O_]\264\341\t\350\243^\321\361\365\3428"
	.text
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym add
