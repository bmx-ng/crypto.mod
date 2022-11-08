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
bbdoc: Anubis Block Cipher.
about: Anubis operates on data blocks of 128 bits, accepting keys of length 32N bits `(N = 4, ..., 10)`.
It is designed as a substitution-permutation network, which bears large similarity to #Crypto.AESCipher.

See <https://en.wikipedia.org/wiki/Anubis_(cipher)>
End Rem
Module Crypto.AnubisCipher


ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_ANUBIS"

Import "common.bmx"

New TAnubisCipherFactory(bmx_crypto_anubis_register())

Type TAnubisCipher Extends TBlockCipher

	Method KeySize:Int(key:Int) Override
		Return bmx_crypto_anubis_keysize(key)
	End Method
	
	Method Name:String() Override
		Return "anubis"
	End Method

	Method BlockSize:Int() Override
		Return 16
	End Method

	Method Setup:Int(key:String, rounds:Int = 0) Override
		Local s:Byte Ptr = key.ToUTF8String()
		Local ret:Int = anubis_setup(s, Int(strlen_(s)), rounds, keyPtr)
		MemFree(s)
		Return ret
	End Method

	Method Setup:Int(key:Byte[], rounds:Int = 0) Override
		Return anubis_setup(key, key.length, rounds, keyPtr)
	End Method

	Method Setup:Int(key:Byte Ptr, keylen:Int, rounds:Int = 0) Override
		Return anubis_setup(key, keylen, rounds, keyPtr)
	End Method

	Method Encrypt:Int(pt:Byte Ptr, ct:Byte Ptr) Override
		Return anubis_ecb_encrypt(pt, ct, keyPtr)
	End Method

	Method Decrypt:Int(ct:Byte Ptr, pt:Byte Ptr) Override
		Return anubis_ecb_decrypt(ct, pt, keyPtr)		
	End Method

	Method Done() Override
		anubis_done(keyPtr)
	End Method

End Type

Type TAnubisCipherFactory Extends TCipherFactory
	Method Find:TCipher(index:Int) Override
		If index = Self.index Then
			Return New TAnubisCipher(index)
		End If
	End Method
End Type
