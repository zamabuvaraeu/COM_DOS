#include once "DOS.bi"

Const PspSegmentAddress = !"PSP segment address:\t$"
Const AvailableBytes = !"Upper memory bound:\t$"
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

Function DosMain __Thiscall( _
		ByVal SegmentAddress As DWORD _
	)As UByte
	
	Scope
		PrintDosString(PspSegmentAddress)
		Dim nSegmentAddress As Integer = CInt(SegmentAddress)
		PrintNumberWithNewLine(nSegmentAddress)
	End Scope
	
	Scope
		PrintDosString(AvailableBytes)
		
		Dim nMemoryTop As Integer = CInt(ProgramSegmentPrefix.MemoryTop)
		Dim AvailableMemory As Integer = nMemoryTop * 16
		PrintNumberWithNewLine(AvailableMemory)
	End Scope
	
	Scope
		PrintDosString(ParentPspSegmentAddress)
		Dim nParentPspSegment As Integer = CInt(ProgramSegmentPrefix.ParentPspSegment)
		PrintNumberWithNewLine(nParentPspSegment)
	End Scope
	
	Return 0
	
End Function
