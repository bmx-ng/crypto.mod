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

Import Crypto.Cipher

Import "../libtomcrypt.mod/libtomcrypt/src/headers/*.h"
Import "../libtomcrypt.mod/libtomcrypt/src/modes/ofb/ofb_decrypt.c"
Import "../libtomcrypt.mod/libtomcrypt/src/modes/ofb/ofb_done.c"
Import "../libtomcrypt.mod/libtomcrypt/src/modes/ofb/ofb_encrypt.c"
Import "../libtomcrypt.mod/libtomcrypt/src/modes/ofb/ofb_getiv.c"
Import "../libtomcrypt.mod/libtomcrypt/src/modes/ofb/ofb_setiv.c"
Import "../libtomcrypt.mod/libtomcrypt/src/modes/ofb/ofb_start.c"

Import "glue.c"

Extern

	Function bmx_crypto_ofb_start:Byte Ptr(index:Int, iv:Byte Ptr, key:Byte Ptr, keylen:Int, numRounds:Int, res:Int Var)
	Function bmx_crypto_ofb_encrypt:Int(handle:Byte Ptr, pt:Byte Ptr, ct:Byte Ptr, length:UInt)
	Function bmx_crypto_ofb_decrypt:Int(handle:Byte Ptr, ct:Byte Ptr, pt:Byte Ptr, length:UInt)
	Function bmx_crypto_ofb_getiv:Int(handle:Byte Ptr, IV:Byte Ptr, length:UInt Var)
	Function bmx_crypto_ofb_setiv:Int(handle:Byte Ptr, IV:Byte Ptr, length:UInt)
	Function bmx_crypto_ofb_done:Int(handle:Byte Ptr)
		
End Extern
