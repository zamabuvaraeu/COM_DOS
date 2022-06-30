#include once "DosRTL.bas"

Const Greetings = !"Greetings. What is your name?\r\n$"
Const Hello = !"Hello from FreeBASIC, $"

Function DosMain Cdecl()As UByte
	
	Scope
		PrintDosString(Greetings)
	End Scope
	
	Dim UserName As DosStringBuffer = Any
	Scope
		UserName.Capacity = DosStringBufferCapacity
		
		InputDosString(@UserName)
		
		Dim Length As UByte = UserName.Length
		UserName.DosString[Length + 0] = 13
		UserName.DosString[Length + 1] = 10
		UserName.DosString[Length + 2] = Asc("$")
	End Scope
	
	Scope
		PrintDosString(Hello)
	End Scope
	
	PrintDosString(@UserName.DosString)
	
	Return 0
	
End Function
