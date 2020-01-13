SuperStrict

Framework brl.standardio
Import Crypto.SHA256Digest

Local data:TStream = ReadStream("data.txt")

Local digest:TMessageDigest = GetMessageDigest("sha-256")

If digest Then
	Print digest.Digest(data)
End If

data.Close()
