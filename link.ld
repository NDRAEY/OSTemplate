ENTRY (__pre_init)

SECTIONS
{
    . = 0x00200000;
    KERNEL_BASE_pos = .;

    .text ALIGN (0x1000) :
    {
        *(.mboot)
        *(.text)
    }

    .data ALIGN (0x1000) :
    {
        *(.data)
    }

	.rodata ALIGN (0x1000) :
	{
		*(.rodata)
	}

    .bss :
    {
    	*(COMMON)
        *(.bss)
    }
    
    KERNEL_END_pos = .;
}
