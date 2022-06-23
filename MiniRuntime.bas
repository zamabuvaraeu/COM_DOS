#include once "MiniRuntime.bi"

Declare Function DosMain() As Long

Sub EntryPoint Naked()
	Asm
		.code16gcc
		call	DosMain
		mov	ah, &h4C
		int	&h21
	End Asm
End Sub

Sub PrintDosString(ByVal pChar As ZString Ptr)
	Asm
		mov	edx, dword ptr [ebp+8]
		mov	ah, &h09
		int	&h21
	End Asm
End Sub
