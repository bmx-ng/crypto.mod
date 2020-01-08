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

symmetric_OFB * bmx_crypto_ofb_start(int cipher, const unsigned char *IV, const unsigned char *key, int keylen, int numRounds) {
	symmetric_OFB * ofb = malloc(sizeof(symmetric_OFB));
	int res = ofb_start(cipher, IV, key, keylen, numRounds, ofb);
	if (res != CRYPT_OK) {
		free(ofb);
		ofb = NULL;
	}
	return ofb;
}

int bmx_crypto_ofb_encrypt(symmetric_OFB * ofb, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return ofb_encrypt(pt, ct, length, ofb);
}

int bmx_crypto_ofb_decrypt(symmetric_OFB * ofb, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return ofb_decrypt(ct, pt, length, ofb);
}

int bmx_crypto_ofb_getiv(symmetric_OFB * ofb, unsigned char * IV, BBUINT * length) {
	unsigned long len;
	int res = ofb_getiv(IV, &len, ofb);
	*length = len;
	return res;
}

int bmx_crypto_ofb_setiv(symmetric_OFB * ofb, const unsigned char * IV, BBUINT length) {
	return ofb_setiv(IV, length, ofb);
}

int bmx_crypto_ofb_done(symmetric_OFB * ofb) {
	int res = ofb_done(ofb);
	free(ofb);
	return res;
}
