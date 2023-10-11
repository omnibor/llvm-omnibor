// RUN: rm -rf %t && mkdir %t

// RUN: rm -f objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f
// RUN: env OMNIBOR_DIR= %clang -c -frecord-omnibor=%t %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n omnibor.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: ARTIFACT_ID=`git hash-object omnibor.o`
// RUN: cat %t/metadata/llvm/$ARTIFACT_ID | FileCheck --check-prefix=METADATA_CONTENTS %s

// RUN: %clang -c -frecord-omnibor=%t -o %t/omnibor_1.o %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n %t/omnibor_1.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: %clang -c -frecord-omnibor=%t/omnibordir -o %t/omnibor_2.o %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n %t/omnibor_2.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/omnibordir/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" %clang -c -frecord-omnibor=%t/omnibor_dir -o %t/omnibor_3.o %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n %t/omnibor_3.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: rm -f %t/env_omnibor_dir/objects/gitoid_blob_sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1
// RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" %clang -c -o %t/omnibor_4.o %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n %t/omnibor_4.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: rm -f %t/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f
// RUN: env OMNIBOR_DIR= %clang -c -frecord-omnibor=%t -o %t/omnibor_5.o %S/Inputs/omnibor.c -I%S/Inputs/omnibor.h
// RUN: llvm-readelf -n %t/omnibor_5.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/objects/gitoid_blob_sha1/0b/e9b91c3e456c910b32afc862ffd073b7c61d5f | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/objects/gitoid_blob_sha256/58/ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// BOM_NOTE_SECTION: Displaying notes found in: .note.omnibor
// BOM_NOTE_SECTION: Owner                Data size        Description
// BOM_NOTE_SECTION: OMNIBOR               0x00000014       NT_GITOID_SHA1
// BOM_NOTE_SECTION: SHA1 GitOID: 0be9b91c3e456c910b32afc862ffd073b7c61d5f
// BOM_NOTE_SECTION: OMNIBOR               0x00000020       NT_GITOID_SHA256
// BOM_NOTE_SECTION: SHA256 GitOID: 58ed318e337ad6260f471c086e9c9985543c5fbd507c3b44924f5af37bd0ea96

// BOM_FILE_SHA1_CONTENTS: gitoid:blob:sha1
// BOM_FILE_SHA1_CONTENTS: blob 078dc8b54dc17e60dfe9235ebe825cd810869c26
// BOM_FILE_SHA1_CONTENTS: blob c7184931bb3205d7eff290af1860fbed5f963fb5

// BOM_FILE_SHA256_CONTENTS: gitoid:blob:sha256
// BOM_FILE_SHA256_CONTENTS: blob 465be75836446b37f31c5db1f29a8689f37cd5625d4b30237877703fc1070f5e
// BOM_FILE_SHA256_CONTENTS: blob 8ad020236bd23736a75699ba4e83f52593d61c4c9f8d5932b57fce011f832bf8

// METADATA_CONTENTS: output: {{.*}} path: {{.*}}omnibor.o
// METADATA_CONTENTS_NEXT: input: {{.*}} path: {{.*}}/omnibor.c
// METADATA_CONTENTS_NEXT: input: {{.*}} path: {{.*}}/omnibor.h

