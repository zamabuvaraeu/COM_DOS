#ifndef DOSRTL_BI
#define DOSRTL_BI

Type WORD As UShort
Type DWORD As ULong

#define MakeDword(low, high) (Cast(ULong, (Cast(UShort, high) And &hFFFF) Shl 16) Or (Cast(UShort, low) And &hFFFF))

Const DosStringBufferCapacity As UByte = 255 - SizeOf(UByte) - SizeOf(UByte)

Type DosStringBuffer
	cbSize As UByte
	Length As UByte
	DosString As ZString * (DosStringBufferCapacity)
End Type


Type ProgramSegmentPrefix Field = 1
	Int20hCode(1) As UByte          ' 2, Содержит код INT 20 выхода из программы в стиле CP/M (для совместимости)
	MemoryTop As WORD               ' 2, Сегмент, расположенный сразу после выделенной программе памяти
	Reserved1 As UByte              ' 1, Зарезервировано
	CallDsp(4) As UByte             ' 5, Содержит код CALL FAR для вызова функций DOS в стиле CP/M (для совместимости)
	lpTerminateAddress As DWORD     ' 4, Адрес обработчика Terminate предыдущей программы (предыдущий INT 22)
	lpControlBreal As DWORD         ' 4, Адрес обработчика Break предыдущей программы (предыдущий INT 23)
	lpCriticalError As DWORD        ' 4, Адрес обработчика критических ошибок предыдущей программы (предыдущий INT 24)
	ParentPspSegment As WORD        ' 2, Сегмент PSP вызывающего процесса (как правило, command.com — внутренний)
	FileTable(19) As UByte          ' 20, Job File Table (внутренняя)
	EnvironmentSegment As WORD      ' 2, Сегмент переменных среды
	SsSpStack As DWORD              ' 4, SS:SP на входе к последнему вызову INT 21 (внутренний)
	MaxOpenFiles As WORD            ' 2, максимальное количество открытых файлов (внутренний)
	FileTBA As DWORD                ' 4, Адрес ручных записей (внутренний)
	Reserved2(23) As UByte          ' 24, Зарезервировано
	DosDispatchFunction(2) As UByte ' 3, Для вызова к DOS (всегда содержит INT 21 + RETF)
	Reserved3(8) As UByte           ' 9, Зарезервировано
	FileContentBlock1(15) As UByte  ' 16, Закрытый уровень FCB 1
	FileContentBlock2(19) As UByte  ' 20, Закрытый уровень FCB (перезаписан, если FCB 1 открыт)
	cbCommandLine As UByte          ' 1, Количество символов в командной строке
	CommandLine As ZString * 127    ' 127, Командная строка (завершается &h0D)
End Type

Extern ProgramSegmentPrefix Alias "ProgramSegmentPrefix" As ProgramSegmentPrefix

Type SegmentRegisters Field = 1
	CodeSegment As WORD
	DataSegment As WORD
	StackSegment As WORD
	ExtraSegment As WORD
End Type

Type FarPointer Field = 1
	Segment As WORD
	Offset As WORD
End Type

Declare Sub EntryPoint __Thiscall()

Declare Sub InputDosString __Thiscall( _
	ByVal lpBuffer As DosStringBuffer Ptr _
)

Declare Sub PrintDosString __Thiscall( _
	ByVal pChar As ZString Ptr _
)

Declare Function PrintStringA Cdecl( _
	ByVal p As ZString Ptr, _
	ByVal Length As Integer _
)As Short

Declare Function IntToStr Cdecl( _
	ByVal n As Integer, _
	ByVal pBuffer As ZString Ptr _
)As Integer

Declare Function StrToInt Cdecl( _
	ByVal pBuffer As ZString Ptr _
)As Integer

#endif
