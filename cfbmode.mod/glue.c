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

symmetric_CFB * bmx_crypto_cfb_start(int cipher, const unsigned char *IV, const unsigned char *key, int keylen, int numRounds) {
	symmetric_CFB * cfb = malloc(sizeof(symmetric_CFB));
	int res = cfb_start(cipher, IV, key, keylen, numRounds, cfb);
	if (res != CRYPT_OK) {
		free(cfb);
		cfb = NULL;
	}
	return cfb;
}

int bmx_crypto_cfb_encrypt(symmetric_CFB * cfb, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return cfb_encrypt(pt, ct, length, cfb);
}

int bmx_crypto_cfb_decrypt(symmetric_CFB * cfb, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return cfb_decrypt(ct, pt, length, cfb);
}

int bmx_crypto_cfb_getiv(symmetric_CFB * cfb, unsigned char * IV, BBUINT * length) {
	unsigned long len;
	int res = cfb_getiv(IV, &len, cfb);
	*length = len;
	return res;
}

int bmx_crypto_cfb_setiv(symmetric_CFB * cfb, const unsigned char * IV, BBUINT length) {
	return cfb_setiv(IV, length, cfb);
}

int bmx_crypto_cfb_done(symmetric_CFB * cfb) {
	int res = cfb_done(cfb);
	free(cfb);
	return res;
}
