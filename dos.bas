#include once "DosRTL.bas"

Const Greetings = !"Greetings. What is your name?\r\n$"
Const Hello = !"Hello from FreeBASIC, $"

Function DosMain cdecl()As Long
	
	Scope
		Dim lpHello As ZString Ptr = @Greetings
		PrintDosString(lpHello)
	End Scope
	
	Dim UserName As DosStringBuffer = Any
	UserName.Capacity = DosStringBufferCapacity
	
	InputDosString(@UserName)
	
	Dim Length As UByte = UserName.Length
	UserName.DosString[Length + 0] = 13
	UserName.DosString[Length + 1] = 10
	UserName.DosString[Length + 2] = Asc("$")
		
	Scope
		Dim lpOlolo As ZString Ptr = @Hello
		PrintDosString(lpOlolo)
	End Scope
	
	PrintDosString(@UserName.DosString)
	
	Return 0
	
End Function
