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
bbdoc: Electronic Codebook Mode
about: Electronic Codebook Mode is the simplest method to use.
It is given as:
$$$
C_i = E_k(P_i)
$$$

It is very weak since it allows people to swap blocks and perform replay attacks if the same key is used more than once.
End Rem
Module Crypto.ECBMode

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE -DLTC_ECB_MODE"

Import "common.bmx"

Rem
bbdoc: ECB Cipher Mode
about: A symmetric mode block cipher.
End Rem
Type TECBCipherMode Extends TCipherMode

	Rem
	bbdoc: Initializes the cipher mode.
	returns: CRYPT_OK if the cipher initialized correctly, otherwise, returns an error code.
	End Rem
	Method Start:Int(cipher:TCipher, key:Byte Ptr, keylen:Int, numRounds:Int)
		Local res:Int
		modePtr = bmx_crypto_ecb_start(cipher.index, key, keylen, numRounds, res)
		Return res
	End Method

	Rem
	bbdoc: Encrypts the plaintext @pt of @length to @ct.
	returns: CRYPT_OK on success.
	about: @length must be a multiple of the cipher block size, otherwise you must manually pad the end of your
	message (either with zeroes or with whatever your protocol requires).
	End Rem
	Method Encrypt:Int(pt:Byte Ptr, ct:Byte Ptr, length:UInt)
		Return bmx_crypto_ecb_encrypt(modePtr, pt, ct, length)
	End Method
	
	Rem
	bbdoc: Decrypts the ciphertext @ct of @length to @pt.
	returns: CRYPT_OK on success.
	End Rem
	Method Decrypt:Int(ct:Byte Ptr, pt:Byte Ptr, length:UInt)
		Return bmx_crypto_ecb_decrypt(modePtr, ct, pt, length)
	End Method

	Rem
	bbdoc: Terminates the cipher stream.
	End Rem
	Method Done:Int()
		Return bmx_crypto_ecb_done(modePtr)
	End Method

End Type
