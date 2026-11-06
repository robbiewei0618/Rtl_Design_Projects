# project 04 verification (Verilator)
#   make          56x56 crop of the photo, both layers, real + random weights
#   make full     the full 224x224 image (~14 M cycles per network) and the
#                 feature maps written to build_full/maps/*.pgm
SHELL  := /bin/bash
COMMON := $(abspath ../../common)
S      ?= 56
SRCS   := ../rtl/conv_engine.v tb_top.sv
EXTRA_VFLAGS := +define+S_IMG=$(S)
.PHONY: all inputs full
all: inputs run
include $(COMMON)/mk/verilator.mk
inputs:
	@mkdir -p $(BUILD)
	python3 prep.py $(S) $(BUILD)
full:
	$(MAKE) S=224 BUILD=build_full RUN_NAME=full RUN_ARGS="+DATA=build_full +DUMP=build_full/maps +VGG_ONLY" pre_full all
pre_full:
	@mkdir -p build_full/maps
