#include once "Heap.bi"

Extern Heap Alias "Heap" As UByte

Common Shared pBreakMemory As UByte Ptr

Const ALIGN_SIZE As UInteger = 4

Sub LocalHeapInitialize __Thiscall(ByVal Size As UInteger)
	
	pBreakMemory = @Heap
	
End Sub

Function LocalAlloc __Thiscall(ByVal Size As UInteger)As Any Ptr
	
	Dim PaddingCount As UInteger = ALIGN_SIZE - (Size Mod ALIGN_SIZE)
	Dim AlignedSize As UInteger = Size + (PaddingCount Mod ALIGN_SIZE)
	
	Dim pMemory As Any Ptr = pBreakMemory
	
	' No need zero memory
	pBreakMemory += AlignedSize
	
	Return pMemory
	
End Function

Sub LocalFree __Thiscall(ByVal p As Any Ptr)
	
End Sub
