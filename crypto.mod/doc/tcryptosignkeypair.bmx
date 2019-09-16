SuperStrict

Framework brl.standardio
Import Crypto.Crypto

Local keyPair:TCryptoSignKeyPair = TCryptoSign.KeyGen()

Local s:String = keyPair.ToString()

Print s
