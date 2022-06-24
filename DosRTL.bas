#include once "DosRTL.bi"

Declare Function DosMain cdecl() As Long

Const DosStringBufferCapacity As UByte = 254 - 3
Dim Shared DosStringBuffer As ZString * (DosStringBufferCapacity + 1)

Sub EntryPoint Naked()
	Asm
		.code16gcc
		call   DosMain
		mov    ah, &h4C
		int    &h21
	End Asm
End Sub

Function InputDosString cdecl()As ZString Ptr
	
	Dim lpBuffer As ZString Ptr = @DosStringBuffer
	lpBuffer[0] = DosStringBufferCapacity
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(lpBuffer))
	
	Asm
		mov    dx, OffsetInSegment
		mov    ah, &h0A
		int    &h21
	End Asm
	
	Return lpBuffer
	
End Function

Sub PrintDosString cdecl(ByVal pChar As ZString Ptr)
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(pChar))
	
	Asm
		mov    dx, OffsetInSegment
		mov    ah, &h09
		int    &h21
	End Asm
	
End Sub
