Const DosStringBufferCapacity As UByte = 255 - SizeOf(UByte) - SizeOf(UByte)

Type DosStringBuffer
	Capacity As UByte
	Length As UByte
	DosString As ZString * (DosStringBufferCapacity)
End Type


Declare Sub EntryPoint Naked Cdecl()

Declare Sub PrintDosString Cdecl( _
	ByVal pChar As ZString Ptr _
)

Declare Function PrintStringA Cdecl( _
	ByVal p As ZString Ptr, _
	ByVal Length As Short _
)As Short

Declare Sub InputDosString Cdecl( _
	ByVal lpBuffer As DosStringBuffer Ptr _
)