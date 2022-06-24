#include once "DosRTL.bi"

Declare Function DosMain cdecl() As Long

Const DosStringBufferCapacity As UByte = 254 - 3
Dim Shared DosStringBuffer As ZString * (DosStringBufferCapacity + 1)

Sub EntryPoint Naked()
	Asm
		.code16gcc
		call	DosMain
		mov	ah, &h4C
		int	&h21
	End Asm
End Sub

Function InputDosString cdecl()As ZString Ptr
	
	Dim lpBuffer As ZString Ptr = @DosStringBuffer
	lpBuffer[0] = DosStringBufferCapacity
	
	Asm
		mov	edx, lpBuffer
		mov	ah, &h0A
		int	&h21
	End Asm
	
	Return lpBuffer
	
End Function

Sub PrintDosString cdecl(ByVal pChar As ZString Ptr)
	Dim bbb As UInteger = CUInt(pChar)
	Asm
		mov edx, bbb
		mov	ah, &h09
		int	&h21
	End Asm
End Sub
