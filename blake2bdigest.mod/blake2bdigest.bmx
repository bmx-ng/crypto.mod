'
'  Copyright (C) 2019-2022 Bruce A Henderson
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
bbdoc: BLAKE2B Digest
about: 
See <https://en.wikipedia.org/wiki/BLAKE_(hash_function)>
End Rem
Module Crypto.Blake2BDigest

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_BLAKE2B"

Import "common.bmx"

New TBlake2BDigestRegister

Rem
bbdoc: An BLAKE2B-512 message digest.
End Rem
Type TBlake2B_512 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_blake2b_512_init()
	End Method

	Method OutBytes:Int() Override
		Return 64
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_blake2b_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 64, "Byte array must be at least 64 bytes."
		Return bmx_digest_blake2b_512_done(digestPtr, digest)
	End Method

End Type

Rem
bbdoc: An BLAKE2B-384 message digest.
End Rem
Type TBlake2B_384 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_blake2b_384_init()
	End Method

	Method OutBytes:Int() Override
		Return 48
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_blake2b_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 48, "Byte array must be at least 48 bytes."
		Return bmx_digest_blake2b_384_done(digestPtr, digest)
	End Method

End Type

Rem
bbdoc: An BLAKE2B-256 message digest.
End Rem
Type TBlake2B_256 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_blake2b_256_init()
	End Method

	Method OutBytes:Int() Override
		Return 32
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_blake2b_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 32, "Byte array must be at least 32 bytes."
		Return bmx_digest_blake2b_256_done(digestPtr, digest)
	End Method

End Type

Rem
bbdoc: An BLAKE2B-160 message digest.
End Rem
Type TBlake2B_160 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_blake2b_160_init()
	End Method

	Method OutBytes:Int() Override
		Return 20
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_blake2b_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 20, "Byte array must be at least 20 bytes."
		Return bmx_digest_blake2b_160_done(digestPtr, digest)
	End Method

End Type

Type TBlake2BDigestRegister Extends TDigestRegister

	Method GetDigest:TMessageDigest( name:String ) Override
		name = name.ToUpper()
		Select name
			Case "BLAKE2B-512", "BLAKE2B_512", "BLAKE2B512"
				Return New TBlake2B_512
			Case "BLAKE2B-384", "BLAKE2B_384", "BLAKE2B384"
				Return New TBlake2B_384
			Case "BLAKE2B-256", "BLAKE2B_256", "BLAKE2B256"
				Return New TBlake2B_256
			Case "BLAKE2B-160", "BLAKE2B_160", "BLAKE2B160"
				Return New TBlake2B_160
		End Select
	End Method

	Method ToString:String() Override
		Return "BLAKE2B-512, BLAKE2B-384, BLAKE2B-256, BLAKE2B-224"
	End Method

End Type
