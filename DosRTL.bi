Const DosStringBufferCapacity As UByte = 255 - SizeOf(UByte) - SizeOf(UByte)

Type DosStringBuffer
	Capacity As UByte
	Length As UByte
	DosString As ZString * (DosStringBufferCapacity)
End Type


Declare Sub EntryPoint Naked()

Declare Sub PrintDosString cdecl(ByVal pChar As ZString Ptr)

Declare Sub InputDosString cdecl(ByVal lpBuffer As DosStringBuffer Ptr)