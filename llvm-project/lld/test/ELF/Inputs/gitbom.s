	.text
	.file	"gitbom.c"
	.globl	add                             # -- Begin function add
	.p2align	4, 0x90
	.type	add,@function
add:                                    # @add
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	addl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	add, .Lfunc_end0-add
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$2, %edi
	movl	$4, %esi
	callq	add
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 14.0.1 (git@github.com:bharsesh/llvm-gitbom.git d31061b1518508395d46882f10da5b7bce7ed191)"
	.section	.note.gitbom,"M",@note,1
	.long	7
	.long	20
	.long	1
	.ascii	"GITBOM"
	.zero	2
	.ascii	"C*]\210\304\3539\273\231MW\353bR\206Ky?R\004"
	.long	7
	.long	32
	.long	2
	.ascii	"GITBOM"
	.zero	2
	.ascii	"}\314\274/\006\214\367a#M\361\305\300\033\200\245t\300\303\260\320\n\314\361\2264\265H\213\375\271\344"
	.text
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym add
