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

Import Crypto.Cipher


Import "../libtomcrypt.mod/libtomcrypt/src/headers/*.h"
Import "../libtomcrypt.mod/libtomcrypt/src/ciphers/blowfish.c"

Import "glue.c"

Extern

	Function bmx_crypto_blowfish_register:Int()
	Function bmx_crypto_blowfish_keysize:Int(key:Int)

	Function blowfish_setup:Int(key:Byte Ptr, keylen:Int, rounds:Int, skey:Byte Ptr)
	Function blowfish_ecb_encrypt:Int(pt:Byte Ptr, ct:Byte Ptr, skey:Byte Ptr)
	Function blowfish_ecb_decrypt:Int(ct:Byte Ptr, pt:Byte Ptr, skey:Byte Ptr)
	Function blowfish_done(skey:Byte Ptr)
		
End Extern
