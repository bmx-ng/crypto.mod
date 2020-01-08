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
bbdoc: F8 Chaining Mode
about: It behaves much like CTR mode in that it XORs a keystream against the plaintext to encrypt.
F8 mode comes with the additional twist that the counter value is secret, encrypted by a salt key.
End Rem
Module Crypto.F8Mode

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE -DLTC_F8_MODE"

Import "common.bmx"

Rem
bbdoc: 
End Rem
Type TF8CipherMode Extends TCipherMode

	Rem
	bbdoc: 
	End Rem
	Method Start:Int(cipher:TCipher, iv:Byte Ptr, key:Byte Ptr, keylen:Int, saltKey:Byte Ptr, saltkeylen:Int, numRounds:Int)
		Local res:Int
		modePtr = bmx_crypto_f8_start(cipher.index, iv, key, keylen, saltKey, saltkeylen, numRounds, res)
		Return res
	End Method

	Rem
	bbdoc: Encrypts the plaintext @pt of @length to @ct.
	returns: CRYPT_OK on success.
	about: The @length is speciﬁed in bytes and does not have to be a multiple of the ciphers block size.
	End Rem
	Method Encrypt:Int(pt:Byte Ptr, ct:Byte Ptr, length:UInt)
		Return bmx_crypto_f8_encrypt(modePtr, pt, ct, length)
	End Method
	
	Rem
	bbdoc: Decrypts the ciphertext @ct of @length to @pt.
	returns: CRYPT_OK on success.
	about: The @length is speciﬁed in bytes and does not have to be a multiple of the ciphers block size.
	End Rem
	Method Decrypt:Int(ct:Byte Ptr, pt:Byte Ptr, length:UInt)
		Return bmx_crypto_f8_decrypt(modePtr, ct, pt, length)
	End Method

	Rem
	bbdoc: Reads the IV out of the chaining mode, and stores it in @IV along with the @length of the IV.
	about: This works with the current IV value only and not the encrypted IV value speciﬁed during the call to #Start.
	The purpose of this method is to be able to seek within a current session only. If you want to change the session IV you will have to call #Done and
	then start a new state with #Start. 
	End Rem
	Method GetIV:Int(IV:Byte Ptr, length:UInt Var)
		Return bmx_crypto_f8_getiv(modePtr, IV, length)
	End Method
	
	Rem
	bbdoc: Initializes the chaining mode state as if the original IV were the new IV specified.
	about: The @length of @IV must be the size of the cipher block size.
	
	This method is handy if you wish to change the IV without re–keying the cipher.

	The IV is encrypted as if it were the prior encrypted pad.
	End Rem
	Method SetIV:Int(IV:Byte Ptr, length:UInt)
		Return bmx_crypto_f8_setiv(modePtr, IV, length)
	End Method

	Rem
	bbdoc: Terminates the cipher stream.
	End Rem
	Method Done:Int()
		Return bmx_crypto_f8_done(modePtr)
	End Method

End Type
