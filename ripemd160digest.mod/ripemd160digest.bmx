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
bbdoc: RIPEMD-160 Digest
End Rem
Module Crypto.Ripemd160Digest

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_RIPEMD160"

Import "common.bmx"

New TRipemd160DigestRegister

Rem
bbdoc: An Ripemd-160 message digest.
End Rem
Type TRipemd160 Extends TMessageDigest

	Method New()
		digestPtr = bmx_digest_rmd160_init()
	End Method

	Method OutBytes:Int() Override
		Return 20
	End Method
	
	Rem
	bbdoc: Updates the hash with @dataLen bytes of data.
	End Rem
	Method Update:Int(data:Byte Ptr, dataLen:Int) Override
		Return bmx_digest_rmd160_process(digestPtr, data, dataLen)
	End Method
	
	Rem
	bbdoc: Finishes hashing and produces the digest, filling @digest with the hashed bytes.
	about: The hashing state is reset, ready to create a new digest.
	End Rem
	Method Finish:Int(digest:Byte[]) Override
		Assert digest.length >= 20, "Byte array must be at least 20 bytes."
		Return bmx_digest_rmd160_done(digestPtr, digest)
	End Method

End Type

Type TRipemd160DigestRegister Extends TDigestRegister

	Method GetDigest:TMessageDigest( name:String ) Override
		name = name.ToUpper()
		If name = "RMD-160" Or name = "RMD160" Or name = "RIPEMD-160" Or name = "RIPEMD160" Then
			Return New TRipemd160
		End If
	End Method

	Method ToString:String() Override
		Return "RIPEMD-160"
	End Method

End Type