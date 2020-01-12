'
'  Copyright (C) 2019-2020 Bruce A Henderson
'
'  This software is provided 'as-is', without any express or implied
'  warranty.  In no event will the authors be held liable for any damages
'  arising from the use of this software.
'
'  Permission is granted to anyone to use this software for any purpose,
'  including commercial applications, and to alter it and redistribute it
'  freely, subject to the following restrictions:
'
'  1. The origin of this software must not be misrepresented; you must not
'     claim that you wrote the original software. If you use this software
'     in a product, an acknowledgment in the product documentation would be
'     appreciated but is not required.
'  2. Altered source versions must be plainly marked as such, and must not be
'     misrepresented as being the original software.
'  3. This notice may not be removed or altered from any source distribution.
'
SuperStrict

Rem
bbdoc: SHA-3 Digest
about: 
See <https://en.wikipedia.org/wiki/SHA-3>
End Rem
Module Crypto.SHA3Digest

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_SHA3"

Import "common.bmx"

New TSHA3DigestRegister

Rem
bbdoc: An SHA3-512 message digest.
End Rem
Type TSHA3_512 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_sha3_512_init()
	End Method

	Method OutBytes:Int() Override
		Return 64
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_sha3_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 64, "Byte array must be at least 64 bytes."
		Return bmx_digest_sha3_512_done(digestPtr, digest)
	End Method

End Type

Rem
bbdoc: An SHA3-384 message digest.
End Rem
Type TSHA3_384 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_sha3_384_init()
	End Method

	Method OutBytes:Int() Override
		Return 48
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_sha3_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 48, "Byte array must be at least 48 bytes."
		Return bmx_digest_sha3_384_done(digestPtr, digest)
	End Method

End Type

Rem
bbdoc: An SHA3-256 message digest.
End Rem
Type TSHA3_256 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_sha3_256_init()
	End Method

	Method OutBytes:Int() Override
		Return 32
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_sha3_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 32, "Byte array must be at least 32 bytes."
		Return bmx_digest_sha3_256_done(digestPtr, digest)
	End Method

End Type

Rem
bbdoc: An SHA3-224 message digest.
End Rem
Type TSHA3_224 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_sha3_224_init()
	End Method

	Method OutBytes:Int() Override
		Return 28
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_sha3_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 28, "Byte array must be at least 28 bytes."
		Return bmx_digest_sha3_224_done(digestPtr, digest)
	End Method

End Type

Type TSHA3DigestRegister Extends TDigestRegister

	Method GetDigest:TMessageDigest( name:String ) Override
		name = name.ToUpper()
		Select name
			Case "SHA3-512", "SHA3_512", "SHA3512"
				Return New TSHA3_512
			Case "SHA3-384", "SHA3_384", "SHA3384"
				Return New TSHA3_384
			Case "SHA3-256", "SHA3_256", "SHA3256"
				Return New TSHA3_256
			Case "SHA3-224", "SHA3_224", "SHA3224"
				Return New TSHA3_224
		End Select
	End Method

	Method ToString:String() Override
		Return "SHA3-512, SHA3-384, SHA3-256, SHA3-224"
	End Method

End Type
