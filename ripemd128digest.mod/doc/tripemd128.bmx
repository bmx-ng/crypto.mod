SuperStrict

Framework BRL.StandardIO
Import Crypto.Ripemd128Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("RIPEMD-128")

If digest Then
	Print digest.Digest(data)
End If
