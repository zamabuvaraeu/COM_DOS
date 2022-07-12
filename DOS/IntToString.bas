#include once "DOS.bi"

Function IntToStr Cdecl( _
		ByVal Value As Integer, _
		ByVal pBuffer As ZString Ptr _
	)As Integer
	
	Dim Sign As UInteger = Any
	Dim Chars As ZString * 16 = Any
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
