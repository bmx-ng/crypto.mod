SuperStrict

Framework BRL.StandardIO
Import Crypto.WhirlpoolDigest

Local data:String = "Hello Digest World !!"

Local digest:TMessageDigest = GetMessageDigest("WHIRLPOOL")

If digest Then
	Print digest.Digest(data)
End If
