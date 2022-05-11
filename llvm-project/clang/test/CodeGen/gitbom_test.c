// RUN: rm -rf %t && mkdir %t
// RUN:  %clang -c -frecord-gitbom -o %t/gitbom.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -p ".bom" %t/gitbom.o | FileCheck --check-prefix=BOM_IDENTIFIER %s
// RUN: cat %t/.gitbom/object/50/16da29beed4d19143174ae53d5a69d5fa2afa4 | FileCheck --check-prefix=BOM_FILE_CONTENTS %s
// BOM_IDENTIFIER: [     0] P..)..M..1t.S..._...
// BOM_FILE_CONTENTS: blob 6e00bf3ad31d164ffc9a1a64a377857607a24085
// BOM_FILE_CONTENTS: blob c7184931bb3205d7eff290af1860fbed5f963fb5
