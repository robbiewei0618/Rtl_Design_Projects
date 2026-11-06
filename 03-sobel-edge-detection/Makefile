# 03 - streaming Sobel edge detector (luminance -> 2-row line buffer -> 3x3 Sobel)
#   make legacy   course testbench on the 480x360 photo (Icarus, ~1.5 min), then
#                 every output pixel compared with a bit-exact Python model
#   make verif    pixel-exact streaming check, 5 images x thresholds (Verilator)
SHELL := /bin/bash
RUN   := ../common/mk/legacy_run.sh
RTL   := $(addprefix ../../,$(wildcard rtl/*.v))
.PHONY: all legacy verif clean
all: legacy verif

legacy:
	@$(RUN) sobel_cat "finish called" "" tb/legacy -- tb_edge_detection.v $(RTL) && \
	  (cd tb/legacy && python3 check_images.py) | tee -a build/legacy/sobel_cat.log | tail -1 | grep -q "ALL PIXELS MATCH" && \
	  echo "LEGACY sobel_images PASS" || (echo "LEGACY sobel_images FAIL"; exit 1)

verif:
	$(MAKE) -C verif

clean:
	rm -rf build tb/legacy/cat_after_sobel_*.bmp
	$(MAKE) -C verif clean
