// RUN: rm -rf %t && mkdir %t

// RUN: %clang -c -frecord-gitbom -o %t/gitbom_1.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -p ".bom" %t/gitbom_1.o | FileCheck --check-prefix=BOM_IDENTIFIER %s
// RUN: cat %t/.gitbom/objects/50/16da29beed4d19143174ae53d5a69d5fa2afa4 | FileCheck --check-prefix=BOM_FILE_CONTENTS %s

// RUN: %clang -c -frecord-gitbom=%t/gitbomdir -o %t/gitbom_2.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: cat %t/gitbomdir/.gitbom/objects/50/16da29beed4d19143174ae53d5a69d5fa2afa4 | FileCheck --check-prefix=BOM_FILE_CONTENTS %s

// RUN: env LLVM_GITBOM_DIR="%t/env_gitbom_dir" %clang -c -frecord-gitbom=%t/gitbomdir -o %t/gitbom_3.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: cat %t/env_gitbom_dir/.gitbom/objects/50/16da29beed4d19143174ae53d5a69d5fa2afa4 | FileCheck --check-prefix=BOM_FILE_CONTENTS %s
// BOM_IDENTIFIER: [     0] P..)..M..1t.S..._...
// BOM_FILE_CONTENTS: blob 6e00bf3ad31d164ffc9a1a64a377857607a24085
// BOM_FILE_CONTENTS: blob c7184931bb3205d7eff290af1860fbed5f963fb5
