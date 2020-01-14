SuperStrict

Framework BRL.StandardIO
Import Crypto.SHA1Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("SHA1")

If digest Then
	Print digest.Digest(data)
End If
