// IF stage module
// input and output are implicitly wire
module IF_stage(
  input  clk, reset_n, branch_taken,
  input  [`WORD_SIZE-1:0] branch_target, PC_in,
  input  [`HWORD_SIZE-1:0] instruction,
  output reg read_instruction_n,
  output reg [`WORD_SIZE-1:0] PC_out, 
  output reg [`WORD_SIZE-1:0] IF_PC,
  output reg [`HWORD_SIZE-1:0] IF_IR
);
  always @(negedge reset_n or posedge clk) begin
    if (~reset_n) begin
      PC_out <= 0;              // start fetching from location 0
      read_instruction_n <= 0; // and start memory read
    end
    else begin        // on positive clock edge,
      // execute operations and then save values in pipeline reg
      read_instruction_n <= 0; // read next instruction
      if (branch_taken) begin  // determine next instruction
        PC_out <= branch_target;   // operation for IF stage
        IF_IR <= `UNDEFINED_INSTRUCTION;  // to create a pipeline 
        IF_PC <= branch_target;           // stall (bubble)
      end
      else begin
        PC_out <= PC_in + 2;         // operation for IF stage
        IF_IR <= instruction; // read instruction and store in IR
        IF_PC <= PC_in + 2;      // save next instruction address
      end
    end
  end  // of IF stage
endmodule