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

symmetric_F8 * bmx_crypto_f8_start(int cipher, const unsigned char *IV, const unsigned char *key, int keylen, const unsigned char * saltkey, int saltkeylen, int numRounds) {
	symmetric_F8 * f8 = malloc(sizeof(symmetric_F8));
	int res = f8_start(cipher, IV, key, keylen, saltkey, saltkeylen, numRounds, f8);
	if (res != CRYPT_OK) {
		free(f8);
		f8 = NULL;
	}
	return f8;
}

int bmx_crypto_f8_encrypt(symmetric_F8 * f8, const unsigned char * pt, unsigned char * ct, BBUINT length) {
	return f8_encrypt(pt, ct, length, f8);
}

int bmx_crypto_f8_decrypt(symmetric_F8 * f8, const unsigned char * ct, unsigned char * pt, BBUINT length) {
	return f8_decrypt(ct, pt, length, f8);
}

int bmx_crypto_f8_getiv(symmetric_F8 * f8, unsigned char * IV, BBUINT * length) {
	unsigned long len;
	int res = f8_getiv(IV, &len, f8);
	*length = len;
	return res;
}

int bmx_crypto_f8_setiv(symmetric_F8 * f8, const unsigned char * IV, BBUINT length) {
	return f8_setiv(IV, length, f8);
}

int bmx_crypto_f8_done(symmetric_F8 * f8) {
	int res = f8_done(f8);
	free(f8);
	return res;
}
