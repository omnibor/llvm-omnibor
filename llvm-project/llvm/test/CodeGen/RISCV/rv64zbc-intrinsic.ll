; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-b -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64IB
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zbc -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64IBC

declare i64 @llvm.riscv.clmul.i64(i64 %a, i64 %b)

define i64 @clmul64(i64 %a, i64 %b) nounwind {
; RV64IB-LABEL: clmul64:
; RV64IB:       # %bb.0:
; RV64IB-NEXT:    clmul a0, a0, a1
; RV64IB-NEXT:    ret
;
; RV64IBC-LABEL: clmul64:
; RV64IBC:       # %bb.0:
; RV64IBC-NEXT:    clmul a0, a0, a1
; RV64IBC-NEXT:    ret
  %tmp = call i64 @llvm.riscv.clmul.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

declare i64 @llvm.riscv.clmulh.i64(i64 %a, i64 %b)

define i64 @clmul64h(i64 %a, i64 %b) nounwind {
; RV64IB-LABEL: clmul64h:
; RV64IB:       # %bb.0:
; RV64IB-NEXT:    clmulh a0, a0, a1
; RV64IB-NEXT:    ret
;
; RV64IBC-LABEL: clmul64h:
; RV64IBC:       # %bb.0:
; RV64IBC-NEXT:    clmulh a0, a0, a1
; RV64IBC-NEXT:    ret
  %tmp = call i64 @llvm.riscv.clmulh.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

declare i64 @llvm.riscv.clmulr.i64(i64 %a, i64 %b)

define i64 @clmul64r(i64 %a, i64 %b) nounwind {
; RV64IB-LABEL: clmul64r:
; RV64IB:       # %bb.0:
; RV64IB-NEXT:    clmulr a0, a0, a1
; RV64IB-NEXT:    ret
;
; RV64IBC-LABEL: clmul64r:
; RV64IBC:       # %bb.0:
; RV64IBC-NEXT:    clmulr a0, a0, a1
; RV64IBC-NEXT:    ret
  %tmp = call i64 @llvm.riscv.clmulr.i64(i64 %a, i64 %b)
 ret i64 %tmp
}