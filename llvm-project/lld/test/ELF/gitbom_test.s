# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/gitbom.s -o %t/gitbom.o
# RUN: ld.lld %t/gitbom.o -e main --gitbom -o %t/gitbom.exe
# RUN: llvm-readelf -n %t/gitbom.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/.gitbom/objects/sha1/bc/a230349455c4cafea9c32d56301124f15d5afd | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/.gitbom/objects/sha256/3e/b368a5cf5e057b1a57c72e9deacfb887d4b0f992350f463809ada1707d33b8 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: ld.lld %t/gitbom.o -e main --gitbom=%t/gitbom_dir -o %t/gitbom_1.exe
# RUN: llvm-readelf -n %t/gitbom_1.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/.gitbom/objects/sha1/bc/a230349455c4cafea9c32d56301124f15d5afd | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/.gitbom/objects/sha256/3e/b368a5cf5e057b1a57c72e9deacfb887d4b0f992350f463809ada1707d33b8 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: env GITBOM_DIR="%t/env_gitbom_dir" ld.lld %t/gitbom.o -e main --gitbom=%t/gitbom_dir -o %t/gitbom_2.exe
# RUN: llvm-readelf -n %t/gitbom_2.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/.gitbom/objects/sha1/bc/a230349455c4cafea9c32d56301124f15d5afd | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/.gitbom/objects/sha256/3e/b368a5cf5e057b1a57c72e9deacfb887d4b0f992350f463809ada1707d33b8 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -f %t/env_gitbom_dir/.gitbom/objects/05/ec1279f15fa8c76bab1645e5f2b2d1ba39c10a
# RUN: env GITBOM_DIR="%t/env_gitbom_dir" ld.lld %t/gitbom.o -e main -o %t/gitbom_3.exe
# RUN: llvm-readelf -n %t/gitbom_3.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/.gitbom/objects/sha1/bc/a230349455c4cafea9c32d56301124f15d5afd | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/.gitbom/objects/sha256/3e/b368a5cf5e057b1a57c72e9deacfb887d4b0f992350f463809ada1707d33b8 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: env GITBOM_DIR= ld.lld %t/gitbom.o -e main --gitbom -o gitbom_4.exe
# RUN: llvm-readelf -n gitbom_4.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/.gitbom/objects/sha1/bc/a230349455c4cafea9c32d56301124f15d5afd | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/.gitbom/objects/sha256/3e/b368a5cf5e057b1a57c72e9deacfb887d4b0f992350f463809ada1707d33b8 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob fcf3d50ce24566dae9f0ba6ff409fa77c69cc90b bom 432a5d88c4eb39bb994d57eb6252864b793f5204

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob a8b548f4bce8b6b72da447c12895c9b36c39cca591e0b2cdde592be4fb7e729e bom 7dccbc2f068cf761234df1c5c01b80a574c0c3b0d00accf19634b5488bfdb9e4

# BOM_NOTE_SECTION: Displaying notes found in: .note.gitbom
# BOM_NOTE_SECTION-NEXT: Owner                Data size        Description
# BOM_NOTE_SECTION-NEXT: 0x00000014       NT_GITBOM (SHA1 GITOID)
# BOM_NOTE_SECTION-NEXT: SHA1 GitOID: bca230349455c4cafea9c32d56301124f15d5afd
# BOM_NOTE_SECTION-NEXT: 0x00000020       NT_GITBOM (SHA256 GITOID)
# BOM_NOTE_SECTION-NEXT: SHA256 GitOID: 3eb368a5cf5e057b1a57c72e9deacfb887d4b0f992350f463809ada1707d33b8
