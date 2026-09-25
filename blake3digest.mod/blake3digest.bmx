'
'  Copyright (C) 2026 Kay Arnesen and Liz
'
'  SPDX-License-Identifier: 0BSD
'
'  Permission to use, copy, modify, and/or distribute this software for any
'  purpose with or without fee is hereby granted.
'
'  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
'  REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
'  AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
'  INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
'  LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
'  OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
'  PERFORMANCE OF THIS SOFTWARE.
'
SuperStrict

Rem
bbdoc: BLAKE3 hashing, keyed hashing, key derivation and extended output.
about: Uses the official BLAKE3 C implementation. The default digest is 32 bytes.
BLAKE3 key derivation requires high-entropy key material; it is not a password hash.
End Rem
Module Crypto.Blake3Digest

ModuleInfo "Version: 1.00"
ModuleInfo "License: 0BSD; bundled BLAKE3: CC0-1.0 OR Apache-2.0 OR Apache-2.0 WITH LLVM-exception"
?blake3_portable Or Not (x64 Or x86)
ModuleInfo "CC_OPTS: -DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 -DBLAKE3_NO_AVX2 -DBLAKE3_NO_AVX512"
?
?blake3_portable
ModuleInfo "CC_OPTS: -DBLAKE3_USE_NEON=0"
?

Import "common.bmx"

New TBlake3DigestRegister

Rem
bbdoc: An incremental BLAKE3 digest with a default output size of 32 bytes.
about: #Finish and #FinishXOF reset the message while preserving the mode and key.
#Output reads the current digest without resetting it. Instances are not safe for
concurrent mutation. Pointer inputs must refer to at least the requested number of readable bytes.
End Rem
Type TBlake3Digest Extends TMessageDigest

	Method New()
		digestPtr = bmx_blake3_new()
		If Not digestPtr Then RuntimeError "Unable to allocate BLAKE3 state."
	End Method

	Rem
	bbdoc: Creates a keyed hasher using exactly 32 key bytes.
	End Rem
	Function CreateKeyed:TBlake3Digest(key:Byte[])
		If key.length <> 32 Then IllegalArgumentError "BLAKE3 keys must contain exactly 32 bytes."
		Local digest:TBlake3Digest = New TBlake3Digest
		If bmx_blake3_keyed(digest.digestPtr, key, key.length) Then RuntimeError "Unable to initialize BLAKE3 keyed mode."
		Return digest
	End Function

	Rem
	bbdoc: Creates a key-derivation hasher with a UTF-8 context string.
	about: Use a hardcoded, globally unique, application-specific context describing
	the purpose. Supply high-entropy input key material through #Update.
	End Rem
	Function CreateDeriveKey:TBlake3Digest(context:String)
		Local length:Size_T
		Local data:Byte Ptr = context.ToUTF8String(length)
		Try
			Local digest:TBlake3Digest = New TBlake3Digest
			If bmx_blake3_derive(digest.digestPtr, data, length) Then RuntimeError "Unable to initialize BLAKE3 key derivation."
			Return digest
		Finally
			MemFree data
		End Try
	End Function

	Method OutBytes:Int() Override
		Return 32
	End Method

	Rem
	bbdoc: Discards the current message, retaining the mode and key.
	End Rem
	Method Reset()
		bmx_blake3_reset(digestPtr)
	End Method

	Rem
	bbdoc: Adds @dataLen bytes and returns zero on success.
	about: Negative lengths and null pointers with nonzero lengths throw #TIllegalArgumentException.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		If dataLen < 0 Then IllegalArgumentError "BLAKE3 input length must not be negative."
		If bmx_blake3_update(digestPtr, data, Size_T(dataLen)) Then IllegalArgumentError "Invalid BLAKE3 input."
		Return 0
	End Method

	Rem
	bbdoc: Adds every byte of @data and returns zero on success.
	End Rem
	Method Update:Int(data:Byte[])
		Return Update(data, data.length)
	End Method

	Rem
	bbdoc: Writes 32 bytes and resets the message, returning zero on success.
	about: A shorter destination throws #TIllegalArgumentException without changing the state.
	Any bytes after the first 32 in a larger destination are left unchanged.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		If digest.length < 32 Then IllegalArgumentError "BLAKE3 digest output requires at least 32 bytes."
		If bmx_blake3_output(digestPtr, digest, 32, 0:ULong) Then RuntimeError "Unable to finalize BLAKE3."
		Reset()
		Return 0
	End Method

	Rem
	bbdoc: Fills @output with extended output and resets the message, returning zero on success.
	about: The output begins at byte zero. An empty output is allowed and still resets the message.
	End Rem
	Method FinishXOF:Int(output:Byte[])
		Self.Output(output)
		Reset()
		Return 0
	End Method

	Rem
	bbdoc: Fills @output starting at byte position @seek without changing the state.
	about: Repeated calls with the same position produce identical bytes. Updates may
	continue afterward. Returns zero on success; a range overflowing ULong throws #TIllegalArgumentException.
	End Rem
	Method Output:Int(output:Byte[], seek:ULong = 0:ULong)
		If bmx_blake3_output(digestPtr, output, output.length, seek) Then IllegalArgumentError "Invalid BLAKE3 output range."
		Return 0
	End Method

	Rem
	bbdoc: Adds the complete UTF-8 encoding of @data, then finishes and resets the message.
	about: Embedded NUL characters are included. Like #TMessageDigest, this includes any prior updates.
	End Rem
	Method DigestBytes:Byte[](data:String) Override
		Local length:Size_T
		Local buffer:Byte Ptr = data.ToUTF8String(length)
		Try
			If bmx_blake3_update(digestPtr, buffer, length) Then RuntimeError "Unable to update BLAKE3."
			Local result:Byte[32]
			Finish(result)
			Return result
		Finally
			MemFree buffer
		End Try
	End Method

	Rem
	bbdoc: Adds bytes from @stream, then finishes and resets the message.
	about: Reads until the stream returns zero. A negative or oversized read throws
	#TStreamReadException. Failed reads discard the partial message; the caller owns the stream.
	End Rem
	Method DigestBytes:Byte[](stream:TStream) Override
		If Not stream Then IllegalArgumentError "BLAKE3 requires a stream."
		Local buffer:Byte[65536]
		Try
			Repeat
				Local count:Long = stream.Read(buffer, buffer.length)
				If count < 0 Or count > buffer.length Then Throw New TStreamReadException
				If count = 0 Then Exit
				Update(buffer, Int(count))
			Forever
			Local result:Byte[32]
			Finish(result)
			Return result
		Finally
			Reset()
		End Try
	End Method

	Method Delete()
		bmx_blake3_free(digestPtr)
		digestPtr = Null
	End Method

End Type

Type TBlake3DigestRegister Extends TDigestRegister
	Method GetDigest:TMessageDigest(name:String) Override
		Select name.ToUpper()
			Case "BLAKE3", "BLAKE3-256", "BLAKE3_256", "BLAKE3256"
				Return New TBlake3Digest
		End Select
	End Method

	Method ToString:String() Override
		Return "BLAKE3"
	End Method
End Type
