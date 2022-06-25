Const DosStringBufferCapacity As UByte = 255 - SizeOf(UByte) - SizeOf(UByte)

Type DosStringBuffer
	Capacity As UByte
	Length As UByte
	DosString As ZString * (DosStringBufferCapacity)
End Type


Declare Sub EntryPoint Naked Cdecl()

Declare Sub PrintDosString Cdecl(ByVal pChar As ZString Ptr)

Declare Sub InputDosString Cdecl(ByVal lpBuffer As DosStringBuffer Ptr)