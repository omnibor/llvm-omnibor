# RUN: rm -rf %t && mkdir %t
# RUN: llvm-mc -filetype=obj --omnibor-as=%t -triple=x86_64-pc-linux %S/Inputs/omnibor.s -o %t/omnibor.o
# RUN: ld.lld %t/omnibor.o -e main --omnibor=%t -o %t/omnibor.exe
# RUN: llvm-readelf -n %t/omnibor.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/objects/gitoid_blob_sha1/62/db4ab2efaf0b3df12e5004ff2b002936b94697 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/objects/gitoid_blob_sha256/6b/a8bcf3a1c3c7cafcfba5994ca7ee29bd47234f8616991717677836ce00dd95 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -rf %t/objects
# RUN: ld.lld %t/omnibor.o -e main --omnibor=%t/omnibor_dir -o %t/omnibor_1.exe
# RUN: llvm-readelf -n %t/omnibor_1.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha1/62/db4ab2efaf0b3df12e5004ff2b002936b94697 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha256/6b/a8bcf3a1c3c7cafcfba5994ca7ee29bd47234f8616991717677836ce00dd95 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -rf %t/env_omnibor_dir/objects
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" ld.lld %t/omnibor.o -e main --omnibor=%t/omnibor_dir -o %t/omnibor_2.exe
# RUN: llvm-readelf -n %t/omnibor_2.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha1/62/db4ab2efaf0b3df12e5004ff2b002936b94697 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/omnibor_dir/objects/gitoid_blob_sha256/6b/a8bcf3a1c3c7cafcfba5994ca7ee29bd47234f8616991717677836ce00dd95 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: rm -rf %t/env_omnibor_dir/objects/
# RUN: env OMNIBOR_DIR="%t/env_omnibor_dir" ld.lld %t/omnibor.o -e main -o %t/omnibor_3.exe
# RUN: llvm-readelf -n %t/omnibor_3.exe | FileCheck --check-prefix=BOM_NOTE_SECTION %s
# RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha1/62/db4ab2efaf0b3df12e5004ff2b002936b94697 | FileCheck --check-prefix=BOM_FILE_SHA1 %s
# RUN: cat %t/env_omnibor_dir/objects/gitoid_blob_sha256/6b/a8bcf3a1c3c7cafcfba5994ca7ee29bd47234f8616991717677836ce00dd95 | FileCheck --check-prefix=BOM_FILE_SHA256 %s

# RUN: ld.lld %t/omnibor.o -e main -o %t/omnibor_4.exe
# RUN: llvm-readelf -n %t/omnibor_4.exe | FileCheck --allow-empty --check-prefix=CHECK-NO-OMNIBOR %s

# BOM_FILE_SHA1: gitoid blob sha1
# BOM_FILE_SHA1: blob 9d6dac408438994dab9740d9a554599be282eb77 bom 3cdf9fc14ab04cb12e1b273a2fa890a60a80dc6b

# BOM_FILE_SHA256: gitoid blob sha256
# BOM_FILE_SHA256: blob 7be162961af2a2bd56813212b52af57b3592c79abf93e4dd25a6b220af6b001e bom effadaa78c3d317d42a31411d7e493c59bf77788f8683ecc2c3be754e7f15c12

# CHECK-NO-OMNIBOR-NOT: Displaying notes found in: .note.omnibor

# BOM_NOTE_SECTION: Displaying notes found in: .note.omnibor
# BOM_NOTE_SECTION-NEXT: Owner                Data size        Description
# BOM_NOTE_SECTION-NEXT: 0x00000014       NT_GITOID_SHA1
# BOM_NOTE_SECTION-NEXT: SHA1 GitOID: 62db4ab2efaf0b3df12e5004ff2b002936b94697
# BOM_NOTE_SECTION-NEXT: 0x00000020       NT_GITOID_SHA256
# BOM_NOTE_SECTION-NEXT: SHA256 GitOID: 6ba8bcf3a1c3c7cafcfba5994ca7ee29bd47234f8616991717677836ce00dd95
