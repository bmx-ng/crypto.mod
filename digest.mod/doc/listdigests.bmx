SuperStrict

Framework brl.standardio
Import Crypto.MD5Digest
Import Crypto.SHA512Digest

Print "Available digests:"
For Local digest:String = EachIn ListDigests()
	Print "  " + digest
Next
