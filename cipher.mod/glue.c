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

BBArray * bmx_crypto_listCiphers() {
	int count = 0;
	for (int i = 0; i < TAB_SIZE; i++) {
		if (cipher_descriptor[i].name != NULL ) {
			count++;
		}
	}

	if (count == 0) {
		return &bbEmptyArray;
	}
	
	int n = 0;
	BBArray * arr = bbArrayNew1D("$", count);
	BBString **s=(BBString**)BBARRAYDATA( arr,arr->dims );
	for (int i=0; i < count; i++) {
		while ( n < TAB_SIZE) {
			if (cipher_descriptor[n++].name != NULL) {
				break;
			}
		}
		if (n <= TAB_SIZE && cipher_descriptor[n-1].name != NULL) {
			s[i] = bbStringFromUTF8String(cipher_descriptor[n-1].name);
		}
	}
	return arr;
}

int bmx_crypto_findCipher(BBString * name) {
	if (name == &bbEmptyString) {
		return -1;
	}
	
	char * n = bbStringToUTF8String(name);
	int res = find_cipher(n);
	bbMemFree(n);
	return res;
}

symmetric_key * bmx_crypto_symmetric_key_new() {
	return (symmetric_key*)malloc(sizeof(symmetric_key));
}

void bmx_crypto_symmetric_key_free(symmetric_key * key) {
	free(key);
}
