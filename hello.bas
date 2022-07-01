#include once "DosRTL.bas"

Const Greetings = !"Greetings. What is your name?\r\n$"
Const Hello = !"Hello from FreeBASIC, $"

Dim Shared UserName As DosStringBuffer = Any
Dim Shared Length As Integer

Function DosMain Cdecl( _
		ByVal SegmentAddress As DWORD _
	)As UByte
	
	PrintDosString(Greetings)
	
	UserName.Capacity = DosStringBufferCapacity
	
	InputDosString(@UserName)
	
	Length = UserName.Length
	UserName.DosString[Length + 0] = 13
	UserName.DosString[Length + 1] = 10
	UserName.DosString[Length + 2] = Asc("$")
	
	PrintDosString(Hello)
	
	PrintDosString(UserName.DosString)
	
	Return 0
	
End Function
