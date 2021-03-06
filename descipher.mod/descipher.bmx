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
bbdoc: DES/3DES Symmetric Key Block Cipher.
about: Incorprates the legacy Data Encryption Standard 56-bit key cipher and its more scure successor 3DES with key sizes of 168, 112 or 56 bits.

See <https://en.wikipedia.org/wiki/Data_Encryption_Standard>
End Rem
Module Crypto.DESCipher


ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_DES"

Import "common.bmx"

New TDESCipherFactory(bmx_crypto_des_register())
New T3DESCipherFactory(bmx_crypto_3des_register())

Type TDESCipher Extends TCipher

	Method KeySize:Int(key:Int) Override
		Return bmx_crypto_des_keysize(key)
	End Method
	
	Method Name:String() Override
		Return "DES"
	End Method

End Type

Type T3DESCipher Extends TCipher

	Method KeySize:Int(key:Int) Override
		Return bmx_crypto_3des_keysize(key)
	End Method
	
	Method Name:String() Override
		Return "3DES"
	End Method

End Type

Type TDESCipherFactory Extends TCipherFactory
	Method Find:TCipher(index:Int) Override
		If index = Self.index Then
			Return New TDESCipher(index)
		End If
	End Method
End Type

Type T3DESCipherFactory Extends TCipherFactory
	Method Find:TCipher(index:Int) Override
		If index = Self.index Then
			Return New T3DESCipher(index)
		End If
	End Method
End Type
