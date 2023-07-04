	.text
	.file	"hello.c"
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
	movabsq	$.L.str, %rdi
	movb	$0, %al
	callq	printf
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\n hello"
	.size	.L.str, 8

	.ident	"clang version 14.0.1 (llvm-omnibor.git 7f56c2d1aa0242753f109f02b84c68190a48f2a8)"
	.section	.note.omnibor,"a",@note
	.long	8
	.long	20
	.long	1
	.ascii	"OMNIBOR"
	.zero	1
	.ascii	"Km\311>Q\241\267Po@\364\b'^\221\254\375\030\r,"
	.long	8
	.long	32
	.long	2
	.ascii	"OMNIBOR"
	.zero	1
	.ascii	"[\310\211iP\317\003\212<\225\223\261<b%{\242\350NN\210\005\221p\217NC\005\277\037\027\315"
	.section	.rodata.str1.1,"aMS",@progbits,1
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym printf
