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
bbdoc: SEED Block Cipher.
about: The cipher comprises 128-bit blocks and a 128-bit key.

See <https://en.wikipedia.org/wiki/SEED>
End Rem
Module Crypto.KSeedCipher


ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"
ModuleInfo "CC_OPTS: -DLTC_KSEED"

Import "common.bmx"

New TKSeedCipherFactory(bmx_crypto_kseed_register())

Type TKSeedCipher Extends TCipher

	Method KeySize:Int(key:Int) Override
		Return bmx_crypto_kseed_keysize(key)
	End Method
	
	Method Name:String() Override
		Return "kseed"
	End Method

End Type

Type TKSeedCipherFactory Extends TCipherFactory
	Method Find:TCipher(index:Int) Override
		If index = Self.index Then
			Return New TKSeedCipher(index)
		End If
	End Method
End Type
