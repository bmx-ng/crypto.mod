SuperStrict

Framework brl.standardio
Import Crypto.Crypto

Local buf:Byte[32]

TCryptoRandom.FillBuffer(buf)

For Local i:Int = 0 Until buf.length
	Print buf[i]
Next
