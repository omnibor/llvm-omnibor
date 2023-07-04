# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj --omnibor-as=%t -triple=x86_64-pc-linux %S/Inputs/omnibor_add.s -o %t/omnibor_add.o
# RUN: llvm-mc -filetype=obj --omnibor-as=%t -triple=x86_64-pc-linux %S/Inputs/omnibor_main.s -o %t/omnibor_main.o
# RUN: ld.lld %t/omnibor_add.o %t/omnibor_main.o -e main --omnibor -o %t/omnibor_add.exe
# RUN: llvm-readelf -n %t/omnibor_add.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/objects/gitoid_blob_sha1/c0/951112087ba0a488720ac70fff24f6312133e3 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/objects/gitoid_blob_sha256/69/dd44e518950a04e5a64fd21922b7ba88294d1d80cc90808ef75e0dee7dd261 | FileCheck --check-prefix=BOM_FILE_SHA256 %s
# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob 980f5ba708b17f52a1273defc116409194ad6c04 bom 5efa5bb8d8d368521ea95bd2dd84a862f68cbc1c
# BOM_FILE_SHA1: blob dd1bf717b9dfa1655c1a9724233644d07e369b4d bom 264d9eeb1db1be9cc93b76420e71516d69d25ff1

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob 39adae03571b754e376141f3ea08ac978f71420a6f9958eb80eec40dfadd6317 bom 217959aa06f15a4d6781d7902ae52cd1fdbb20ee5b8907f293d2aceaf2f8aad2
# BOM_FILE_SHA256: blob 3ab2db3ff215c286c5546cbedea5bbd26c9cf5a10562eec2dc016d25de71cb9c bom db0170e1d04301f33163c7974f5f27b5ab248c987f9bbf7f0b1562c1e3c54db8

# BOM_NOTE_SECTION: Displaying notes found in: .note.omnibor
# BOM_NOTE_SECTION-NEXT: Owner                Data size        Description
# BOM_NOTE_SECTION-NEXT: 0x00000014       NT_GITOID_SHA1
# BOM_NOTE_SECTION-NEXT: SHA1 GitOID: c0951112087ba0a488720ac70fff24f6312133e3
# BOM_NOTE_SECTION-NEXT: 0x00000020       NT_GITOID_SHA256
# BOM_NOTE_SECTION-NEXT: SHA256 GitOID: 69dd44e518950a04e5a64fd21922b7ba88294d1d80cc90808ef75e0dee7dd261
