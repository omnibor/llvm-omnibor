# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/omnibor_add.s -o %t/omnibor_add.o
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/omnibor_main.s -o %t/omnibor_main.o
# RUN: ld.lld %t/omnibor_add.o %t/omnibor_main.o -e main --omnibor -o %t/omnibor_add.exe
# RUN: llvm-readelf -n %t/omnibor_add.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/objects/sha1/7b/5cc942363892974b8089c3fb1cc92a1f807ba1 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/objects/sha256/17/42972fe1ab0fe742635cd6bb9c06ef3a8f7102b7e1f9c0eaaa70bb09684a4a | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob 6d1df76ef597632db1f2547700f85fb4594dcf52 bom 6acc98b0749621cae7e199d06be49836d00b95ee
# BOM_FILE_SHA1: blob 94c40262747e3093f3804587dd87a10584c0e56b bom 26c9992d3b1f610d20accdf677eb53cf45b554d2

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob 32350816f9208b80c71b3afc9282f22a7796e1be6c91adb2d1672cbe0c0bd735 bom b0104b046077ffa030ceb715eedd60987fb34f5f5db4e109e8a35ed1f1f5e238
# BOM_FILE_SHA256: blob c0ddd5ecc9a502502f25dab24b213efcf50f7eb0c6ba22b69fb10162499e70a4 bom b52743df5edad0f12680e6c1172df98d5f12d8c91d0868a72e277e7441868c12

# BOM_NOTE_SECTION: Displaying notes found in: .note.omnibor
# BOM_NOTE_SECTION-NEXT: Owner                Data size        Description
# BOM_NOTE_SECTION-NEXT: 0x00000014       NT_OMNIBOR (SHA1 GITOID)
# BOM_NOTE_SECTION-NEXT: SHA1 GitOID: 7b5cc942363892974b8089c3fb1cc92a1f807ba1
# BOM_NOTE_SECTION-NEXT: 0x00000020       NT_OMNIBOR (SHA256 GITOID)
# BOM_NOTE_SECTION-NEXT: SHA256 GitOID: 1742972fe1ab0fe742635cd6bb9c06ef3a8f7102b7e1f9c0eaaa70bb09684a4a
