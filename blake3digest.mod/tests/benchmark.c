/* SPDX-License-Identifier: 0BSD */
#include "../blake3/blake3.h"
#include <stdint.h>
#include <time.h>

double bmx_blake3_benchmark_time(void) {
    return (double)clock() / CLOCKS_PER_SEC;
}

size_t bmx_blake3_benchmark_state_size(void) {
    return sizeof(blake3_hasher);
}

void bmx_blake3_benchmark_native(const void *data, size_t size, int count,
                               uint8_t *output) {
    blake3_hasher state;
    blake3_hasher_init(&state);
    for (int i = 0; i < count; ++i) blake3_hasher_update(&state, data, size);
    blake3_hasher_finalize(&state, output, BLAKE3_OUT_LEN);
}
