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

symmetric_ECB * bmx_crypto_ecb_start(int cipher, const unsigned char *key, int keylen, int numRounds) {
	symmetric_ECB * ecb = malloc(sizeof(symmetric_ECB));
	int res = ecb_start(cipher, key, keylen, numRounds, ecb);
	if (res != CRYPT_OK) {
		free(ecb);
		ecb = NULL;
	}
	return ecb;
}

int bmx_crypto_ecb_encrypt(symmetric_ECB * ecb, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return ecb_encrypt(pt, ct, length, ecb);
}

int bmx_crypto_ecb_decrypt(symmetric_ECB * ecb, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return ecb_decrypt(ct, pt, length, ecb);
}

int bmx_crypto_ecb_done(symmetric_ECB * ecb) {
	int res = ecb_done(ecb);
	free(ecb);
	return res;
}
