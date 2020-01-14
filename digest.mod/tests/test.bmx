SuperStrict

Framework brl.standardio
Import Crypto.md5digest
Import Crypto.sha1digest
Import Crypto.sha256digest
Import Crypto.sha512digest
Import Crypto.crc32
Import Crypto.WhirlpoolDigest
Import Crypto.sha3digest
Import Crypto.ripemd320digest
Import Crypto.ripemd256digest
Import Crypto.ripemd160digest
Import Crypto.ripemd128digest
Import Crypto.blake2bdigest
Import Crypto.TigerDigest
Import BRL.MaxUnit

New TTestSuite.run()

Type TDigestTest Extends TTest

	Const TEST_PHRASE:String = "The quick brown fox jumps over the lazy dog"

	Const MD5_HASH_STRING:String = "9e107d9d372bb6826bd81d3542a419d6"
	Global MD5_HASH_ARRAY:Byte[] = [158, 16, 125, 157, 55, 43, 182, 130, 107, 216, 29, 53, 66, 164, 25, 214]

	Const SHA1_HASH_STRING:String = "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12"
	Global SHA1_HASH_ARRAY:Byte[] = [47, 212, 225, 198, 122, 45, 40, 252, 237, 132, 158, 225, 187, 118, 231, 57, 27, 147, 235, 18]
	
	Const SHA256_HASH_STRING:String = "d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592"
	Global SHA256_HASH_ARRAY:Byte[] = [215, 168, 251, 179, 7, 215, 128, 148, 105, 202, 154, 188, 176, 8, 46, 79, 141, 86, 81, 228, 109, 60, 219, 118, 45, 2, 208, 191, 55, 201, 229, 146]
	
	Const SHA512_HASH_STRING:String = "07e547d9586f6a73f73fbac0435ed76951218fb7d0c8d788a309d785436bbb642e93a252a954f23912547d1e8a3b5ed6e1bfd7097821233fa0538f3db854fee6"
	Global SHA512_HASH_ARRAY:Byte[] = [7, 229, 71, 217, 88, 111, 106, 115, 247, 63, 186, 192, 67, 94, 215, 105, 81, 33, 143, 183, 208, 200, 215, ..
									136, 163, 9, 215, 133, 67, 107, 187, 100, 46, 147, 162, 82, 169, 84, 242, 57, 18, 84, 125, 30, 138, 59, 94, ..
									214, 225, 191, 215, 9, 120, 33, 35, 63, 160, 83, 143, 61, 184, 84, 254, 230]

	Const CRC32_HASH_STRING:String = "414fa339"
	Global CRC32_HASH_ARRAY:Byte[] = [65, 79, 163, 57]
	Const CRC32_INT:Int = 1095738169
	
	Const WHIRLPOOL_HASH_STRING:String = "b97de512e91e3828b40d2b0fdce9ceb3c4a71f9bea8d88e75c4fa854df36725fd2b52eb6544edcacd6f8beddfea403cb55ae31f03ad62a5ef54e42ee82c3fb35"
	Global WHIRLPOOL_HASH_ARRAY:Byte[] = [185, 125, 229, 18, 233, 30, 56, 40, 180, 13, 43, 15, 220, 233, 206, 179, 196, 167, 31, 155, 234, 141, ..
										136, 231, 92, 79, 168, 84, 223, 54, 114, 95, 210, 181, 46, 182, 84, 78, 220, 172, 214, 248, 190, 221, ..
										254, 164, 3, 203, 85, 174, 49, 240, 58, 214, 42, 94, 245, 78, 66, 238, 130, 195, 251, 53]

	Const SHA3_512_HASH_STRING:String = "01dedd5de4ef14642445ba5f5b97c15e47b9ad931326e4b0727cd94cefc44fff23f07bf543139939b49128caf436dc1bdee54fcb24023a08d9403f9b4bf0d450"
	Global SHA3_512_HASH_ARRAY:Byte[] = [1, 222, 221, 93, 228, 239, 20, 100, 36, 69, 186, 95, 91, 151, 193, 94, 71, 185, 173, 147, 19, 38, 228, ..
										176, 114, 124, 217, 76, 239, 196, 79, 255, 35, 240, 123, 245, 67, 19, 153, 57, 180, 145, 40, 202, 244, ..
										54, 220, 27, 222, 229, 79, 203, 36, 2, 58, 8, 217, 64, 63, 155, 75, 240, 212, 80]
	
	Const SHA3_384_HASH_STRING:String = "7063465e08a93bce31cd89d2e3ca8f602498696e253592ed26f07bf7e703cf328581e1471a7ba7ab119b1a9ebdf8be41"
	Global SHA3_384_HASH_ARRAY:Byte[] = [112, 99, 70, 94, 8, 169, 59, 206, 49, 205, 137, 210, 227, 202, 143, 96, 36, 152, 105, 110, 37, 53, ..
										146, 237, 38, 240, 123, 247, 231, 3, 207, 50, 133, 129, 225, 71, 26, 123, 167, 171, 17, 155, 26, 158, ..
										189, 248, 190, 65]
	
	Const SHA3_256_HASH_STRING:String = "69070dda01975c8c120c3aada1b282394e7f032fa9cf32f4cb2259a0897dfc04"
	Global SHA3_256_HASH_ARRAY:Byte[] = [105, 7, 13, 218, 1, 151, 92, 140, 18, 12, 58, 173, 161, 178, 130, 57, 78, 127, 3, 47, 169, 207, 50, ..
										244, 203, 34, 89, 160, 137, 125, 252, 4]
	
	Const SHA3_224_HASH_STRING:String = "d15dadceaa4d5d7bb3b48f446421d542e08ad8887305e28d58335795"
	Global SHA3_224_HASH_ARRAY:Byte[] = [209, 93, 173, 206, 170, 77, 93, 123, 179, 180, 143, 68, 100, 33, 213, 66, 224, 138, 216, 136, 115, 5, ..
										226, 141, 88, 51, 87, 149]

	Const RIPEMD_320_HASH_STRING:String = "e7660e67549435c62141e51c9ab1dcc3b1ee9f65c0b3e561ae8f58c5dba3d21997781cd1cc6fbc34"
	Global RIPEMD_320_HASH_ARRAY:Byte[] = [231, 102, 14, 103, 84, 148, 53, 198, 33, 65, 229, 28, 154, 177, 220, 195, 177, 238, 159, 101, 192, ..
										179, 229, 97, 174, 143, 88, 197, 219, 163, 210, 25, 151, 120, 28, 209, 204, 111, 188, 52]

	Const RIPEMD_256_HASH_STRING:String = "c3b0c2f764ac6d576a6c430fb61a6f2255b4fa833e094b1ba8c1e29b6353036f"
	Global RIPEMD_256_HASH_ARRAY:Byte[] = [195, 176, 194, 247, 100, 172, 109, 87, 106, 108, 67, 15, 182, 26, 111, 34, 85, 180, 250, 131, 62, 9, ..
										75, 27, 168, 193, 226, 155, 99, 83, 3, 111]

	Const RIPEMD_160_HASH_STRING:String = "37f332f68db77bd9d7edd4969571ad671cf9dd3b"
	Global RIPEMD_160_HASH_ARRAY:Byte[] = [55, 243, 50, 246, 141, 183, 123, 217, 215, 237, 212, 150, 149, 113, 173, 103, 28, 249, 221, 59]

	Const RIPEMD_128_HASH_STRING:String = "3fa9b57f053c053fbe2735b2380db596"
	Global RIPEMD_128_HASH_ARRAY:Byte[] = [63, 169, 181, 127, 5, 60, 5, 63, 190, 39, 53, 178, 56, 13, 181, 150]

	Const BLAKE2B_512_HASH_STRING:String = "a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918"
	Global BLAKE2B_512_HASH_ARRAY:Byte[] = [168, 173, 212, 189, 221, 253, 147, 228, 135, 125, 39, 70, 230, 40, 23, 177, 22, 54, 74, 31, 167, ..
										188, 20, 141, 149, 9, 11, 199, 51, 59, 54, 115, 248, 36, 1, 207, 122, 162, 228, 203, 30, 205, 144, 41, ..
										110, 63, 20, 203, 84, 19, 248, 237, 119, 190, 115, 4, 91, 19, 145, 76, 220, 214, 169, 24]

	Const BLAKE2B_384_HASH_STRING:String = "b7c81b228b6bd912930e8f0b5387989691c1cee1e65aade4da3b86a3c9f678fc8018f6ed9e2906720c8d2a3aeda9c03d"
	Global BLAKE2B_384_HASH_ARRAY:Byte[] = [183, 200, 27, 34, 139, 107, 217, 18, 147, 14, 143, 11, 83, 135, 152, 150, 145, 193, 206, 225, 230, ..
										90, 173, 228, 218, 59, 134, 163, 201, 246, 120, 252, 128, 24, 246, 237, 158, 41, 6, 114, 12, 141, 42, ..
										58, 237, 169, 192, 61]

	Const BLAKE2B_256_HASH_STRING:String = "01718cec35cd3d796dd00020e0bfecb473ad23457d063b75eff29c0ffa2e58a9"
	Global BLAKE2B_256_HASH_ARRAY:Byte[] = [1, 113, 140, 236, 53, 205, 61, 121, 109, 208, 0, 32, 224, 191, 236, 180, 115, 173, 35, 69, 125, 6, ..
										59, 117, 239, 242, 156, 15, 250, 46, 88, 169]

	Const BLAKE2B_160_HASH_STRING:String = "3c523ed102ab45a37d54f5610d5a983162fde84f"
	Global BLAKE2B_160_HASH_ARRAY:Byte[] = [60, 82, 62, 209, 2, 171, 69, 163, 125, 84, 245, 97, 13, 90, 152, 49, 98, 253, 232, 79]

	Const TIGER_HASH_STRING:String = "6d12a41e72e644f017b6f0e2f7b44c6285f06dd5d2c5b075"
	Global TIGER_HASH_ARRAY:Byte[] = [109, 18, 164, 30, 114, 230, 68, 240, 23, 182, 240, 226, 247, 180, 76, 98, 133, 240, 109, 213, 210, 197, 176, 117]

	Method testMD5() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("MD5")
	
		assertEquals(MD5_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(MD5_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until MD5_HASH_ARRAY.length
			assertEquals(MD5_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testSHA1() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("SHA1")
	
		assertEquals(SHA1_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(SHA1_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until SHA1_HASH_ARRAY.length
			assertEquals(SHA1_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testSHA256() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("SHA256")
	
		assertEquals(SHA256_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(SHA256_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until SHA256_HASH_ARRAY.length
			assertEquals(SHA256_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testSHA512() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("SHA512")
	
		assertEquals(SHA512_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(SHA512_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until SHA512_HASH_ARRAY.length
			assertEquals(SHA512_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testCRC32() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("CRC32")
	
		assertEquals(CRC32_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(CRC32_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until CRC32_HASH_ARRAY.length
			assertEquals(CRC32_HASH_ARRAY[i], bytes[i])
		Next
		
		Local crc32:TCRC32 = TCRC32(digest)
		Local result:Int
		crc32.Digest(TEST_PHRASE, result)
		
		assertEquals(CRC32_INT, result)
	
	End Method

	Method testWhirlpool() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("WHIRLPOOL")
	
		assertEquals(WHIRLPOOL_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(WHIRLPOOL_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until WHIRLPOOL_HASH_ARRAY.length
			assertEquals(WHIRLPOOL_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testSHA3512() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("SHA3-512")
	
		assertEquals(SHA3_512_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(SHA3_512_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until SHA3_512_HASH_ARRAY.length
			assertEquals(SHA3_512_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testSHA3384() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("SHA3-384")
	
		assertEquals(SHA3_384_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(SHA3_384_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until SHA3_384_HASH_ARRAY.length
			assertEquals(SHA3_384_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testSHA3256() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("SHA3-256")
	
		assertEquals(SHA3_256_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(SHA3_256_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until SHA3_256_HASH_ARRAY.length
			assertEquals(SHA3_256_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testRipemd320() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("RIPEMD-320")
	
		assertEquals(RIPEMD_320_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(RIPEMD_320_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until RIPEMD_320_HASH_ARRAY.length
			assertEquals(RIPEMD_320_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testRipemd256() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("RIPEMD-256")
	
		assertEquals(RIPEMD_256_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(RIPEMD_256_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until RIPEMD_256_HASH_ARRAY.length
			assertEquals(RIPEMD_256_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testRipemd160() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("RIPEMD-160")
	
		assertEquals(RIPEMD_160_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(RIPEMD_160_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until RIPEMD_160_HASH_ARRAY.length
			assertEquals(RIPEMD_160_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testRipemd128() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("RIPEMD-128")
	
		assertEquals(RIPEMD_128_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(RIPEMD_128_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until RIPEMD_128_HASH_ARRAY.length
			assertEquals(RIPEMD_128_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testBlake2B512() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("BLAKE2B-512")
	
		assertEquals(BLAKE2B_512_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(BLAKE2B_512_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until BLAKE2B_512_HASH_ARRAY.length
			assertEquals(BLAKE2B_512_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testBlake2B384() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("BLAKE2B-384")
	
		assertEquals(BLAKE2B_384_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(BLAKE2B_384_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until BLAKE2B_384_HASH_ARRAY.length
			assertEquals(BLAKE2B_384_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testBlake2B256() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("BLAKE2B-256")
	
		assertEquals(BLAKE2B_256_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(BLAKE2B_256_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until BLAKE2B_256_HASH_ARRAY.length
			assertEquals(BLAKE2B_256_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testBlake2B160() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("BLAKE2B-160")
	
		assertEquals(BLAKE2B_160_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(BLAKE2B_160_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until BLAKE2B_160_HASH_ARRAY.length
			assertEquals(BLAKE2B_160_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

	Method testTiger() { test }
	
		Local digest:TMessageDigest = GetMessageDigest("TIGER")
	
		assertEquals(TIGER_HASH_STRING, digest.Digest(TEST_PHRASE))
	
		Local bytes:Byte[] = digest.DigestBytes(TEST_PHRASE)

		assertEquals(TIGER_HASH_ARRAY.length, bytes.length)
		
		For Local i:Int = 0 Until TIGER_HASH_ARRAY.length
			assertEquals(TIGER_HASH_ARRAY[i], bytes[i])
		Next
	
	End Method

End Type
