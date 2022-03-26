# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/gitbom.s -o %t/gitbom.o
# RUN: ld.lld %t/gitbom.o -e main --gitbom -o %t/gitbom.exe
# RUN: llvm-readobj -p ".bom" %t/gitbom.exe | FileCheck --check-prefix=GITBOM %s
# RUN: cat %t/.gitbom/object/c3/c5ce3656b2529dec7006a302bdfee02c1f0e2c | FileCheck --check-prefix=BOM_FILE %s
# GITBOM: File: {{.*}}
# GITBOM-NEXT: Format: elf64-x86-64
# GITBOM-NEXT: Arch: x86_64
# GITBOM-NEXT: AddressSize: 64bit
# GITBOM-NEXT: LoadName: <Not found>
# GITBOM-NEXT: String dump of section '.bom':
# GITBOM-NEXT: [     0] ...6V.R..p......,..,
# BOM_FILE: blob aaee289ee5320b56336f104e712ea31ad7a64c35 bom 0ad7f6246356227eb76fe0d8ab59f23dffbe9969
