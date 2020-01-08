'
'  Copyright (C) 2019-2020 Bruce A Henderson
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
bbdoc: Cipher base type.
End Rem
Type TCipher

	Field index:Int
	
	Method New(index:Int)
		Self.index = index
	End Method

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
	bbdoc: Returns the appropriate key size for @size.
	about: Rounds the input keysize @size down to the next appropriate key size for use with the cipher.
	End Rem
	Method KeySize:Int(size:Int) Abstract
	
	Rem
	bbdoc: Returns the name of the cipher.
	End Rem
	Method Name:String() Abstract
	
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
