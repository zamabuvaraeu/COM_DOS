#include once "DosRTL.bi"

Declare Function DosMain cdecl() As UByte

Sub EntryPoint Naked Cdecl()
	Asm
		call   DosMain
		mov    ah, &h4C
		int    &h21
	End Asm
End Sub

Sub InputDosString Cdecl( _
		ByVal lpBuffer As DosStringBuffer Ptr _
	)
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(lpBuffer))
	
	Asm
		mov    dx, OffsetInSegment
		mov    ah, &h0A
		int    &h21
	End Asm
	
End Sub

Sub PrintDosString Cdecl( _
		ByVal pChar As ZString Ptr _
	)
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(pChar))
	
	Asm
		mov    dx, OffsetInSegment
		mov    ah, &h09
		int    &h21
	End Asm
	
End Sub

Function PrintStringA Cdecl( _
		ByVal pChar As ZString Ptr, _
		ByVal Length As Short _
	)As Short
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(pChar))
	Dim RealLength As Short = Any
	
	/'
	Ввод:	АН = 40h
	ВХ = 1 для STDOUT или 2 для STDERR
	DS:DX = адрес начала строки
	СХ = длина строки
	Вывод:	CF = 0,
	АХ = число записанных байт
	'/
	Asm
		mov    ah, &h40
		mov    bx, 1
		mov    cx, Length
		mov    dx, OffsetInSegment
		int    &h21
		mov    RealLength, ax
	End Asm
	
	Return RealLength
	
End Function
