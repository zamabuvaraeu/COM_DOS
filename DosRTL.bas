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

Function IntToStr Cdecl( _
		ByVal Value As Integer, _
		ByVal pBuffer As ZString Ptr _
	)As Integer
	
	Dim Sign As UInteger = Any
	Dim Chars As ZString * 40 = Any
	Dim Digits As Integer = 0
	
	Scope
		Dim k As Integer = Any
		If Value < 0 Then
			Sign = -1
			k = -Value
		Else
			Sign = 0
			k = Value
		End If
		
		Scope
			Do
				Dim Digit As Integer = k Mod 10
				k = k \ 10
				Dim AsciiDigit As Integer = Digit + &h30
				Chars[Digits] = AsciiDigit
				Digits += 1
			Loop While k > 0
		End Scope
	End Scope
	
	If Sign Then
		Chars[Digits] = Asc("-")
		Digits += 1
	End If
	
	Dim j As Integer = 0
	Digits -= 1
	
	For i As Integer = Digits To 0 Step -1
		pBuffer[j] = Chars[i]
		j += 1
	Next
	
	pBuffer[j] = 0
	
	Return j
	
End Function
