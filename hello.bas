#include once "DosRTL.bas"

Const Greetings = !"Greetings. What is your name?\r\n$"
Const Hello = !"Hello from FreeBASIC, $"

Function DosMain Cdecl()As UByte
	
	Scope
		Dim p As ZString Ptr = @Greetings
		PrintDosString(p)
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
		Dim p As ZString Ptr = @Hello
		PrintDosString(p)
	End Scope
	
	Scope
		Dim p As ZString Ptr = @UserName.DosString
		PrintDosString(p)
	End Scope
	
	Return 0
	
End Function
