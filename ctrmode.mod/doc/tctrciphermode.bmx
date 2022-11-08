SuperStrict

Framework brl.standardio
Import crypto.ctrmode
Import crypto.aescipher
Import crypto.crypto
Import brl.base64

Local cipher:TCipher = TCipher.Find("aes")
Local cipherMode:TCTRCipherMode = New TCTRCipherMode

Local txt:String = "The quick brown fox jumped over the lazy dog"
Print "Text    = " + txt

Local iv:Byte[32]
Local key:Byte[32]
TCryptoRandom.FillBuffer(iv)
TCryptoRandom.FillBuffer(key)

Print "IV      = " + TBase64.Encode(iv)
Print "Key     = " + TBase64.Encode(key)

Local pbuf:Byte Ptr = txt.ToUTF8String()
Local cbuf:Byte[txt.length]

cipherMode.Start(cipher, iv, key, 32, 14, ECTRCounterMode.LITTLE_ENDIAN)
cipherMode.Encrypt(pbuf, cbuf, UInt(txt.length))
cipherMode.Done()

Print "Encoded = " + TBase64.Encode(cbuf)

Local buf:Byte[txt.length + 1]

cipherMode.Start(cipher, iv, key, 32, 14, ECTRCounterMode.LITTLE_ENDIAN)
cipherMode.Decrypt(cbuf, buf, UInt(txt.length))
cipherMode.Done()

Print "Decoded = " + String.FromUTF8String(buf)
