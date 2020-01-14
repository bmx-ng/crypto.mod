SuperStrict

Framework brl.standardio
Import Crypto.MD5Digest
Import Crypto.SHA3Digest

Print "Available digests:"
For Local digest:String = EachIn ListDigests()
	Print "  " + digest
Next
