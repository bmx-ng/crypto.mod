SuperStrict
Framework BRL.StandardIO
Import Crypto.Blake3Digest
Import BRL.BankStream

Global checks:Int
Global vectorCases:Int

Function Check(ok:Int, label:String)
	If Not ok Then
		Print "FAIL: " + label
		exit_(1)
	End If
	checks :+ 1
End Function

Function NewMode:TBlake3Digest(mode:Int)
	Select mode
		Case 1
			Local key:Byte[32]
			Local txt:String = "whats the Elvish word for friend"
			For Local i:Int = 0 Until 32
				key[i] = txt[i]
			Next
			Return TBlake3Digest.CreateKeyed(key)
		Case 2
			Return TBlake3Digest.CreateDeriveKey("BLAKE3 2019-12-27 16:29:52 test vectors context")
	End Select
	Return New TBlake3Digest
End Function

Function Vector(length:Int, hash:String, keyed:String, derived:String)
	vectorCases :+ 1
	Local data:Byte[length]
	For Local i:Int = 0 Until length
		data[i] = i Mod 251
	Next
	Local expected:String[] = [hash, keyed, derived]
	For Local mode:Int = 0 Until 3
		Local digest:TBlake3Digest = NewMode(mode)
		For Local chunk:Int = EachIn [1, 63, 64, 65, 1023, 1024, 1025, 4096, 65536]
			Local offset:Int
			While offset < length
				Local count:Int = Min(chunk, length - offset)
				Check(digest.Update(Varptr data[offset], count) = 0, "update status")
				offset :+ count
			Wend
			Check(digest.Update(Null, 0) = 0, "empty update")
			Local output:Byte[131]
			digest.Output(output)
			Check(BytesToHex(output) = expected[mode], "vector " + length + " mode " + mode + " chunk " + chunk)
			Local part:Byte[67]
			digest.Output(part, 64:ULong)
			Check(BytesToHex(part) = expected[mode][128..], "seek across output blocks")
			Local normal:Byte[40]
			For Local i:Int = 0 Until normal.length
				normal[i] = $a5
			Next
			Check(digest.Finish(normal) = 0, "finish status")
			Check(BytesToHex(normal[..32]) = expected[mode][..64], "default output")
			For Local i:Int = 32 Until 40
				Check(normal[i] = $a5, "destination tail intact")
			Next
		Next
		digest.Update(data)
		Local extended:Byte[131]
		digest.FinishXOF(extended)
		Check(BytesToHex(extended) = expected[mode], "finish XOF")
		digest.Update(data)
		digest.Reset()
		digest.Update(data)
		digest.FinishXOF(extended)
		Check(BytesToHex(extended) = expected[mode], "reset preserves mode")
	Next
	Local bank:TBank = CreateStaticBank(data, length)
	Local stream:TStream = CreateBankStream(bank)
	Check(New TBlake3Digest.Digest(stream) = hash[..64], "stream vector")
	stream.Close()
End Function

Include "vectors.bmx"

Local emptyHash:String = "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262"
Local abcHash:String = "6437b3ac38465133ffb63b75273a8db548c558465d79db03fd359c6cd5bd9d85"
For Local digestName:String = EachIn ["BLAKE3", "blake3", "BLAKE3-256", "BLAKE3_256", "BLAKE3256"]
	Check(GetMessageDigest(digestName).Digest("abc") = abcHash, "registry " + digestName)
Next
Check(ListDigests().Contains("BLAKE3"), "digest listing")

Local digest:TBlake3Digest = New TBlake3Digest
Local abc:Byte[] = [Byte(97), Byte(98), Byte(99)]
digest.Update(abc)
For Local bad:Int = 0 Until 5
	Local caught:Int
	Try
		Select bad
			Case 0
				digest.Update(Null, 1)
			Case 1
				digest.Update(abc, -1)
			Case 2
				digest.Finish(New Byte[31])
			Case 3
				digest.Finish(Null)
			Case 4
				digest.Output(New Byte[2], $ffffffffffffffff:ULong)
		End Select
	Catch error:TIllegalArgumentException
		caught = True
	End Try
	Check(caught, "invalid argument " + bad)
Next
Local result:Byte[32]
digest.Finish(result)
Check(BytesToHex(result) = abcHash, "rejected calls preserve state")
Check(digest.Digest("") = emptyHash, "finish resets state")

For Local length:Int = EachIn [0, 1, 31, 33, 64]
	Local caught:Int
	Try
		TBlake3Digest.CreateKeyed(New Byte[length])
	Catch error:TIllegalArgumentException
		caught = True
	End Try
	Check(caught, "invalid key length")
Next

Local unicode:String = "a" + Chr(0) + Chr($e9) + Chr($20ac) + Chr($d83d) + Chr($de00)
Local utf8:Byte[] = [Byte($61), Byte(0), Byte($c3), Byte($a9), Byte($e2), Byte($82), Byte($ac), Byte($f0), Byte($9f), Byte($98), Byte($80)]
digest.Update(utf8)
digest.Finish(result)
Check(digest.Digest(unicode) = BytesToHex(result), "UTF-8 including NUL and supplementary character")
Check(digest.Digest("a" + Chr(0) + "b") <> digest.Digest("a"), "NUL is not a terminator")
Local contextA:TBlake3Digest = TBlake3Digest.CreateDeriveKey("app" + Chr(0) + "purpose")
Local contextB:TBlake3Digest = TBlake3Digest.CreateDeriveKey("app")
Check(contextA.Digest("abc") <> contextB.Digest("abc"), "context NUL is not a terminator")

digest.Update(abc)
Local first:Byte[32]
digest.Output(first)
digest.Update(abc)
digest.Finish(result)
Check(BytesToHex(first) = abcHash, "output leaves state available")
Check(BytesToHex(result) = digest.Digest("abcabc"), "updates after output")
digest.Update(abc)
digest.FinishXOF(New Byte[0])
Check(digest.Digest("") = emptyHash, "empty XOF resets")

For Local mode:Int = 0 Until 3
	Local failed:Int
	digest.Update(abc)
	Try
		digest.DigestBytes(New TBadStream(mode))
	Catch error:TStreamReadException
		failed = True
	End Try
	Check(failed, "stream failure " + mode)
	Check(digest.Digest("") = emptyHash, "stream failure clears partial state")
Next

Print "PASS: " + vectorCases + " official vectors, all 3 modes; " + checks + " checks."

Type TBadStream Extends TStream
	Field mode:Int
	Field calls:Int
	Method New(mode:Int)
		Self.mode = mode
	End Method
	Method Read:Long(buffer:Byte Ptr, count:Long) Override
		calls :+ 1
		If calls = 1 Then
			buffer[0] = 42
			Return 1
		End If
		Select mode
			Case 0
				Return -1
			Case 1
				Return count + 1
			Case 2
				Throw New TStreamReadException
		End Select
	End Method
End Type
