SuperStrict

Framework brl.standardio
Import Crypto.MD5Digest

Local data:String = "Hello World"

Local digest:TMessageDigest = GetMessageDigest("md5")

If digest Then
	Print digest.Digest(data)
End If

