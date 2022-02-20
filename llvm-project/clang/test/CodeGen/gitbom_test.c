// RUN: %clang -c -frecord-gitbom -MD -o %t.o %S/Inputs/gitbom.c -I%S/Inputs/gitbom.h
// RUN: llvm-readelf -p ".bom" %t.o | FileCheck --check-prefix=BOM_IDENTIFIER %s
// BOM_IDENTIFIER: [     0] 5016da29beed4d19143174ae53d5a69d5fa2afa4
