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

Import Crypto.libtomcrypt
Import pub.stdc

Import "../libtomcrypt.mod/libtomcrypt/src/headers/*.h"

Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_argchk.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_cipher_descriptor.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_cipher_is_valid.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_constants.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_find_cipher.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_find_cipher_any.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_find_cipher_id.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_inits.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_ltc_mp_descriptor.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_register_all_ciphers.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_register_cipher.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_register_hash.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_sizes.c"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crypt/crypt_unregister_cipher.c"


Import "glue.c"

Extern

	Function bmx_crypto_listCiphers:String[]()
	Function bmx_crypto_findCipher:Int(name:String)
	
End Extern
