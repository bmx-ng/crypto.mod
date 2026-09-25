/* SPDX-License-Identifier: 0BSD */
#include "blake3/blake3.h"
#include <stdlib.h>

blake3_hasher *bmx_blake3_new(void) {
    blake3_hasher *state = calloc(1, sizeof(*state));
    if (state) blake3_hasher_init(state);
    return state;
}

void bmx_blake3_free(blake3_hasher *state) {
    if (state) {
        volatile unsigned char *p = (volatile unsigned char *)state;
        size_t length = sizeof(*state);
        while (length--) *p++ = 0;
        free(state);
    }
}

int bmx_blake3_keyed(blake3_hasher *state, const unsigned char *key, int length) {
    if (!state || !key || length != BLAKE3_KEY_LEN) return -1;
    blake3_hasher_init_keyed(state, key);
    return 0;
}

int bmx_blake3_derive(blake3_hasher *state, const void *context, size_t length) {
    if (!state || (!context && length)) return -1;
    blake3_hasher_init_derive_key_raw(state, context, length);
    return 0;
}

int bmx_blake3_update(blake3_hasher *state, const void *data, size_t length) {
    if (!state || (!data && length)) return -1;
    if (length) blake3_hasher_update(state, data, length);
    return 0;
}

int bmx_blake3_output(const blake3_hasher *state, unsigned char *output,
                     int length, uint64_t seek) {
    if (!state || length < 0 || (!output && length)) return -1;
    /* Prevent the output position from wrapping during a multi-block read. */
    if (length && (uint64_t)(length - 1) > UINT64_MAX - seek) return -1;
    if (length) blake3_hasher_finalize_seek(state, seek, output, (size_t)length);
    return 0;
}

void bmx_blake3_reset(blake3_hasher *state) {
    if (state) blake3_hasher_reset(state);
}
