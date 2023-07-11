# RUN: rm -rf %t && mkdir %t
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" llvm-mc -filetype=obj -triple=x86_64-linux-gnu %S/omnibor.s -o %t/omnibor-1.o
# RUN: llvm-readelf -n %t/omnibor-1.o | FileCheck --check-prefix=OMNIBOR-1 %s
# RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha1/70/a1f821592cc68919c7d2aebbad02c58dfb5d09 | FileCheck --check-prefix=OMNIBOR-SHA1-NOTE %s
# RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha256/1c/3b786338c344b1a094d7df2d6c2dbdbecc9eb3987004a173cd1c07dd108faf | FileCheck --check-prefix=OMNIBOR-SHA256-NOTE %s

# RUN: llvm-mc --omnibor-as=%t -filetype=obj -triple=x86_64-linux-gnu %S/omnibor.s -o %t/omnibor-2.o
# RUN: llvm-readelf -n %t/omnibor-2.o | FileCheck --check-prefix=OMNIBOR-1 %s
# RUN: cat %t/objects/gitoid_blob_sha1/70/a1f821592cc68919c7d2aebbad02c58dfb5d09 | FileCheck --check-prefix=OMNIBOR-SHA1-NOTE %s
# RUN: cat %t/objects/gitoid_blob_sha256/1c/3b786338c344b1a094d7df2d6c2dbdbecc9eb3987004a173cd1c07dd108faf | FileCheck --check-prefix=OMNIBOR-SHA256-NOTE %s

# RUN: rm -rf %t/env_omnibor_dir
# RUN: rm -rf %t/objects
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" llvm-mc --omnibor-as=%t -filetype=obj -triple=x86_64-linux-gnu %S/omnibor.s -o %t/omnibor-3.o
# RUN: llvm-readelf -n %t/omnibor-3.o | FileCheck --check-prefix=OMNIBOR-1 %s
# RUN: cat %t/objects/gitoid_blob_sha1/70/a1f821592cc68919c7d2aebbad02c58dfb5d09 | FileCheck --check-prefix=OMNIBOR-SHA1-NOTE %s
# RUN: cat %t/objects/gitoid_blob_sha256/1c/3b786338c344b1a094d7df2d6c2dbdbecc9eb3987004a173cd1c07dd108faf | FileCheck --check-prefix=OMNIBOR-SHA256-NOTE %s

# RUN: rm -rf %t/env_omnibor_dir
# RUN: rm -rf %t/objects
# RUN: llvm-mc -filetype=obj -triple=x86_64-linux-gnu %S/omnibor.s -o %t/omnibor.o
# RUN: llvm-readelf -n %t/omnibor.o | FileCheck --allow-empty --check-prefix=NO-OMNIBOR %s

# OMNIBOR-1: Displaying notes found in: .note.omnibor
# OMNIBOR-1-NEXT:  Owner                Data size        Description
# OMNIBOR-1-NEXT:  OMNIBOR              0x00000014       NT_GITOID_SHA1
# OMNIBOR-1-NEXT:  SHA1 GitOID: 70a1f821592cc68919c7d2aebbad02c58dfb5d09
# OMNIBOR-1-NEXT:  OMNIBOR              0x00000020       NT_GITOID_SHA256
# OMNIBOR-1-NEXT:  SHA256 GitOID: 1c3b786338c344b1a094d7df2d6c2dbdbecc9eb3987004a173cd1c07dd108faf

# NO-OMNIBOR-NOT: Displaying notes found in: .note.omnibor

# OMNIBOR-SHA1-NOTE: gitoid blob sha1
# OMNIBOR-SHA1-NOTE: blob 46d7cf5af3c8e0649943db9d6ed5b248a083285a bom 4b6dc93e51a1b7506f40f408275e91acfd180d2c

# OMNIBOR-SHA256-NOTE: gitoid blob sha256
# OMNIBOR-SHA256-NOTE: blob 46872ea9d85ac8c80f548a1718b3d2e37695f495099423f01430c20c26ba73ee bom 5bc8896950cf038a3c9593b13c62257ba2e84e4e880591708f4e4305bf1f17cd

# CHECK-OMNIBOR-2: Displaying notes found in: .note.omnibor
# CHECK-OMNIBOR-2-NEXT: Owner                Data size        Description
# CHECK-OMNIBOR-2-NEXT: OMNIBOR              0x00000014       NT_GITOID_SHA1
# CHECK-OMNIBOR-2-NEXT: SHA1 GitOID: e1c058d0ab49e12b2a0063be9b62efea9f2453c0
# CHECK-OMNIBOR-2-NEXT: OMNIBOR              0x00000020       NT_GITOID_SHA256
# CHECK-OMNIBOR-2-NEXT: SHA256 GitOID: cdae8735776aa8f7e20531f631dd73affbd992dfc7d464ec2586760edd071893
