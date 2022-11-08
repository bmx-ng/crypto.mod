SuperStrict

Rem
bbdoc: Result OK
End Rem
Const CRYPT_OK:Int = 0

Rem
bbdoc: Generic Error
End Rem
Const CRYPT_ERROR:Int = 1

Rem
bbdoc: Not a failure but no operation was performed
End Rem
Const CRYPT_NOP:Int = 2

Rem
bbdoc: Invalid key size given
End Rem
Const CRYPT_INVALID_KEYSIZE:Int = 3

Rem
bbdoc: Invalid number of rounds
End Rem
Const CRYPT_INVALID_ROUNDS:Int = 4

Rem
bbdoc: Algorithm failed test vectors
End Rem
Const CRYPT_FAIL_TESTVECTOR:Int = 5

Rem
bbdoc: Not enough space for output
End Rem
Const CRYPT_BUFFER_OVERFLOW:Int = 6

Rem
bbdoc: Invalid input packet given
End Rem
Const CRYPT_INVALID_PACKET:Int = 7

Rem
bbdoc: Invalid number of bits for a PRNG
End Rem
Const CRYPT_INVALID_PRNGSIZE:Int = 8

Rem
bbdoc: Could not read enough from PRNG
End Rem
Const CRYPT_ERROR_READPRNG:Int = 9

Rem
bbdoc: Invalid cipher specified
End Rem
Const CRYPT_INVALID_CIPHER:Int = 10

Rem
bbdoc: Invalid hash specified
End Rem
Const CRYPT_INVALID_HASH:Int = 11

Rem
bbdoc: Invalid PRNG specified
End Rem
Const CRYPT_INVALID_PRNG:Int = 12

Rem
bbdoc: Out of memory
End Rem
Const CRYPT_MEM:Int = 13

Rem
bbdoc: Not equivalent types of PK keys
End Rem
Const CRYPT_PK_TYPE_MISMATCH:Int = 14

Rem
bbdoc: Requires a private PK key
End Rem
Const CRYPT_PK_NOT_PRIVATE:Int = 15

Rem
bbdoc: Generic invalid argument
End Rem
Const CRYPT_INVALID_ARG:Int = 16

Rem
bbdoc: File Not Found
End Rem
Const CRYPT_FILE_NOTFOUND:Int = 17

Rem
bbdoc: Invalid type of PK key
End Rem
Const CRYPT_PK_INVALID_TYPE:Int = 18

Rem
bbdoc: An overflow of a value was detected/prevented
End Rem
Const CRYPT_OVERFLOW:Int = 19

Rem
bbdoc: An error occurred while en- or decoding ASN.1 data
End Rem
Const CRYPT_PK_ASN1_ERROR:Int = 20

Rem
bbdoc: The input was longer than expected.
End Rem
Const CRYPT_INPUT_TOO_LONG:Int = 21


Rem
bbdoc: Invalid size input for PK parameters
End Rem
Const CRYPT_PK_INVALID_SIZE:Int = 22

Rem
bbdoc: Invalid size of prime requested
End Rem
Const CRYPT_INVALID_PRIME_SIZE:Int = 23

Rem
bbdoc: Invalid padding on input
End Rem
Const CRYPT_PK_INVALID_PADDING:Int = 24

Rem
bbdoc: Hash applied to too many bits
End Rem
Const CRYPT_HASH_OVERFLOW:Int = 25


Rem
bbdoc: This exception is thrown when a particular cryptographic algorithm is requested but is not available in the environment.
End Rem
Type TNoSuchAlgorithmException Extends TBlitzException

	Field message:String

	Method New(message:String)
		Self.message = message
	End Method

	Method ToString:String() Override
		Return message
	End Method

End Type


Const LTC_PAD_PKCS7:UInt        = $0000:UInt
Const LTC_PAD_ANSI_X923:UInt    = $2000:UInt
Const LTC_PAD_SSH:UInt          = $3000:UInt
Const LTC_PAD_ONE_AND_ZERO:UInt = $8000:UInt
Const LTC_PAD_ZERO:UInt         = $9000:UInt
Const LTC_PAD_ZERO_ALWAYS:UInt  = $A000:UInt
