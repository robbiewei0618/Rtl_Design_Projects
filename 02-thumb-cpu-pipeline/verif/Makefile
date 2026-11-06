# project 02 verification
#   make            lockstep differential test vs the course core (Verilator)
#                   + 4-state bus test (Icarus)        make PROGS=n CYCLES=n SEED=n
SHELL  := /bin/bash
COMMON := $(abspath ../../common)
SRCS   := ../rtl/thumb_pipe.v ../golden/thumb_ref.v tb_top.sv
PROGS  ?=
CYCLES ?=
RUN_ARGS := +verilator+error+limit+1000000 $(if $(PROGS),+PROGS=$(PROGS),) $(if $(CYCLES),+CYCLES=$(CYCLES),)
.PHONY: all bus
all: run bus
include $(COMMON)/mk/verilator.mk

# X/Z-aware bus check: needs a 4-state simulator
bus:
	@mkdir -p $(BUILD) $(LOGDIR)
	iverilog -g2012 -o $(BUILD)/bus.vvp tb_bus_4state.v ../rtl/thumb_pipe.v
	vvp -n $(BUILD)/bus.vvp | tee $(LOGDIR)/bus_4state.log; grep -q "TEST PASSED" $(LOGDIR)/bus_4state.log
