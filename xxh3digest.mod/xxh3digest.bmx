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

Rem
bbdoc: A digest implementation for the XXH3 64-bit hash algorithm.
about: The XXH3 hash algorithm is a fast, non-cryptographic hash algorithm.
End Rem
Module Crypto.XXH3Digest

Import "common.bmx"

New TXXH3DigestRegister

Rem
bbdoc: A digest implementation for the XXH3 hash algorithm.
End Rem
Type TXXH3Digest Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_xxh3_init()
	End Method

	Method OutBytes:Int() Override
		Return 8
	End Method

	Rem
	bbdoc: Resets the calculation to its initial state.
	about: This is useful if you want to reuse the same instance for multiple calculations.
	End Rem
	Method Reset()
		bmx_digest_xxh3_reset(digestPtr)
	End Method

	Rem
	bbdoc: Updates the calculation with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		bmx_digest_xxh3_update(digestPtr, data, dataLen)
	End Method

	Rem
	bbdoc: Calculates the XXH3 hash for the given #String, setting the value in @result.
	End Rem
	Method Digest(txt:String, result:ULong Var)
		result = txt.Hash() ' we already have a hash function for strings which uses XXH3
	End Method

	Rem
	bbdoc: Calculates the XXH3 hash for the given #TStream, setting the value in @result.
	End Rem
	Method Digest(stream:TStream, result:ULong Var)
		Local buf:Byte[8192]

		Reset() ' always reset before calculating a new hash
		
		Local bytesRead:Long
		Repeat
			bytesRead = stream.Read(buf, buf.length)
			If bytesRead > 0 Then
				Update(buf, Int(bytesRead))
			End If
		Until bytesRead <= 0

		If Not bytesRead Then
			Finish(result)
		End If
	End Method

	Rem
	bbdoc: Finishes calculation and produces the result, filling @result with the calculated bytes.
	about: The state is reset, ready to create a new calculation.
	End Rem
	Method Finish:Int(result:Byte[]) Override
		Assert result.length >= 8, "Byte array must be at least 8 bytes."
		bmx_digest_xxh3_finish(digestPtr, result, 8)
	End Method
	
	Rem
	bbdoc: Finishes calculation and produces the result, setting @result with the result.
	about: The state is reset, ready to create a new calculation.
	End Rem
	Method Finish:Int(result:ULong Var)
		bmx_digest_xxh3_finish_ulong(digestPtr, result)
	End Method

	Method Delete()
		If digestPtr Then
			bmx_digest_xxh3_free(digestPtr)
			digestPtr = Null
		End If
	End Method

End Type

Type TXXH3DigestRegister Extends TDigestRegister

	Method GetDigest:TMessageDigest( name:String ) Override
		If name.ToUpper() = "XXH3" Then
			Return New TXXH3Digest
		End If
	End Method

	Method ToString:String() Override
		Return "XXH3"
	End Method

End Type
