// RUN: rm -rf %t && mkdir %t

// RUN: %clang -c -frecord-gitbom -o %t/gitbom_1.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -n %t/gitbom_1.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1 | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/.gitbom/objects/sha256/5a/b5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5  | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: %clang -c -frecord-gitbom=%t/gitbomdir -o %t/gitbom_2.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -n %t/gitbom_2.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/gitbomdir/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1 | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/.gitbom/objects/sha256/5a/b5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5  | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: env GITBOM_DIR="%t/env_gitbom_dir" %clang -c -frecord-gitbom=%t/gitbomdir -o %t/gitbom_3.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -n %t/gitbom_3.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/env_gitbom_dir/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1 | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/env_gitbom_dir/.gitbom/objects/sha256/5a/b5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5 | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: rm -f %t/env_gitbom_dir/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1
// RUN: env GITBOM_DIR="%t/env_gitbom_dir" %clang -c -o %t/gitbom_4.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -n %t/gitbom_4.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/env_gitbom_dir/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1 | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/.gitbom/objects/sha256/5a/b5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5  | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: rm -f %t/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1
// RUN: env GITBOM_DIR= %clang -c -frecord-gitbom -o %t/gitbom_5.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -n %t/gitbom_5.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat %t/.gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1 | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/.gitbom/objects/sha256/5a/b5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5  | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// RUN: rm -f .gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1
// RUN: env GITBOM_DIR= %clang -c -frecord-gitbom %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -n gitbom.o | FileCheck --check-prefix=BOM_NOTE_SECTION %s
// RUN: cat .gitbom/objects/sha1/63/87876e9c6f258ef88e7c81b9e1c41f14c397d1 | FileCheck --check-prefix=BOM_FILE_SHA1_CONTENTS %s
// RUN: cat %t/.gitbom/objects/sha256/5a/b5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5  | FileCheck --check-prefix=BOM_FILE_SHA256_CONTENTS %s

// BOM_NOTE_SECTION: Displaying notes found in: .note.gitbom
// BOM_NOTE_SECTION: Owner                Data size        Description
// BOM_NOTE_SECTION: GITBOM               0x00000014       NT_GITBOM (SHA1 GITOID)
// BOM_NOTE_SECTION: SHA1 GitOID: 6387876e9c6f258ef88e7c81b9e1c41f14c397d1
// BOM_NOTE_SECTION: GITBOM               0x00000020       NT_GITBOM (SHA256 GITOID)
// BOM_NOTE_SECTION: SHA256 GitOID: 5ab5f789e62eaeecb6125fc72e339cd9604538c889b041d239d2bbfbcd4e5fa5

// BOM_FILE_SHA1_CONTENTS: gitoid:blob:sha1
// BOM_FILE_SHA1_CONTENTS: blob 6e00bf3ad31d164ffc9a1a64a377857607a24085
// BOM_FILE_SHA1_CONTENTS: blob c7184931bb3205d7eff290af1860fbed5f963fb5

// BOM_FILE_SHA256_CONTENTS: gitoid:blob:sha256
// BOM_FILE_SHA256_CONTENTS: blob 465be75836446b37f31c5db1f29a8689f37cd5625d4b30237877703fc1070f5e
// BOM_FILE_SHA256_CONTENTS: blob faad3d96f255c24d72c7705c19ae95976295213bc0d910e2ea9dc6c4e2194e4b
