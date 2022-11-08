/*
  Copyright (C) 2019-2022 Bruce A Henderson

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

symmetric_LRW * bmx_crypto_lrw_start(int cipher, const unsigned char *IV, const unsigned char *key, int keylen, const unsigned char *tweak, int numRounds) {
	symmetric_LRW * lrw = malloc(sizeof(symmetric_LRW));
	int res = lrw_start(cipher, IV, key, keylen, tweak, numRounds, lrw);
	if (res != CRYPT_OK) {
		free(lrw);
		lrw = NULL;
	}
	return lrw;
}

int bmx_crypto_lrw_encrypt(symmetric_LRW * lrw, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return lrw_encrypt(pt, ct, length, lrw);
}

int bmx_crypto_lrw_decrypt(symmetric_LRW * lrw, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return lrw_decrypt(ct, pt, length, lrw);
}

int bmx_crypto_lrw_getiv(symmetric_LRW * lrw, unsigned char * IV, BBUINT * length) {
	unsigned long len;
	int res = lrw_getiv(IV, &len, lrw);
	*length = len;
	return res;
}

int bmx_crypto_lrw_setiv(symmetric_LRW * lrw, const unsigned char * IV, BBUINT length) {
	return lrw_setiv(IV, length, lrw);
}

int bmx_crypto_lrw_done(symmetric_LRW * lrw) {
	int res = lrw_done(lrw);
	free(lrw);
	return res;
}
