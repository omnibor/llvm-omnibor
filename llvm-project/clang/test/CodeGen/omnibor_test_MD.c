// RUN: rm -rf %t && mkdir %t
// RUN: %clang -c -frecord-omnibor=%t -MD -o %t/omnibor.o %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n %t/omnibor.o | FileCheck --check-prefix=BOM_NOTE %s
// RUN: cat %t/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s
// BOM_FILE_SHA1_CONTENTS: gitoid:blob:sha1
// BOM_FILE_SHA1_CONTENTS: blob 078dc8b54dc17e60dfe9235ebe825cd810869c26
// BOM_FILE_SHA1_CONTENTS: blob c7184931bb3205d7eff290af1860fbed5f963fb5

// BOM_FILE_SHA256_CONTENTS: gitoid:blob:sha256
// BOM_FILE_SHA256_CONTENTS: blob 465be75836446b37f31c5db1f29a8689f37cd5625d4b30237877703fc1070f5e
// BOM_FILE_SHA256_CONTENTS: blob 8ad020236bd23736a75699ba4e83f52593d61c4c9f8d5932b57fce011f832bf8

// BOM_NOTE: Displaying notes found in: .note.omnibor
// BOM_NOTE:   Owner                Data size        Description
// BOM_NOTE:   OMNIBOR               0x00000014       NT_GITOID_SHA1
// BOM_NOTE:   SHA1 GitOID: 0be9b91c3e456c910b32afc862ffd073b7c61d5f
// BOM_NOTE:   OMNIBOR               0x00000020       NT_GITOID_SHA256
// BOM_NOTE:   SHA256 GitOID: 58ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96
