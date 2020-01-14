SuperStrict

Framework BRL.StandardIO
Import Crypto.Ripemd160Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("RIPEMD-160")

If digest Then
	Print digest.Digest(data)
End If
