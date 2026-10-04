/* SPDX-License-Identifier: 0BSD */
#include "compiler_compat.h"
#if !BMX_BLAKE3_NO_AVX512
#include <immintrin.h>
#if defined(__clang__)
#pragma clang attribute push(__attribute__((target("avx512f,avx512vl"))), apply_to = function)
#elif defined(__GNUC__)
#pragma GCC push_options
#pragma GCC target("avx512f,avx512vl")
#endif
#include "blake3/blake3_avx512.c"
#if defined(__clang__)
#pragma clang attribute pop
#elif defined(__GNUC__)
#pragma GCC pop_options
#endif
#endif
