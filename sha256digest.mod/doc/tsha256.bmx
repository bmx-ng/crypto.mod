SuperStrict

Framework BRL.StandardIO
Import Crypto.SHA256Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("SHA-256")

If digest Then
	Print digest.Digest(data)
End If
