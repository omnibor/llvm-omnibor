	.text
	.file	"gitbom.c"
	.globl	add                             # -- Begin function add
	.p2align	4, 0x90
	.type	add,@function
add:                                    # @add
	.cfi_startproc
# %bb.0:
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
	.ident	"clang version 14.0.1 (git@github.com:git-bom/llvm-gitbom.git 9ba9ecef3e21d8da274e1d49324c137d0ad51a49)"
	.section	.note.gitbom,"M",@note,1
	.long	7
	.long	20
	.long	1
	.ascii	"GITBOM"
	.zero	2
	.ascii	"j\314\230\260t\226!\312\347\341\231\320k\344\2306\320\013\225\356"
	.long	7
	.long	32
	.long	2
	.ascii	"GITBOM"
	.zero	2
	.ascii	"\265'C\337^\332\320\361&\200\346\301\027-\371\215_\022\330\311\035\bh\247.'~tA\206\214\022"
	.text
	.section	".note.GNU-stack","",@progbits
	.addrsig
