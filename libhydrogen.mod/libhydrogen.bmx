'
' Copyright (c) 2019-2022 Bruce A Henderson
'
' Permission to use, copy, modify, and/or distribute this software for any
' purpose with or without fee is hereby granted, provided that the above
' copyright notice and this permission notice appear in all copies.
'
' THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
' WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
' MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
' ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
' WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
' ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
' OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
'
SuperStrict


Module Crypto.LibHydrogen


ModuleInfo "Version: 1.02"
ModuleInfo "Author: Frank Denis."
ModuleInfo "License: ISC"
ModuleInfo "Credit: Adapted for BlitzMax by Bruce A Henderson"

ModuleInfo "History: 1.02"
ModuleInfo "History: Updated for haiku"
ModuleInfo "History: 1.01"
ModuleInfo "History: Disabled for NX."
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release."

'
' random.h
'   Added __HAIKU__ defs
'

?Not nx
Import "source.bmx"
?