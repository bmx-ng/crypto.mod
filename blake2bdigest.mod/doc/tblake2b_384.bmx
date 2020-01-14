SuperStrict

Framework BRL.StandardIO
Import Crypto.Blake2BDigest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("BLAKE2B_384")

If digest Then
	Print digest.Digest(data)
End If
