# RUN: rm -rf %t && mkdir %t
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" llvm-mc -filetype=obj -triple=x86_64-linux-gnu %S/Inputs/no-omnibor.s -o %t/no-omnibor-1.o
# RUN: llvm-readelf -n %t/no-omnibor-1.o | FileCheck --check-prefix=OMNIBOR-1 %s
# RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha1/e1/c058d0ab49e12b2a0063be9b62efea9f2453c0 | FileCheck --check-prefix=OMNIBOR-SHA1-NOTE %s
# RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha256/cd/ae8735776aa8f7e20531f631dd73affbd992dfc7d464ec2586760edd071893 | FileCheck --check-prefix=OMNIBOR-SHA256-NOTE %s

# RUN: llvm-mc --omnibor-as=%t -filetype=obj -triple=x86_64-linux-gnu %S/Inputs/no-omnibor.s -o %t/no-omnibor-2.o
# RUN: llvm-readelf -n %t/no-omnibor-2.o | FileCheck --check-prefix=OMNIBOR-1 %s
# RUN: cat %t/objects/gitoid_blob_sha1/e1/c058d0ab49e12b2a0063be9b62efea9f2453c0 | FileCheck --check-prefix=OMNIBOR-SHA1-NOTE %s
# RUN: cat %t/objects/gitoid_blob_sha256/cd/ae8735776aa8f7e20531f631dd73affbd992dfc7d464ec2586760edd071893 | FileCheck --check-prefix=OMNIBOR-SHA256-NOTE %s

# RUN: rm -rf %t/env_omnibor_dir
# RUN: rm -rf %t/objects
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" llvm-mc --omnibor-as=%t -filetype=obj -triple=x86_64-linux-gnu %S/Inputs/no-omnibor.s -o %t/no-omnibor-3.o
# RUN: llvm-readelf -n %t/no-omnibor-3.o | FileCheck --check-prefix=OMNIBOR-1 %s
# RUN: cat %t/objects/gitoid_blob_sha1/e1/c058d0ab49e12b2a0063be9b62efea9f2453c0 | FileCheck --check-prefix=OMNIBOR-SHA1-NOTE %s
# RUN: cat %t/objects/gitoid_blob_sha256/cd/ae8735776aa8f7e20531f631dd73affbd992dfc7d464ec2586760edd071893 | FileCheck --check-prefix=OMNIBOR-SHA256-NOTE %s

# OMNIBOR-1: Displaying notes found in: .note.omnibor
# OMNIBOR-1-NEXT:  Owner                Data size        Description
# OMNIBOR-1-NEXT:  OMNIBOR              0x00000014       NT_GITOID_SHA1
# OMNIBOR-1-NEXT:  SHA1 GitOID: e1c058d0ab49e12b2a0063be9b62efea9f2453c0
# OMNIBOR-1-NEXT:  OMNIBOR              0x00000020       NT_GITOID_SHA256
# OMNIBOR-1-NEXT:  SHA256 GitOID: cdae8735776aa8f7e20531f631dd73affbd992dfc7d464ec2586760edd071893

# CHECK-NO-OMNIBOR-NOT: Displaying notes found in: .note.omnibor

# OMNIBOR-SHA1-NOTE: gitoid blob sha1
# OMNIBOR-SHA1-NOTE-NEXT: blob 52ebed6cf07d7ca81b88d47e905cb3c732e8ff3f

# OMNIBOR-SHA256-NOTE: gitoid blob sha256
# OMNIBOR-SHA256-NOTE-NEXT: blob 00b7792291a7818372031121c4556f3ac89fb7350be06423681604b7fb93873e

# CHECK-OMNIBOR-2: Displaying notes found in: .note.omnibor
# CHECK-OMNIBOR-2-NEXT: Owner                Data size        Description
# CHECK-OMNIBOR-2-NEXT: OMNIBOR              0x00000014       NT_GITOID_SHA1
# CHECK-OMNIBOR-2-NEXT: SHA1 GitOID: e1c058d0ab49e12b2a0063be9b62efea9f2453c0
# CHECK-OMNIBOR-2-NEXT: OMNIBOR              0x00000020       NT_GITOID_SHA256
# CHECK-OMNIBOR-2-NEXT: SHA256 GitOID: cdae8735776aa8f7e20531f631dd73affbd992dfc7d464ec2586760edd071893
