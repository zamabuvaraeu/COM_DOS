#ifndef HEAP_BI
#define HEAP_BI

Declare Sub LocalHeapInitialize __Thiscall(ByVal Size As UInteger)

Declare Function LocalAlloc __Thiscall(ByVal Size As UInteger)As Any Ptr

Declare Sub LocalFree __Thiscall(ByVal p As Any Ptr)

#endif

