#!/bin/tcsh

vcs -R -debug_access+all \
/home/M133040086_HDL/hw2/rtl/testbench.v \
/home/M133040086_HDL/hw2/rtl/non_pipeline.v \
/home/M133040086_HDL/hw2/rtl/pipeline.v \
/home/M133040086_HDL/hw2/rtl/clock_gating.v \
+full64 \
+access+r +vcs+fsdbon +fsdb+mda +fsdbfile+am.fsdb +v2k
