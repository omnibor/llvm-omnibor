	.text
	.file	"useadd.c"
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
	movl	$3, %esi
	movl	%esi, %edi
	callq	add
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 14.0.1 (https://github.com/omnibor/llvm-omnibor.git 53fc4b237f97aab8100a8d733a6b99e6869b5adc)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym add
