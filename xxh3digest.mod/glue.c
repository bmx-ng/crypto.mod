/*
  Copyright (c) 2024 Bruce A Henderson
  
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
  
  1. Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.
  
  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation
     and/or other materials provided with the distribution.
  
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
#include "brl.mod/blitz.mod/hash/xxhash.h"
#include "brl.mod/blitz.mod/blitz.h"


XXH3_state_t * bmx_digest_xxh3_init() {
    XXH3_state_t* state = XXH3_createState();

    XXH3_64bits_reset(state);

    return state;
}

void bmx_digest_xxh3_free(XXH3_state_t * state) {
    XXH3_freeState(state);
}

void bmx_digest_xxh3_update(XXH3_state_t * state, char * buf, int length) {
    XXH3_64bits_update(state, buf, length);
}

void bmx_digest_xxh3_finish(XXH3_state_t * state, char * out, int size) {
    XXH64_hash_t hash = XXH3_64bits_digest(state);
    memcpy(out, &hash, size);
    XXH3_64bits_reset(state); // reset state
}

void bmx_digest_xxh3_finish_ulong(XXH3_state_t * state, BBULONG * out) {
    XXH64_hash_t hash = XXH3_64bits_digest(state);
    *out = hash;
    XXH3_64bits_reset(state); // reset state
}

void bmx_digest_xxh3_reset(XXH3_state_t * state) {
    XXH3_64bits_reset(state);
}
