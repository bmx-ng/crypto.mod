/* SPDX-License-Identifier: 0BSD */
/* Follow upstream CPU/endian detection, including Android's arm64v8a target. */
#include "blake3/blake3_impl.h"
#if BLAKE3_USE_NEON == 1
#include "blake3/blake3_neon.c"
#endif
