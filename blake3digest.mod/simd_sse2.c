/* SPDX-License-Identifier: 0BSD */
/* Limit ISA-specific instructions to this translation unit. */
#include <immintrin.h>
#if defined(__clang__)
#pragma clang attribute push(__attribute__((target("sse2"))), apply_to = function)
#elif defined(__GNUC__)
#pragma GCC push_options
#pragma GCC target("sse2")
#endif
#include "blake3/blake3_sse2.c"
#if defined(__clang__)
#pragma clang attribute pop
#elif defined(__GNUC__)
#pragma GCC pop_options
#endif
