SuperStrict

Framework BRL.StandardIO
Import Crypto.MD5Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("MD5")

If digest Then
	Print digest.Digest(data)
End If
