#include once "DosRTL.bas"

Const Greetings = !"Greetings. What is your name?\r\n$"
Const Hello = !"Hello from FreeBASIC, $"

Function DosMain()As Long
	
	Scope
		Dim lpHello As ZString Ptr = @Greetings
		PrintDosString(lpHello)
	End Scope
	
	Dim lpName As ZString Ptr = InputDosString()
	Dim Length As UByte = lpName[1]
	lpName[Length + 2] = 13
	lpName[Length + 3] = 10
	lpName[Length + 4] = Asc("$")
		
	Scope
		Dim lpOlolo As ZString Ptr = @Hello
		PrintDosString(lpOlolo)
	End Scope
	
	PrintDosString(@lpName[2])
	
	Return 0
	
End Function
