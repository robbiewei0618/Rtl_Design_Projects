#!/bin/tcsh

vcs -R -debug_access+all \
~/HDL/HW4/Testbench/pre_syn/HW4_TB_fixed.v \
~/HDL/HW4/RTL/Intensity.v \
~/HDL/HW4/RTL/LineBuffer.v \
~/HDL/HW4/RTL/Conv.v \
~/HDL/HW4/RTL/edge_detection.v \
+full64 \
+access+r +vcs+fsdbon +fsdb+mda +fsdbfile+tb_thumb.fsdb +v2k
