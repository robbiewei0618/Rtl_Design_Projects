// =============================================================================
// tb_bus_4state.v - store/load round trip on a real tri-state data bus
//
// Runs on Icarus Verilog (4-state). A 2-state simulator resolves bus
// contention silently, so this check needs X/Z: during a load the CPU must
// release `data` (drive Z) and the value seen on the bus must be exactly the
// memory word, without X bits.
//   iverilog -g2012 -DCPU=thumb tb_bus_4state.v <cpu rtl>
// =============================================================================
`timescale 1ns/1ns
`define WORD_SIZE 32
`define HWORD_SIZE 16
`ifndef CPU
  `define CPU thumb
`endif
module tb_bus_4state;
  wire        read_instruction_n, read_data_n, write_data_n;
  wire [31:0] instruction_address, data_address, data;
  wire [15:0] instruction;
  reg         reset_n = 1'b0, clk = 1'b0;
  always #50 clk = ~clk;

  `CPU cpu (read_instruction_n, instruction_address, instruction,
            read_data_n, write_data_n, data_address, data, reset_n, clk);

  reg [15:0] imem [0:255];
  reg [31:0] dmem [0:255];
  assign instruction = imem[instruction_address[7:0]];
  // memory drives the bus only while the CPU reads
  assign data = read_data_n ? 32'hzzzz_zzzz : dmem[data_address[7:0]];
  always @(negedge clk) if (!write_data_n) dmem[data_address[7:0]] <= data;

  integer errors = 0, k;
  always @(negedge clk)
    if (reset_n && !read_data_n && (^data === 1'bx)) begin
      errors = errors + 1;
      if (errors <= 3) $display("[SVA] bus contention: data = %h during a load from %h (memory holds %h)",
                                data, data_address, dmem[data_address[7:0]]);
    end

  initial begin
    for (k = 0; k < 256; k = k + 1) begin imem[k] = 16'h2700; dmem[k] = 32'h0; end   // MOV r7,#0 filler
    imem[0]  = 16'h2010;   // MOV r0,#0x10
    imem[2]  = 16'h215A;   // MOV r1,#0x5A
    imem[8]  = 16'h6001;   // STR r1,[r0,#0]
    imem[14] = 16'h6802;   // LDR r2,[r0,#0]
    imem[22] = 16'h6042;   // STR r2,[r0,#4]
    imem[28] = 16'hDF00;   // SWI (halt)
    #120 reset_n = 1'b1;
    #6000;
    if (dmem[8'h10] !== 32'h5A) begin errors = errors + 1; $display("[MISMATCH] store: mem[0x10] = %h", dmem[8'h10]); end
    if (dmem[8'h14] !== 32'h5A) begin errors = errors + 1; $display("[MISMATCH] load-store round trip: mem[0x14] = %h, expected 0000005a", dmem[8'h14]); end
    if (errors == 0) $display("TEST PASSED"); else $display("TEST FAILED (%0d errors)", errors);
    $finish;
  end
endmodule
