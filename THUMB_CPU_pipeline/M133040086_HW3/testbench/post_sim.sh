#!/bin/tcsh

vcs -R -error=noMPD -debug_access+all \
/home/M133040065_HDL/hw03/testbench/post_tb_thumb.v \
/home/M133040065_HDL/hw03/gtl/dc_out_file/area/thumb_syn.v \
/cad/CBDK/ADFP/Executable_Package/Collaterals/IP/stdcell/N16ADFP_StdCell/VERILOG/N16ADFP_StdCell.v \
+full64 \
+access+r +vcs+fsdbon +fsdb+mda +fsdbfile+post.fsdb +neg_tchk