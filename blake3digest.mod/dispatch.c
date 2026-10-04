/* SPDX-License-Identifier: 0BSD */
#include "compiler_compat.h"

#if BMX_BLAKE3_NO_AVX512 && !defined(BLAKE3_NO_AVX512)
#define BLAKE3_NO_AVX512
#endif

#include "blake3/blake3_dispatch.c"
