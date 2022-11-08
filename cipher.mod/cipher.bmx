'
'  Copyright (C) 2019-2022 Bruce A Henderson
'
'  This software is provided 'as-is', without any express or implied
'  warranty.  In no event will the authors be held liable for any damages
'  arising from the use of this software.
'
'  Permission is granted to anyone to use this software for any purpose,
'  including commercial applications, and to alter it and redistribute it
'  freely, subject to the following restrictions:
'
'  1. The origin of this software must not be misrepresented; you must not
'     claim that you wrote the original software. If you use this software
'     in a product, an acknowledgment in the product documentation would be
'     appreciated but is not required.
'  2. Altered source versions must be plainly marked as such, and must not be
'     misrepresented as being the original software.
'  3. This notice may not be removed or altered from any source distribution.
'
SuperStrict

Rem
bbdoc: Ciphers
End Rem
Module Crypto.Cipher

ModuleInfo "CC_OPTS: -DLTC_NO_TEST -DLTC_NO_FILE"

Import "common.bmx"

Private
Global _cipher_factories:TCipherFactory
Public

Rem
bbdoc: Gets a cipher of the specified @name.
about: A #TNoSuchAlgorithmException is thrown if the requested cipher is not available.
End Rem
Function GetCipher:TCipher(name:String)
	Local c:TCipher = TCipher.Find(name)

	If Not c Then
		Throw New TNoSuchAlgorithmException("Cipher not available : " + name)
	End If
	Return c
End Function

Rem
bbdoc: Gets a block cipher of the specified @name.
about: A #TNoSuchAlgorithmException is thrown if the requested block cipher is not available.
End Rem
Function GetBlockCipher:TBlockCipher(name:String)
	Local c:TBlockCipher = TBlockCipher(GetCipher(name))

	If Not c Then
		Throw New TNoSuchAlgorithmException("Block cipher not available : " + name)
	End If
	Return c
End Function

Rem
bbdoc: Gets a stream cipher of the specified @name.
about: A #TNoSuchAlgorithmException is thrown if the requested stream cipher is not available.
End Rem
Function GetStreamCipher:TStreamCipher(name:String)
	Local c:TStreamCipher = TStreamCipher(GetCipher(name))

	If Not c Then
		Throw New TNoSuchAlgorithmException("Stream cipher not available : " + name)
	End If
	Return c
End Function

Rem
bbdoc: Cipher base type.
End Rem
Type TCipher

	Field keyPtr:Byte Ptr
	Field index:Int
	
	Rem
	bbdoc: Returns a list of all registered ciphers.
	End Rem
	Function ListCiphers:String[]()
		Return bmx_crypto_listCiphers()
	End Function

	Rem
	bbdoc: Gets the cipher index of the given @name.
	returns: the index or -1 if not found.
	End Rem
	Function Find:TCipher(name:String)
		Local index:Int = bmx_crypto_findCipher(name)
		If index >= 0 Then
			Local factory:TCipherFactory=_cipher_factories

			Local cipher:TCipher
			While factory
				cipher = factory.Find(index)
				If cipher Exit
				factory = factory._succ
			Wend
			Return cipher
		End If
	End Function

	Rem
	bbdoc: Determines the appropriate key size for @size.
	returns: The appropriate key size, or -1 if the provided @size was not acceptable.
	about: Rounds the input keysize @size down to the next appropriate key size for use with the cipher.
	End Rem
	Method KeySize:Int(size:Int) Abstract

	Rem
	bbdoc: Returns the name of the cipher.
	End Rem
	Method Name:String() Abstract
	
	Rem
	bbdoc: When you are finished with a cipher you can de–initialize it with the done method.
	End Rem
	Method Done() Abstract

End Type

Type TBlockCipher Extends TCipher

	Method New(index:Int)
		keyPtr = bmx_crypto_symmetric_key_new()
		Self.index = index
	End Method

	Rem
	bbdoc: The block size for this cipher.
	End Rem
	Method BlockSize:Int() Abstract
	
	Rem
	bbdoc: Sets up the cipher to be used with a given number of @rounds and a given @key.
	End Rem
	Method Setup:Int(key:String, rounds:Int = 0) Abstract

	Rem
	bbdoc: Sets up the cipher to be used with a given number of @rounds and a given @key.
	End Rem
	Method Setup:Int(key:Byte[], rounds:Int = 0) Abstract

	Rem
	bbdoc: Sets up the cipher to be used with a given number of @rounds and a given key length.
	End Rem
	Method Setup:Int(key:Byte Ptr, keylen:Int, rounds:Int = 0) Abstract

	Rem
	bbdoc: Encrypts a single block of text, @pt, storing the result in the @ct buffer.
	about: It is possible that the input and output buffer are the same buffer.
	The size of the block can be determined with #BlockSize.
	End Rem
	Method Encrypt:Int(pt:Byte Ptr, ct:Byte Ptr) Abstract

	Rem
	bbdoc: Decrypts a single block of text, @ct, storing the result in the @pt buffer.
	about: It is possible that the input and output buffer are the same buffer.
	The size of the block can be determined with #BlockSize.
	End Rem
	Method Decrypt:Int(ct:Byte Ptr, pt:Byte Ptr) Abstract

	Method Delete()
		If keyPtr Then
			bmx_crypto_symmetric_key_free(keyPtr)
			keyPtr = Null
		End If
	End Method

End Type

Type TStreamCipher Extends TCipher

	Method New(index:Int)
		Self.index = index
	End Method

End Type

Rem
bbdoc: Base type for cipher chaining modes.
End Rem
Type TCipherMode

	Field modePtr:Byte Ptr
	
	Rem
	bbdoc: 
	End Rem
	Method Done:Int() Abstract
	
End Type

Type TCipherFactory
	Field _succ:TCipherFactory
	Field index:Int
	
	Method New(index:Int)
		Self.index = index
		_succ=_cipher_factories
		_cipher_factories=Self
	End Method
	
	Method Find:TCipher( index:Int ) Abstract
	
End Type
