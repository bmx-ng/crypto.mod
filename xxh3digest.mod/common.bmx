' 
' Copyright (c) 2024 Bruce A Henderson
' 
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions are met:
' 
' 1. Redistributions of source code must retain the above copyright notice, this
'    list of conditions and the following disclaimer.
' 
' 2. Redistributions in binary form must reproduce the above copyright notice,
'    this list of conditions and the following disclaimer in the documentation
'    and/or other materials provided with the distribution.
' 
' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
' IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
' DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
' FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
' DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
' SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
' CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
' OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
' OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
' 
SuperStrict

Import Crypto.Digest


Import "../../brl.mod/blitz.mod/hash/*.h"

Import "glue.c"


Extern

	Function bmx_digest_xxh3_init:Byte Ptr()
	Function bmx_digest_xxh3_free(handle:Byte Ptr)
	Function bmx_digest_xxh3_reset(handle:Byte Ptr)
	Function bmx_digest_xxh3_update(handle:Byte Ptr, buf:Byte Ptr, length:Int)
	Function bmx_digest_xxh3_finish(handle:Byte Ptr, out:Byte Ptr, size:Int)
	Function bmx_digest_xxh3_finish_ulong(handle:Byte Ptr, out:ULong Var)

End Extern
