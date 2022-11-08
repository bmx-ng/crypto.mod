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
bbdoc: Ciphertext Feedback Mode
about: Ciphertext Feedback Mode is a mode designed to prevent trivial forms of replay and swap attacks on ciphers.
It is given as:
$$$
\begin{aligned}
C_i &= P_i \oplus C_{-1} \\
C_{-1} &= E_k(C_i)
\end{aligned}
$$$

The output feedback width is equal to the size of the block cipher.
That is this mode is used to encrypt whole blocks at a time. However, the library will buﬀer data allowing the user
to encrypt or decrypt partial blocks without a delay. When this mode is first setup it will initially encrypt the initialization vector as required.
End Rem
Module Crypto.CFBMode

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE -DLTC_CFB_MODE"

Import "common.bmx"

Rem
bbdoc: CFB Cipher Mode
about: A symmetric mode block cipher.
End Rem
Type TCFBCipherMode Extends TCipherMode

	Rem
	bbdoc: Initializes the cipher mode.
	returns: CRYPT_OK if the cipher initialized correctly, otherwise, returns an error code.
	about: The @iv value is the initialization vector to be used with the cipher.
	You must fill the IV yourself and it is assumed they are the same length as the block size of the cipher you choose.
	It is important that the IV be random for each unique message you want to encrypt.
	End Rem
	Method Start:Int(cipher:TCipher, iv:Byte Ptr, key:Byte Ptr, keylen:Int, numRounds:Int)
		Local res:Int
		modePtr = bmx_crypto_cfb_start(cipher.index, iv, key, keylen, numRounds, res)
		Return res
	End Method

	Rem
	bbdoc: Encrypts the plaintext @pt of @length to @ct.
	returns: CRYPT_OK on success.
	about: @length must be a multiple of the cipher block size, otherwise you must manually pad the end of your
	message (either with zeroes or with whatever your protocol requires).
	End Rem
	Method Encrypt:Int(pt:Byte Ptr, ct:Byte Ptr, length:UInt)
		Return bmx_crypto_cfb_encrypt(modePtr, pt, ct, length)
	End Method
	
	Rem
	bbdoc: Decrypts the ciphertext @ct of @length to @pt.
	returns: CRYPT_OK on success.
	End Rem
	Method Decrypt:Int(ct:Byte Ptr, pt:Byte Ptr, length:UInt)
		Return bmx_crypto_cfb_decrypt(modePtr, ct, pt, length)
	End Method

	Rem
	bbdoc: Reads the IV out of the chaining mode, and stores it in @IV along with the @length of the IV.
	End Rem
	Method GetIV:Int(IV:Byte Ptr, length:UInt Var)
		Return bmx_crypto_cfb_getiv(modePtr, IV, length)
	End Method
	
	Rem
	bbdoc: Initializes the chaining mode state as if the original IV were the new IV specified.
	about: The @length of @IV must be the size of the cipher block size.
	
	This method is handy if you wish to change the IV without re–keying the cipher.

	The IV is encrypted as if it were the prior encrypted pad.
	End Rem
	Method SetIV:Int(IV:Byte Ptr, length:UInt)
		Return bmx_crypto_cfb_setiv(modePtr, IV, length)
	End Method

	Rem
	bbdoc: Terminates the cipher stream.
	End Rem
	Method Done:Int()
		Return bmx_crypto_cfb_done(modePtr)
	End Method

End Type
