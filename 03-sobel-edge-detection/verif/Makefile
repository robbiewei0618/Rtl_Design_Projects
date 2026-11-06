# project 03 verification (Verilator): pixel-exact streaming check
SHELL  := /bin/bash
COMMON := $(abspath ../../common)
SRCS   := $(wildcard ../rtl/*.v) tb_top.sv
.PHONY: all hex
all: hex run
include $(COMMON)/mk/verilator.mk
hex: $(BUILD)/cat_rgb.hex
$(BUILD)/cat_rgb.hex: ../tb/legacy/data/cat.bmp bmp2hex.py
	@mkdir -p $(BUILD)
	python3 bmp2hex.py $< $@
