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

Import Crypto.Digest


Import "../libtomcrypt.mod/libtomcrypt/src/headers/*.h"
Import "../libtomcrypt.mod/libtomcrypt/src/misc/crc32.c"

Import "glue.c"


Extern

	Function bmx_digest_crc32_init:Byte Ptr()
	Function bmx_digest_crc32_update(handle:Byte Ptr, buf:Byte Ptr, length:Int)
	Function bmx_digest_crc32_finish(handle:Byte Ptr, out:Byte Ptr, size:Int)
	Function bmx_digest_crc32_finish_int(handle:Byte Ptr, out:Int Var)

End Extern
