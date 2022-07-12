#include once "DOS.bi"

Const WhatIsYourName = !"Greetings. What is your name?\r\n$"
Const Hello = !"Hello from FreeBASIC, $"

Function DosMain __Thiscall( _
		ByVal SegmentAddress As DWORD _
	)As UByte
	
	PrintDosString(WhatIsYourName)
	
	Dim UserName As DosStringBuffer = Any
	InputDosString(@UserName)
	
	PrintDosString(Hello)
	
	Dim Length As Integer = UserName.Length
	' UserName.DosString[Length + 0] = 13
	' UserName.DosString[Length + 1] = 10
	' UserName.DosString[Length + 2] = Asc("$")
	UserName.DosString[Length + 0] = Asc("$")
	
	PrintDosString(UserName.DosString)
	
	Return 0
	
End Function
