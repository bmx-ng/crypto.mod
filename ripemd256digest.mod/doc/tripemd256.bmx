SuperStrict

Framework BRL.StandardIO
Import Crypto.Ripemd256Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("RIPEMD-256")

If digest Then
	Print digest.Digest(data)
End If
