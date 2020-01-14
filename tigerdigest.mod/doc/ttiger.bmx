SuperStrict

Framework BRL.StandardIO
Import Crypto.TigerDigest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("TIGER")

If digest Then
	Print digest.Digest(data)
End If
