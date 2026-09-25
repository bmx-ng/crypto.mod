SuperStrict
Framework BRL.StandardIO
Import Crypto.Blake3Digest

Local digest:TMessageDigest = GetMessageDigest("BLAKE3")
Print digest.Digest("abc")
' 6437b3ac38465133ffb63b75273a8db548c558465d79db03fd359c6cd5bd9d85
