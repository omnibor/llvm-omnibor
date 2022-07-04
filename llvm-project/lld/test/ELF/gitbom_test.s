# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/gitbom.s -o %t/gitbom.o
# RUN: ld.lld %t/gitbom.o -e main --gitbom -o %t/gitbom.exe
# RUN: llvm-readobj -p ".bom" %t/gitbom.exe | FileCheck --check-prefix=GITBOM %s
# RUN: cat %t/.gitbom/objects/05/ec1279f15fa8c76bab1645e5f2b2d1ba39c10a | FileCheck --check-prefix=BOM_FILE %s

# RUN: ld.lld %t/gitbom.o -e main --gitbom=%t/gitbom_dir -o %t/gitbom.exe
# RUN: cat %t/gitbom_dir/.gitbom/objects/05/ec1279f15fa8c76bab1645e5f2b2d1ba39c10a | FileCheck --check-prefix=BOM_FILE %s

# RUN: env LLVM_GITBOM_DIR="%t/env_gitbom_dir" ld.lld %t/gitbom.o -e main --gitbom=%t/gitbom_dir -o %t/gitbom.exe
# RUN: cat %t/env_gitbom_dir/.gitbom/objects/05/ec1279f15fa8c76bab1645e5f2b2d1ba39c10a | FileCheck --check-prefix=BOM_FILE %s

# GITBOM: File: {{.*}}
# GITBOM-NEXT: Format: elf64-x86-64
# GITBOM-NEXT: Arch: x86_64
# GITBOM-NEXT: AddressSize: 64bit
# GITBOM-NEXT: LoadName: <Not found>
# GITBOM-NEXT: String dump of section '.bom':
# GITBOM-NEXT: [     0] ...y._..k..E.....9..
# BOM_FILE: blob 39c8f91f169b231dae3c0e0b18dcf102cf7ada3e bom 0ad7f6246356227eb76fe0d8ab59f23dffbe9969
