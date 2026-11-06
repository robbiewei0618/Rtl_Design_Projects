# =============================================================================
# Digital-system RTL projects - top-level regression
#   make test      every course testbench + every verification environment
#   make legacy    course testbenches only        (needs: iverilog, python3-numpy)
#   make verif     new verification only          (needs: verilator >= 5.0, iverilog)
# =============================================================================
SHELL    := /bin/bash
PROJECTS := 01-pipelined-datapath 02-thumb-cpu-pipeline 03-sobel-edge-detection 04-cnn-accelerator
.PHONY: test legacy verif clean
test: legacy verif
legacy:
	@rc=0; for p in $(PROJECTS); do echo "== $$p"; $(MAKE) -s -C $$p legacy || rc=1; done; exit $$rc
verif:
	@rc=0; for p in $(PROJECTS); do echo "== $$p"; $(MAKE) -s -C $$p verif || rc=1; done; exit $$rc
clean:
	@for p in $(PROJECTS); do $(MAKE) -s -C $$p clean; done
