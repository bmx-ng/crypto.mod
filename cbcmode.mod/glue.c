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

symmetric_CBC * bmx_crypto_cbc_start(int cipher, const unsigned char *IV, const unsigned char *key, int keylen, int numRounds) {
	symmetric_CBC * cbc = malloc(sizeof(symmetric_CBC));
	int res = cbc_start(cipher, IV, key, keylen, numRounds, cbc);
	if (res != CRYPT_OK) {
		free(cbc);
		cbc = NULL;
	}
	return cbc;
}

int bmx_crypto_cbc_encrypt(symmetric_CBC * cbc, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return cbc_encrypt(pt, ct, length, cbc);
}

int bmx_crypto_cbc_decrypt(symmetric_CBC * cbc, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return cbc_decrypt(ct, pt, length, cbc);
}

int bmx_crypto_cbc_getiv(symmetric_CBC * cbc, unsigned char * IV, BBUINT * length) {
	unsigned long len;
	int res = cbc_getiv(IV, &len, cbc);
	*length = len;
	return res;
}

int bmx_crypto_cbc_setiv(symmetric_CBC * cbc, const unsigned char * IV, BBUINT length) {
	return cbc_setiv(IV, length, cbc);
}

int bmx_crypto_cbc_done(symmetric_CBC * cbc) {
	int res = cbc_done(cbc);
	free(cbc);
	return res;
}
