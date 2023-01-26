# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/omnibor.s -o %t/omnibor.o
# RUN: ld.lld %t/omnibor.o -e main --omnibor -o %t/omnibor.exe
# RUN: llvm-readelf -n %t/omnibor.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/objects/sha1/3f/f57d57064dff16633a6e3acaaa08195b9073d5 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/objects/sha256/b3/949098052e5a6f9e43630ff1021970518ff78b4a6e983cc6602a8f1656a6c0 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -rf %t/objects
# RUN: ld.lld %t/omnibor.o -e main --omnibor=%t/omnibor_dir -o %t/omnibor_1.exe
# RUN: llvm-readelf -n %t/omnibor_1.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/omnibor_dir/objects/sha1/3f/f57d57064dff16633a6e3acaaa08195b9073d5 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/omnibor_dir/objects/sha256/b3/949098052e5a6f9e43630ff1021970518ff78b4a6e983cc6602a8f1656a6c0 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -rf %t/env_omnibor_dir/objects
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" ld.lld %t/omnibor.o -e main --omnibor=%t/omnibor_dir -o %t/omnibor_2.exe
# RUN: llvm-readelf -n %t/omnibor_2.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/env_omnibor_dir/objects/sha1/3f/f57d57064dff16633a6e3acaaa08195b9073d5 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/env_omnibor_dir/objects/sha256/b3/949098052e5a6f9e43630ff1021970518ff78b4a6e983cc6602a8f1656a6c0 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -rf %t/env_omnibor_dir/objects/
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" ld.lld %t/omnibor.o -e main -o %t/omnibor_3.exe
# RUN: llvm-readelf -n %t/omnibor_3.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/env_omnibor_dir/objects/sha1/3f/f57d57064dff16633a6e3acaaa08195b9073d5 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/env_omnibor_dir/objects/sha256/b3/949098052e5a6f9e43630ff1021970518ff78b4a6e983cc6602a8f1656a6c0 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob 6d0c1c525b24d874364f03928e77467d9ed1f2bb bom 432a5d88c4eb39bb994d57eb6252864b793f5204

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob e6b4258ddf91915260729639bf91d9a5664c1152fc400ce5916ed2c19b9258ef bom 7dccbc2f068cf761234df1c5c01b80a574c0c3b0d00accf19634b5488bfdb9e4

# BOM_NOTE_SECTION: Displaying notes found in: .note.omnibor
# BOM_NOTE_SECTION-NEXT: Owner                Data size        Description
# BOM_NOTE_SECTION-NEXT: 0x00000014       NT_GITOID_SHA1
# BOM_NOTE_SECTION-NEXT: SHA1 GitOID: 3ff57d57064dff16633a6e3acaaa08195b9073d5
# BOM_NOTE_SECTION-NEXT: 0x00000020       NT_GITOID_SHA256
# BOM_NOTE_SECTION-NEXT: SHA256 GitOID: b3949098052e5a6f9e43630ff1021970518ff78b4a6e983cc6602a8f1656a6c0
