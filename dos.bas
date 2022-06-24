#include once "MiniRuntime.bi"

Declare Function DosMain() As Long

Const HelloWorld = !"Greetings. What is your name?\r\n$"
' Const HelloWorld = !"LOOO. What is your name?\r\n$"
Const Ololo = !"Hello from FreeBASIC, $"

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

Function InputDosString()As ZString Ptr
	
	Dim lpBuffer As ZString Ptr = @DosStringBuffer
	lpBuffer[0] = DosStringBufferCapacity
	
	Asm
		mov	edx, lpBuffer
		mov	ah, &h0A
		int	&h21
	End Asm
	
	Return lpBuffer
	
End Function

Sub PrintDosString(ByVal pChar As ZString Ptr)
	Dim bbb As UInteger = CUInt(pChar)
	Asm
		mov edx, bbb
		' mov	dx, ax
		mov	ah, &h09
		int	&h21
	End Asm
End Sub

Function DosMain()As Long
	
	Scope
		Dim lpHello As ZString Ptr = @HelloWorld
		PrintDosString(lpHello)
	End Scope
	
	Dim lpName As ZString Ptr = InputDosString()
	Dim Length As UByte = lpName[1]
	lpName[Length + 2] = 13
	lpName[Length + 3] = 10
	lpName[Length + 4] = Asc("$")
		
	Scope
		Dim lpOlolo As ZString Ptr = @Ololo
		PrintDosString(lpOlolo)
	End Scope
	
	PrintDosString(@lpName[2])
	
	Return 0
	
End Function
