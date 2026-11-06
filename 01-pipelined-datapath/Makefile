# 01 - (a +/- b) * c datapath: combinational, 2-stage pipeline, clock-gated pipeline
#   make legacy   course testbench (Icarus); it only prints results
#   make verif    self-checking testbench with SVA + coverage (Verilator)
SHELL := /bin/bash
RUN   := ../common/mk/legacy_run.sh
RTL   := $(addprefix ../../,$(wildcard rtl/*.v))
.PHONY: all legacy verif clean
all: legacy verif

legacy:
	@$(RUN) datapath_print "finish called" "" tb/legacy -- testbench.v $(RTL)

verif:
	$(MAKE) -C verif

clean:
	rm -rf build
	$(MAKE) -C verif clean
