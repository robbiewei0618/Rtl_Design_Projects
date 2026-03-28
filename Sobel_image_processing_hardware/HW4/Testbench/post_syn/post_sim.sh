#!/bin/tcsh

vcs -R -debug_access+all \
~/HDL/HW4/Testbench/post_syn/HW4_TB_fixed.v \
~/HDL/HW4/Gatelevel/Area/Edge_detection/dc_out_file/Edge_Detection_syn.v \
/cad/CBDK/ADFP/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v \
+full64 \
+access+r +vcs+fsdbon +fsdb+mda +fsdbfile+am.fsdb +neg_tchk
