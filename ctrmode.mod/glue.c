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

symmetric_CTR * bmx_crypto_ctr_start(int cipher, const unsigned char *IV, const unsigned char *key, int keylen, int numRounds, int counterMode, int * res) {
	symmetric_CTR * ctr = malloc(sizeof(symmetric_CTR));
	*res = ctr_start(cipher, IV, key, keylen, numRounds, counterMode, ctr);
	if (*res != CRYPT_OK) {
		free(ctr);
		ctr = NULL;
	}
	return ctr;
}

int bmx_crypto_ctr_encrypt(symmetric_CTR * ctr, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return ctr_encrypt(pt, ct, length, ctr);
}

int bmx_crypto_ctr_decrypt(symmetric_CTR * ctr, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return ctr_decrypt(ct, pt, length, ctr);
}

int bmx_crypto_ctr_getiv(symmetric_CTR * ctr, unsigned char * IV, BBUINT * length) {
	unsigned long len;
	int res = ctr_getiv(IV, &len, ctr);
	*length = len;
	return res;
}

int bmx_crypto_ctr_setiv(symmetric_CTR * ctr, const unsigned char * IV, BBUINT length) {
	return ctr_setiv(IV, length, ctr);
}

int bmx_crypto_ctr_done(symmetric_CTR * ctr) {
	int res = ctr_done(ctr);
	free(ctr);
	return res;
}
