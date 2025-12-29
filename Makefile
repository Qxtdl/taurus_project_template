RISCV_PREFIX = riscv64-unknown-elf-

CC = $(RISCV_PREFIX)gcc
CFLAGS = -O0 -march=rv32i -mabi=ilp32 \
	-nostdlib -ffreestanding -fno-exceptions -fno-builtin \
	-mstrict-align \
	-g -Wall -Wextra \
	-fverbose-asm -T linker.ld -lgcc

ASFLAGS = -march=rv32i -mabi=ilp32

AS = $(RISCV_PREFIX)as
LD = $(RISCV_PREFIX)ld
OBJCOPY = $(RISCV_PREFIX)objcopy

BUILD = build
OUTPUT = YOUR_APP_NAME

CSRCS = $(shell find src -name '*.c')
ASRCS = $(shell find src -name '*.s')
COBJS = $(patsubst %.c,$(BUILD)/%.o,$(CSRCS))
AOBJS = $(patsubst %.s,$(BUILD)/%.o,$(ASRCS))
OBJS = $(AOBJS) $(COBJS)

all: cls clean $(OBJS) $(OUTPUT) assets run

force:

cls: 
	clear

$(BUILD)/%.o : %.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

$(BUILD)/%.o : %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUTPUT): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(BUILD)/$(OUTPUT).elf
	$(OBJCOPY) -O binary $(BUILD)/$(OUTPUT).elf $(BUILD)/$(OUTPUT).bin

assets: force
	cp -R assets $(BUILD)/assets

run:
	python tilegpu_encoder.py assets/YOUR_ASSET_NAME.bmp
	python taurus_encoder.py build/$(OUTPUT).bin

clean:
	rm -rf $(BUILD)
