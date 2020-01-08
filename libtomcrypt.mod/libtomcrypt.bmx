SuperStrict


Module Crypto.libtomcrypt

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"

Import "libtomcrypt/src/headers/*.h"

Import "libtomcrypt/src/misc/base16/base16_decode.c"
Import "libtomcrypt/src/misc/base16/base16_encode.c"

Import "libtomcrypt/src/misc/compare_testvector.c"
Import "libtomcrypt/src/misc/crypt/crypt_argchk.c"
Import "libtomcrypt/src/misc/zeromem.c"
