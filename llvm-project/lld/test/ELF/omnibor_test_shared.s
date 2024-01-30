# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/omnibor-add.s -o %t/add.o
# RUN: ld.lld %t/add.o -shared -o %t/libadd.so
# RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %S/Inputs/omnibor-useadd.s -o %t/useadd.o
# RUN: ld.lld -e main --omnibor=%t/omnibor_dir %t/useadd.o -L%t -ladd -o %t/omnibor.exe

# RUN: ARTIFACT_ID=`git hash-object %t/omnibor.exe`

# RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha1/4d/5d15346cc50f375415126f59c68557eaad5b91 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha256/96/fc39fafd5b65d4d030ba269a5d05dd7cf177bb6f4ef67a0b1e62ddbc171062 | FileCheck --check-prefix=BOM_FILE_SHA256 %s
# RUN: cat %t/omnibor_dir/metadata/llvm/$ARTIFACT_ID | FileCheck --check-prefix=METADATA_CONTENTS %s

# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob b5c9e6237f9381f5c9ce8d38d8db8b9071c46e9d

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob 53d9ba61c4c2e290bdafaa0528265b2854fb65356c4f00e085d6be895cb98343

# CHECK-NO-OMNIBOR-NOT: Displaying notes found in: .note.omnibor

# METADATA_CONTENTS: output: {{.*}} path: {{.*}}omnibor.exe
# METADATA_CONTENTS: input: {{.*}} path: {{.*}}useadd.o
# METADATA_CONTENTS: dynlib: {{.*}} path: {{.*}}libadd.so
# METADATA_CONTENTS: build_cmd: ld.lld {{.*}}
==== End of raw info for this process
