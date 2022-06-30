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
		
		Do
			Dim Digit As Integer = k Mod 10
			k = k \ 10
			Dim AsciiDigit As Integer = Digit + &h30
			Chars[Digits] = AsciiDigit
			Digits += 1
		Loop While k > 0
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

Function StrToInt Cdecl( _
		ByVal pBuffer As ZString Ptr _
	)As Integer
	
	Dim Number As Integer = 0
	Dim i As Integer = Any
	Dim Sign As UInteger = Any
	
	If pBuffer[0] = Asc("-") Then
		Sign = -1
		i = 1
	Else
		Sign = 0
		i = 0
	End If
	
	Do While pBuffer[i] >= &h30 AndAlso pBuffer[i] <= &h39
		Dim Digit As Integer = pBuffer[i] And &h0F
		Number = Number + Digit
		Number = Number * 10
		i += 1
	Loop
	
	Number = Number \ 10
	If sign then
		Return -Number
	End If
	
	Return Number
	
End Function
