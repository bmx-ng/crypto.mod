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
bbdoc: Counter Mode
about: A mode which only uses the encryption function of the cipher.

Given a initialization vector which is treated as a large binary counter the CTR mode is given as:
$$$
\begin{aligned}
C_{-1} &= C_{-1} + 1\text{ }(\text{mod }2^W) \\
C_i &= P_i \oplus E_k(C_{-1})
\end{aligned}
$$$

As long as the initialization vector is random for each message encrypted under the same key replay and swap attacks are infeasible.
CTR mode may look simple but it is as secure as the block cipher is under a chosen plaintext attack (provided the initialization vector is unique).
End Rem
Module Crypto.CTRMode

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE -DLTC_CTR_MODE"

Import "common.bmx"

Rem
bbdoc: CTR Cipher Mode
about: A symmetric mode block cipher.
End Rem
Type TCTRCipherMode Extends TCipherMode

	Rem
	bbdoc: Initializes the cipher mode.
	returns: CRYPT_OK if the cipher initialized correctly, otherwise, returns an error code.
	about: The @iv value is the initialization vector to be used with the cipher.
	You must fill the IV yourself and it is assumed they are the same length as the block size of the cipher you choose.
	It is important that the IV be random for each unique message you want to encrypt.

	The @counterMode parameter specfies the mode that the counter is to be used in. If #ECTRCounterMode LITTLE_ENDIAN is specfied
	then the counter will be treated as a little endian value. Otherwise, if BIG_ENDIAN is specified the counter will be treated as a
	big endian value.
	The RFC 3686 style of increment for encryption is also supported, by OR'ing RFC3686 with the CTR mode value.
	The counter will be incremented before encrypting it for the first time.
	It also supports variable length counters for CTR mode. The (optional) counter length is specified by OR'ing the octet length of
	the counter against the @counterMode parameter. The default, zero, indicates that a full block length counter will be used.
	End Rem
	Method Start:Int(cipher:TCipher, iv:Byte Ptr, key:Byte Ptr, keylen:Int, numRounds:Int, counterMode:ECTRCounterMode)
		Local res:Int
		modePtr = bmx_crypto_ctr_start(cipher.index, iv, key, keylen, numRounds, counterMode, res)
		Return res
	End Method

	Rem
	bbdoc: Encrypts the plaintext @pt of @length to @ct.
	returns: CRYPT_OK on success.
	about: @length must be a multiple of the cipher block size, otherwise you must manually pad the end of your
	message (either with zeroes or with whatever your protocol requires).
	End Rem
	Method Encrypt:Int(pt:Byte Ptr, ct:Byte Ptr, length:UInt)
		Return bmx_crypto_ctr_encrypt(modePtr, pt, ct, length)
	End Method
	
	Rem
	bbdoc: Decrypts the ciphertext @ct of @length to @pt.
	returns: CRYPT_OK on success.
	End Rem
	Method Decrypt:Int(ct:Byte Ptr, pt:Byte Ptr, length:UInt)
		Return bmx_crypto_ctr_decrypt(modePtr, ct, pt, length)
	End Method

	Rem
	bbdoc: Reads the IV out of the chaining mode, and stores it in @IV along with the @length of the IV.
	End Rem
	Method GetIV:Int(IV:Byte Ptr, length:UInt Var)
		Return bmx_crypto_ctr_getiv(modePtr, IV, length)
	End Method
	
	Rem
	bbdoc: Initializes the chaining mode state as if the original IV were the new IV specified.
	about: The @length of @IV must be the size of the cipher block size.
	
	This method is handy if you wish to change the IV without re–keying the cipher.

	The IV is encrypted as if it were the prior encrypted pad.
	End Rem
	Method SetIV:Int(IV:Byte Ptr, length:UInt)
		Return bmx_crypto_ctr_setiv(modePtr, IV, length)
	End Method

	Rem
	bbdoc: Terminates the cipher stream.
	End Rem
	Method Done:Int()
		Return bmx_crypto_ctr_done(modePtr)
	End Method

End Type
