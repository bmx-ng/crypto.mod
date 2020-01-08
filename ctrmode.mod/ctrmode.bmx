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
bbdoc: Counter mode
about: A mode which only uses the encryption function of the cipher.

The initialization vector is treated as a large binary counter.

As long as the initialization vector is random for each message encrypted under the same key replay and swap attacks are infeasible.
CTR mode may look simple but it is as secure as the block cipher is under a chosen plaintext attack (provided the initialization vector is unique).
End Rem
Module Crypto.CTRMode

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE -DLTC_CTR_MODE"

Import "common.bmx"

Enum ECTRCounterMode
	LITTLE_ENDIAN = $0000
	BIG_ENDIAN = $1000
	RFC3686 = $2000
End Enum

Rem
bbdoc: 
End Rem
Type TCTRCipherMode Extends TCipherMode

	Rem
	bbdoc: 
	End Rem
	Method Start:Int(cipher:TCipher, iv:Byte Ptr, key:Byte Ptr, keylen:Int, numRounds:Int, counterMode:ECTRCounterMode)
		Local res:Int
		modePtr = bmx_crypto_ctr_start(cipher.index, iv, key, keylen, numRounds, counterMode.Ordinal(), res)
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
	bbdoc: 
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