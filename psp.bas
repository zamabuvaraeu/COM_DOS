#include once "DosRTL.bas"

Const PspSegmentAddress = !"PSP segment address:\t$"
Const AvailableBytes = !"Available memory:\t$"
Const ParentPspSegmentAddress = !"PSP parent segment:\t$"

Sub PrintNumberWithNewLine( _
		ByVal Number As Integer _
	)
	
	Dim Buffer As ZString * 20 = Any
	Dim Length As Integer = IntToStr(Number, Buffer)
	
	Buffer[Length + 0] = 13
	Buffer[Length + 1] = 10
	Buffer[Length + 2] = Asc("$")
	
	Dim p As ZString Ptr = @Buffer
	PrintDosString(p)
	
End Sub

Function DosMain Cdecl( _
		ByVal SegmentAddress As DWORD _
	)As UByte
	
	Dim pPsp As ProgramSegmentPrefix Ptr = CPtr(ProgramSegmentPrefix Ptr, 0)
	
	Scope
		Dim p As ZString Ptr = @PspSegmentAddress
		PrintDosString(p)
		PrintNumberWithNewLine(CInt(SegmentAddress))
	End Scope
	
	Scope
		Dim p As ZString Ptr = @AvailableBytes
		PrintDosString(p)
		PrintNumberWithNewLine(CInt(pPsp->MemoryTop) * 16)
	End Scope
	
	Scope
		Dim p As ZString Ptr = @ParentPspSegmentAddress
		PrintDosString(p)
		PrintNumberWithNewLine(CInt(pPsp->ParentPspSegment))
	End Scope
	
	Return 0
	
End Function
