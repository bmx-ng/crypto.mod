SuperStrict

Framework BRL.StandardIO
Import Crypto.SHA512Digest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("SHA-512")

If digest Then
	Print digest.Digest(data)
End If
