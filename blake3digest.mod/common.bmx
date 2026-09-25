SuperStrict

Import Crypto.Digest

Import "blake3/*.h"
Import "blake3/blake3.c"
Import "blake3/blake3_dispatch.c"
Import "blake3/blake3_portable.c"
?Not blake3_portable And x64 And win32
Import "blake3/blake3_sse2_x86-64_windows_gnu.S"
Import "blake3/blake3_sse41_x86-64_windows_gnu.S"
Import "blake3/blake3_avx2_x86-64_windows_gnu.S"
Import "blake3/blake3_avx512_x86-64_windows_gnu.S"
?Not blake3_portable And (x86 Or (x64 And Not win32))
Import "simd_sse2.c"
Import "simd_sse41.c"
Import "simd_avx2.c"
Import "simd_avx512.c"
?
Import "neon.c"
Import "glue.c"

Extern "C"

	Function bmx_blake3_new:Byte Ptr()
	Function bmx_blake3_free(handle:Byte Ptr)
	Function bmx_blake3_keyed:Int(handle:Byte Ptr, key:Byte Ptr, length:Int)
	Function bmx_blake3_derive:Int(handle:Byte Ptr, context:Byte Ptr, length:Size_T)
	Function bmx_blake3_update:Int(handle:Byte Ptr, data:Byte Ptr, length:Size_T)
	Function bmx_blake3_output:Int(handle:Byte Ptr, output:Byte Ptr, length:Int, seek:ULong)
	Function bmx_blake3_reset(handle:Byte Ptr)

End Extern
