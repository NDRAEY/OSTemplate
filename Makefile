# Makefile script based by NDRAEY

# Files
ASM=src/asm/init.o
CFILES=src/c/main.o
LINKLD=link.ld
KERNEL=kernel.elf

# Directories
BOOT=iso/boot
ISODIR=iso

# Name of your project
NAME=PavlenkoAndrey

# Final file can be run in VirtualBox or VMWare
ISO=$(NAME).iso

# Main
all: build

# Build kernel and make ISO file
build: link
	-mkdir -p $(BOOT)
	mv $(KERNEL) $(BOOT)
	$(MAKE) build_iso

# Link object files
link: $(ASM) $(CFILES)
	$(LD) -T$(LINKLD) $(ASM) $(CFILES) -o $(KERNEL)

# Compile assembly code
$(ASM): %.o: %.s
	$(AS) $< --32 -o $@

# Compile C files
$(CFILES): %.o: %.c
	$(CC) $< -c -ffreestanding -fno-stack-protector -Wall -m32 -o $@

# Clean working directory
clean:
	-rm $(ASM)
	-rm $(CFILES)
	-rm $(ISO)
	-rm $(BOOT)/$(KERNEL)

# Build an ISO file
build_iso:
	grub-mkrescue -V "$(NAME)" -o $(ISO) iso/

# Run OS
run:
	qemu-system-x86_64 -cdrom $(ISO) -m 32M
