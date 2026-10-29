/* SPDX-License-Identifier: 0BSD */
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC push_options
#pragma GCC target("avx2")
#endif
#include <immintrin.h>
#if defined(__clang__)
#pragma clang attribute push(__attribute__((target("avx2"))), apply_to = function)
#endif
#include "blake3/blake3_avx2.c"
#if defined(__clang__)
#pragma clang attribute pop
#elif defined(__GNUC__)
#pragma GCC pop_options
#endif
