/* LibTomCrypt, modular cryptographic library -- Tom St Denis
 *
 * LibTomCrypt is a library that provides various cryptographic
 * algorithms in a highly modular and flexible manner.
 *
 * The library is free for all purposes without any express
 * guarantee it works.
 */
#include "tomcrypt_private.h"

/**
   @file ecb_done.c
   ECB implementation, finish chain, Tom St Denis
*/

#ifdef LTC_ECB_MODE

/** Terminate the chain
  @param ecb    The ECB chain to terminate
  @return CRYPT_OK on success
*/
int ecb_done(symmetric_ECB *ecb)
{
   int err;
   LTC_ARGCHK(ecb != NULL);

   if ((err = cipher_is_valid(ecb->cipher)) != CRYPT_OK) {
      return err;
   }
   cipher_descriptor[ecb->cipher].done(&ecb->key);
   return CRYPT_OK;
}



#endif

/* ref:         HEAD -> develop */
/* git commit:  a1f6312416ef6cd183ee62db58b640dc2d7ec1f4 */
/* commit time: 2019-09-04 13:44:47 +0200 */
