module IF(
    output reg [`WORD_SIZE-1:0] PC,
    output reg [`HWORD_SIZE-1:0] IF_IR,
    output reg [`WORD_SIZE-1:0] IF_PC,
    output reg read_instruction_n,
    
    input [`HWORD_SIZE-1:0] instruction,
    input branch_taken,
    input [`WORD_SIZE-1:0] branch_target,
    input clk,
    input reset_n
);
always @(negedge reset_n or posedge clk) begin
    if (~reset_n) begin
      PC <= 32'h0000_0000;              // start fetching from location 0
      read_instruction_n <= 1'b0; // and start memory read
      IF_IR <= 16'h0000;
      IF_PC <= 32'h0000_0000;
    end
    else begin        // on positive clock edge,
      // execute operations and then save values in pipeline reg
      read_instruction_n <= 0; // read next instruction
      if (branch_taken) begin  // determine next instruction
        PC <= branch_target;   // operation for IF stage
        IF_IR <= `UNDEFINED_INSTRUCTION;  // to create a pipeline 
        IF_PC <= branch_target;           // stall (bubble)
      end
      else begin
        PC <= PC + 2;         // operation for IF stage
        IF_IR <= instruction; // read instruction and store in IR
        IF_PC <= PC + 2;      // save next instruction address
      end
    end
  end  // of IF stage
endmodule
