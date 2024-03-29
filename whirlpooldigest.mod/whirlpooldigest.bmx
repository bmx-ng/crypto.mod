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
bbdoc: WHILRPOOL Digest
about: 
See <https://en.wikipedia.org/wiki/Whirlpool_(hash_function)>
End Rem
Module Crypto.WhirlpoolDigest

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_WHIRLPOOL"

Import "common.bmx"

New TWhirlpoolDigestRegister

Rem
bbdoc: A WHIRPOOL message digest.
End Rem
Type TWhirlpool Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_whirlpool_init()
	End Method

	Method OutBytes:Int() Override
		Return 64
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_whirlpool_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 64, "Byte array must be at least 16 bytes."
		Return bmx_digest_whirlpool_done(digestPtr, digest)
	End Method

End Type

Type TWhirlpoolDigestRegister Extends TDigestRegister

	Method GetDigest:TMessageDigest( name:String ) Override
		If name.ToUpper() = "WHIRLPOOL" Then
			Return New TWhirlpool
		End If
	End Method

	Method ToString:String() Override
		Return "WHIRLPOOL"
	End Method
	
End Type
