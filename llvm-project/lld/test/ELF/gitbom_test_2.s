# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/gitbom_add.s -o %t/gitbom_add.o
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/gitbom_main.s -o %t/gitbom_main.o
# RUN: ld.lld %t/gitbom_add.o %t/gitbom_main.o -e main --gitbom -o %t/gitbom_add.exe
# RUN: llvm-readelf -n %t/gitbom_add.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/.gitbom/objects/sha1/50/df005d1723744ae1a72c230ab5966249e60e73 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/.gitbom/objects/sha256/30/24033b51ef1520fc9c9caccb0e6a892cdb7c4f56c3569c5d703b4b7bd6e640 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob 51edef04a9699ecfd756dc6d2ae9e552a394d8b2 bom 6acc98b0749621cae7e199d06be49836d00b95ee
# BOM_FILE_SHA1: blob 64f63d5ad317e8b765b9d60e2da450d391965507 bom 26c9992d3b1f610d20accdf677eb53cf45b554d2

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob 302148db2b9cd7b35b8e1f61c8c0b198e21bb5353ecd01f8cb1d9814d6697e51 bom b0104b046077ffa030ceb715eedd60987fb34f5f5db4e109e8a35ed1f1f5e238
# BOM_FILE_SHA256: blob 8e1bc85a80973ac359ceb126d35864aeef2db5066dd16f5d5e269a0e78e71333 bom b52743df5edad0f12680e6c1172df98d5f12d8c91d0868a72e277e7441868c12

# BOM_NOTE_SECTION: Displaying notes found in: .note.gitbom
# BOM_NOTE_SECTION-NEXT: Owner                Data size        Description
# BOM_NOTE_SECTION-NEXT: 0x00000014       NT_GITBOM (SHA1 GITOID)
# BOM_NOTE_SECTION-NEXT: SHA1 GitOID: 50df005d1723744ae1a72c230ab5966249e60e73
# BOM_NOTE_SECTION-NEXT: 0x00000020       NT_GITBOM (SHA256 GITOID)
# BOM_NOTE_SECTION-NEXT: SHA256 GitOID: 3024033b51ef1520fc9c9caccb0e6a892cdb7c4f56c3569c5d703b4b7bd6e640
