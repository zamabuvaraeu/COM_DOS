#include once "DosRTL.bas"

Const Greetings = !"Greetings. What is your name?\r\n"
Const Hello = !"Hello from FreeBASIC, "

Function DosMain Cdecl()As UByte
	
	Scope
		PrintStringA(Greetings, Len(Greetings))
	End Scope
	
	Dim UserName As DosStringBuffer = Any
	UserName.Capacity = DosStringBufferCapacity
	
	InputDosString(@UserName)
	
	Dim Length As UByte = UserName.Length
	UserName.DosString[Length + 0] = 13
	UserName.DosString[Length + 1] = 10
		
	Scope
		PrintStringA(Hello, Len(Hello))
	End Scope
	
	PrintStringA(@UserName.DosString, UserName.Length + 2)
	
	Return 0
	
End Function
