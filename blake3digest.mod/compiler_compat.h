/* SPDX-License-Identifier: 0BSD */
#ifndef BMX_BLAKE3_COMPILER_COMPAT_H
#define BMX_BLAKE3_COMPILER_COMPAT_H

/*
 * GCC 7 and older can emit AVX-512 assembly which their accompanying GNU
 * assembler rejects (notably vmovdqu with an invalid register operand). Keep
 * the runtime-dispatched AVX2/SSE implementations on those toolchains, but do
 * not build or advertise the AVX-512 implementation.
 */
#if !defined(BMX_BLAKE3_NO_AVX512)
#if defined(__GNUC__) && !defined(__clang__) && __GNUC__ < 8
#define BMX_BLAKE3_NO_AVX512 1
#else
#define BMX_BLAKE3_NO_AVX512 0
#endif
#endif

#endif
