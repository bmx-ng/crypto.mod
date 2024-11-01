SuperStrict

Framework brl.standardio
Import crypto.xxh3digest
Import BRL.MaxUnit

New TTestSuite.run()

Type TXXH3DigestTest Extends TTest

	Method testGetMessageDigest() { test }
		Local digest:TMessageDigest = GetMessageDigest("XXH3")
		AssertNotNull(digest)
		AssertNotNull(TXXH3Digest(digest))
	End Method

	Method testStringDigest() { test }
		Local digest:TXXH3Digest = New TXXH3Digest

		Local result:ULong
		digest.Digest("Hello, World!", result)

		AssertEquals($a3b37b0560760792:ULong, result)

		Local hello:String = "Hello, "
		Local world:String = "World!"

		digest.Digest(hello + world, result)

		AssertEquals($a3b37b0560760792:ULong, result)
	End Method

	Method testByteArray() { test }
		Local digest:TXXH3Digest = New TXXH3Digest

		Local data:Byte[] = LoadByteArray( "story.txt" )

		digest.Update(data, data.Length)

		Local result:ULong
		digest.Finish(result)

		AssertEquals($5dfa86a4afb8e7d1:ULong, result)

	End Method

	Method testStreamDigest() { test }
		Local digest:TXXH3Digest = New TXXH3Digest

		Local result:ULong
		Local stream:TStream = ReadStream("story.txt")
		digest.Digest(stream, result)

		AssertEquals($5dfa86a4afb8e7d1:ULong, result)
	End Method
End Type
