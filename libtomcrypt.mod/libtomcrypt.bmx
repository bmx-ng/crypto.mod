SuperStrict


Module Crypto.libtomcrypt

ModuleInfo "Version: 1.01"
ModuleInfo "Author: Frank Denis."
ModuleInfo "License: ISC"
ModuleInfo "Credit: Adapted for BlitzMax by Bruce A Henderson"

ModuleInfo "History: 1.01"
ModuleInfo "History: Updated to libtomcrypt 1.18.2.3474ca3"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release."

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"

Import "common.bmx"

Import "libtomcrypt/src/headers/*.h"

Import "libtomcrypt/src/misc/base16/base16_decode.c"
Import "libtomcrypt/src/misc/base16/base16_encode.c"

Import "libtomcrypt/src/misc/compare_testvector.c"
Import "libtomcrypt/src/misc/crypt/crypt_argchk.c"
Import "libtomcrypt/src/misc/zeromem.c"
