/*
  Copyright (C) 2019-2020 Bruce A Henderson

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/
#include "tomcrypt.h"
#include "brl.mod/blitz.mod/blitz.h"

symmetric_xts * bmx_crypto_xts_start(int cipher, const unsigned char *key1, const unsigned char *key2, int keylen, int numRounds) {
	symmetric_xts * xts = malloc(sizeof(symmetric_xts));
	int res = xts_start(cipher, key1, key2, keylen, numRounds, xts);
	if (res != CRYPT_OK) {
		free(xts);
		xts = NULL;
	}
	return xts;
}

int bmx_crypto_xts_encrypt(symmetric_xts * xts, const unsigned char * pt, BBUINT ptlength, unsigned char * ct, const unsigned char * tweak) {
	return xts_encrypt(pt, ptlength, ct, tweak, xts);
}

int bmx_crypto_xts_decrypt(symmetric_xts * xts, const unsigned char * ct, BBUINT ptlength, unsigned char * pt, const unsigned char * tweak) {
	return xts_decrypt(ct, ptlength, pt, tweak, xts);
}

int bmx_crypto_xts_done(symmetric_xts * xts) {
	xts_done(xts);
	free(xts);
	return 1;
}
