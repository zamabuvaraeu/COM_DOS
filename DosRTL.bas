#include once "DosRTL.bi"

Declare Function DosMain cdecl() As UByte

Sub EntryPoint Naked Cdecl()
	Asm
		call   DosMain
		mov    ah, &h4C
		int    &h21
	End Asm
End Sub

Sub InputDosString Cdecl(ByVal lpBuffer As DosStringBuffer Ptr)
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(lpBuffer))
	
	Asm
		mov    dx, OffsetInSegment
		mov    ah, &h0A
		int    &h21
	End Asm
	
End Sub

Sub PrintDosString Cdecl(ByVal pChar As ZString Ptr)
	
	Dim OffsetInSegment As UShort = LoWord(CUInt(pChar))
	
	Asm
		mov    dx, OffsetInSegment
		mov    ah, &h09
		int    &h21
	End Asm
	
End Sub
