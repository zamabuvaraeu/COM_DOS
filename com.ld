/* OUTPUT_FORMAT(binary) */
SECTIONS
{
	. = 0x0100;
	.text :
	{
		*(.text);
		*(.data);
		*(.bss);
		*(.rdata);
		*(.rodata);
	}
}