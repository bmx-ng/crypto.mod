SuperStrict

Framework BRL.StandardIO
Import Crypto.Ripemd320Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("RIPEMD-320")

If digest Then
	Print digest.Digest(data)
End If
