/* OUTPUT_FORMAT(binary) */
SECTIONS
{
	_ProgramSegmentPrefix = ALIGN(0x0000);
	. = 0x0100;
	.text :
	{
		*(.text);
	}
	.data :
	{
		*(.rdata);
		*(.rodata);
		*(.data);
		*(.bss);
	}
	_CodeSegment = ALIGN(4);
	_DataSegment = ALIGN(4);
	_StackSegment = ALIGN(4);
	_ExtraSegment = ALIGN(4);
	_Heap = ALIGN(4);
}