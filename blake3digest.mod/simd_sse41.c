/* SPDX-License-Identifier: 0BSD */
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC push_options
#pragma GCC target("sse4.1")
#endif
#include <immintrin.h>
#if defined(__clang__)
#pragma clang attribute push(__attribute__((target("sse4.1"))), apply_to = function)
#endif
#include "blake3/blake3_sse41.c"
#if defined(__clang__)
#pragma clang attribute pop
#elif defined(__GNUC__)
#pragma GCC pop_options
#endif
