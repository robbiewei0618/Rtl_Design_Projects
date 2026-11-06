# 04 - streaming 3x3 convolution engine for VGG-16 conv1_1 (3->64) + conv1_2 (64->64)
#   make legacy        image testbench on a 24x24 crop (Icarus, ~30 s), every
#                      feature map compared with a NumPy model
#   make legacy-full   the same on the full 224x224 image (Icarus: hours)
#   make verif         cycle-level scoreboard, 56x56, real + random weights (Verilator)
#   make -C verif full the full 224x224 network in Verilator, maps as PGM
SHELL := /bin/bash
RUN   := ../common/mk/legacy_run.sh
S     ?= 24
.PHONY: all legacy legacy-full verif clean
all: legacy verif

legacy:
	@mkdir -p tb/legacy/out_layer1 tb/legacy/out_layer2
	@$(RUN) cnn_$(S)x$(S) "ALL FEATURE MAPS WRITTEN" "ERROR" tb/legacy -- -DS_IMG=$(S) pre_syn_tb.v ../../rtl/conv_engine.v && \
	  (cd tb/legacy && python3 check_maps.py $(S)) | tee -a build/legacy/cnn_$(S)x$(S).log | tail -1 | grep -q "ALL FEATURE MAPS MATCH" && \
	  echo "LEGACY cnn_maps PASS" || (echo "LEGACY cnn_maps FAIL"; exit 1)

legacy-full:
	LEGACY_TIMEOUT=0 $(MAKE) legacy S=224

verif:
	$(MAKE) -C verif

clean:
	rm -rf build tb/legacy/out_layer1 tb/legacy/out_layer2
	$(MAKE) -C verif clean
