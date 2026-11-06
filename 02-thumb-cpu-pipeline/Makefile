# 02 - pipelined Thumb CPU (IF / ID / EX / WB), refactored from the course core
#   make legacy   course testbench: the loop program must store 0x24 at 0x100 (Icarus)
#   make verif    lockstep differential test vs the course core (Verilator)
#                 + store/load round trip on a 4-state tri-state bus (Icarus)
SHELL := /bin/bash
RUN   := ../common/mk/legacy_run.sh
.PHONY: all legacy verif clean
all: legacy verif

legacy:
	@rc=0; \
	$(RUN) thumb_pipe "data \(0x24\) correct" "ERROR" tb/legacy -- tb_thumb.v ../../rtl/thumb_pipe.v || rc=1; \
	$(RUN) thumb_ref  "data \(0x24\) correct" "ERROR" tb/legacy -- -DCPU=thumb_ref tb_thumb.v ../../golden/thumb_ref.v || rc=1; \
	exit $$rc

verif:
	$(MAKE) -C verif

clean:
	rm -rf build
	$(MAKE) -C verif clean
