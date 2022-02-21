# llvm-gitbom
A repo for the GitBOM Community to collaborate on llvm changes before submitting them to upstream llvm.
The version of llvm being used is llvm-13.0.

# Example
$ cat a.h
int a = 100;

$ cat dir/b.h
int b = 1000;

$ cat a.c
\#include "a.h"
\#include "b.h"
\#include <stdio.h>

int main() {
  printf("%d",a);
  return 0;
}

$ clang -c -MD -Idir -frecord-gitbom a.c -o a.o

$ llvm-readelf -p ".bom" a.o
String dump of section '.bom':
[     0] faed6b820e7e9db9b55fd38a25bf6867eea61b6b

$ cat faed6b820e7e9db9b55fd38a25bf6867eea61b6b
blob 06a6891154fff74e1ddb6245f4a0467b09c617c5
blob 06dd79bc831bb06a6267a36ad2d62beccd7900b2
blob 0bc39408c1e5feaadd6f0420d14324b477420b93
blob 15acd4427ca14000111aad5071563bc7f2dc09f4
blob 1be90e6fab4ab9b7dd3b27cea5bb1fe29acc0204
blob 1d8a4e28d1b62a2bfeba837fe18422cd106e6ddf
blob 28488e0b05954ccf87c779f5f9258987e4d68ac5
blob 2c0cde251f1a9f05563a5f7a7f32588f04aaa235
blob 359f94945346c9eb4f92d1551e5e1a6d63a63dfb
blob 3f6fe3cc8563b49311327647fad53eb18d94da2c
blob 477c8e4931c0d7191187acb42f0ed4255e3619aa
blob 4e3592f32fc5b715a2829040fea38a61105f51ed
blob 4f725e95ffa2663083b66a557b12751261cbcf05
blob 5bed0a499605a3a26d55443f3c8b7e67de152f74
blob 64f344c6e7897491c7c7430f52ad06c61fa85dad
blob 70a1ba017357d3111cc510e73b269541ca2aaf09
blob 70f652bca14d65c1de5a21669e7c0ffb8ecfe5ea
blob 739e08610d54f341cf14247ec38f254e1520e5b1
blob a1697e3a6267cc74e824f60e993484f70d7b440a
blob b4a429b83c345681b269bdee0785363f3d2c1f3c
blob bb04576651b9097b3027e4299cc30c88f334535f
blob c2ab78a2d4c20711295a501c61dd038bfa029934
blob e6f7481a19cbc7857dbbfebef5adbeeaf80a70b8
blob f2682632090ba3e7f2caa1736394cbb235ceab0c
