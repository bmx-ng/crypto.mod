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
bbdoc: XTS Chaining Mode
about: A chaining mode for 128–bit block ciphers, recommended by IEEE (P1619) for disk encryption.

It is meant to be an encryption mode with random access to the message data without compromising privacy.
It requires two private keys (of equal length) to perform the encryption process.
Each encryption invocation includes a sector number or unique identifier specified as a 128–bit string. 
End Rem
Module Crypto.XTSMode

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE -DLTC_XTS_MODE"

Import "common.bmx"

Rem
bbdoc: XTS Cipher Mode.
about: A chaining mode for 128–bit block ciphers
End Rem
Type TXTSCipherMode Extends TCipherMode

	Rem
	bbdoc: Initializes the cipher mode.
	returns: CRYPT_OK if the cipher initialized correctly, otherwise, returns an error code.
	about: It requires two private keys (of equal length) to perform the encryption process.
	End Rem
	Method Start:Int(cipher:TCipher, key1:Byte Ptr, key2:Byte Ptr, keylen:Int, numRounds:Int)
		Local res:Int
		modePtr = bmx_crypto_xts_start(cipher.index, key1, key2, keylen, numRounds, res)
		Return res
	End Method

	Rem
	bbdoc: Encrypts the plaintext @pt of @length to @ct.
	returns: CRYPT_OK on success.
	about: Supports ciphertext stealing (blocks that are not multiples of 16 bytes).
	
	The P1619 specification states the tweak for sector number shall be represented as a 128–bit little endian string.
	End Rem
	Method Encrypt:Int(pt:Byte Ptr, ptlength:UInt, ct:Byte Ptr, tweak:Byte Ptr)
		Return bmx_crypto_xts_encrypt(modePtr, pt, ptlength, ct, tweak)
	End Method
	
	Rem
	bbdoc: Decrypts the ciphertext @ct of @length to @pt.
	returns: CRYPT_OK on success.
	about: Supports ciphertext stealing (blocks that are not multiples of 16 bytes).

	The P1619 specification states the tweak for sector number shall be represented as a 128–bit little endian string.
	End Rem
	Method Decrypt:Int(ct:Byte Ptr, ptlength:UInt, pt:Byte Ptr, tweak:Byte Ptr)
		Return bmx_crypto_xts_decrypt(modePtr, ct, ptlength, pt, tweak)
	End Method

	Rem
	bbdoc: Terminates the cipher stream.
	End Rem
	Method Done:Int()
		Return bmx_crypto_xts_done(modePtr)
	End Method

End Type
