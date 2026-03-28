#!/bin/tcsh

vcs -R -debug_access+all \
/home/M133040065_HDL/hw03/testbench/pre_tb_thumb.v \
/home/M133040065_HDL/hw03/rtl/thumb_pipe.v \
/home/M133040065_HDL/hw03/rtl/if_stage.v \
/home/M133040065_HDL/hw03/rtl/id_stage.v \
/home/M133040065_HDL/hw03/rtl/ex_stage.v \
/home/M133040065_HDL/hw03/rtl/wb_stage.v \
+full64 \
+access+r +vcs+fsdbon +fsdb+mda +fsdbfile+pre_pipeline.fsdb +v2k