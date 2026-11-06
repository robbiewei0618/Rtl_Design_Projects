/////////////////////////////////////////////////////////////////
// GLOBAL PARAMETER DEFINITIONS
`define WORD_SIZE 32    // bits in data registers and address
`define HWORD_SIZE 16   // instruction word size
`define REG_FILE_SIZE 8 // number of general-purpose registers

// OPCODE DEFINITIONS
// Undefined Instruction Thumb Opcode
`define UNDEFINED_INSTRUCTION 16'hDE00 // 16 = `HWORD_SIZE
// Internal Encoding for Thumb Instructions Supported in "thumb.v"
`define ADC        6'b00_0000
`define ADD_1      6'b00_0001
`define ADD_2      6'b00_0010
`define ADD_3      6'b00_0011
`define ADD_5      6'b00_0100
`define ADD_6      6'b00_0101
`define ADD_7      6'b00_0110
`define AND        6'b00_0111
`define ASR_1      6'b00_1000
`define ASR_2      6'b00_1001
`define B_1        6'b00_1010
`define B_2        6'b00_1011
`define BIC        6'b00_1100
`define BL_BLX_H10 6'b00_1101
`define BL_BLX_H11 6'b00_1110
`define CMN        6'b00_1111
`define CMP_1      6'b01_0000
`define CMP_2      6'b01_0001
`define EOR        6'b01_0010
`define LDMIA      6'b01_0011
`define LDR_1      6'b01_0100
`define LDR_2      6'b01_0101
`define LDR_3      6'b01_0110
`define LDR_4      6'b01_0111
`define LDRB_1     6'b01_1000
`define LDRB_2     6'b01_1001
`define LDRH_1     6'b01_1010
`define LDRH_2     6'b01_1011
`define LDRSB      6'b01_1100
`define LDRSH      6'b01_1101
`define LSL_1      6'b01_1110
`define LSL_2      6'b01_1111
`define LSR_1      6'b10_0000
`define LSR_2      6'b10_0001
`define MOV_1      6'b10_0010
`define MUL        6'b10_0011
`define MVN        6'b10_0100
`define NEG        6'b10_0101
`define ORR        6'b10_0110
`define POP_R0     6'b10_0111
`define POP_R1     6'b10_1000
`define PUSH_R0    6'b10_1001
`define PUSH_R1    6'b10_1010
`define ROR        6'b10_1011
`define SBC        6'b10_1100
`define STMIA      6'b10_1101
`define STR_1      6'b10_1110
`define STR_2      6'b10_1111
`define STR_3      6'b11_0000
`define STRB_1     6'b11_0001
`define STRB_2     6'b11_0010
`define STRH_1     6'b11_0011
`define STRH_2     6'b11_0100
`define SUB_1      6'b11_0101
`define SUB_2      6'b11_0110
`define SUB_3      6'b11_0111
`define SUB_4      6'b11_1000
`define SWI        6'b11_1001
`define TST        6'b11_1010
`define UNDEF      6'b11_1111
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
// MODULE: Pipelined CPU for THUMB microprocessor: thumb.v
// Author: Sunggu Lee
// Created: July 31, 2003
// Last Modified: August 22, 2003
// Description: Implements the instruction set for the THUMB
//   microprocessor described in the "ARM Architecture Reference
//   Manual" ([ARM 2000]).  The SWI (software interrupt) instr.
//   is reimplemented as a HALT.  Currently, a few instructions
//   are not implemented due to a desire to keep the design
//   relatively simple.  Unimplemented instructions are ARM
//   Version 5 Thumb instructions, instructions using the high
//   (R8-R15) registers, LDMIA, STMIA, and PUSH and POP with the
//   PC register or multiple registers.  The specific
//   unimplemented instructions, as listed in [ARM 2000], are
//   ADD(4), BKPT, BLX(H=01), BLX(2), BX, CMP(3), LDMIA, MOV(3),
//   POP(>1 register), POP(PC), PUSH(>1 register), PUSH(PC),
//   STMIA, and SWI (implemented as HALT only).

// INCLUDE files
//`include "thumb_defs.vh"    // global constant definitions

// MODULE DECLARATION
module thumb (read_instruction_n, instruction_address,
              instruction, read_data_n, write_data_n,
              data_address, data, reset_n, clk);
  output read_instruction_n;  // enable read from instruction mem
  output [`WORD_SIZE-1:0] instruction_address; // instr. address
  input [`HWORD_SIZE-1:0] instruction;  // current instruction
  output read_data_n;     // enable read from data memory
  output write_data_n;    // enable write to data memory
  output [`WORD_SIZE-1:0] data_address; // address of data
  inout [`WORD_SIZE-1:0] data;          // current data
  input reset_n;    // active-low RESET signal
  input clk;        // clock signal

  // SIGNAL DECLARATIONS for chip inputs and outputs
  wire read_instruction_n, read_data_n, write_data_n;
  wire [`WORD_SIZE-1:0] instruction_address;
  wire [`WORD_SIZE-1:0] data_address;
  wire [`HWORD_SIZE-1:0] instruction;
  wire [`WORD_SIZE-1:0] data;
  wire reset_n;
  wire clk;
  
  // SIGNAL DECLARATIONS for internal registers and wires
  wire [`WORD_SIZE-1:0] PC;        // program counter = R15

  // SIGNAL DECLARATIONS used to aid in the Verilog description
  wire branch_taken;       // indicates a branch has been taken
  wire [`WORD_SIZE-1:0] branch_target; // branch target address
  wire [`WORD_SIZE-1:0] DR;        // holds data to be output
  
  // Pipeline Regs (names prefixed with pipeline stage names)
  wire [`HWORD_SIZE-1:0] IF_IR;    // IR value stored at end of IF
  wire [`WORD_SIZE-1:0] IF_PC, ID_PC;           // saved PC value
  wire [`WORD_SIZE-1:0] ID_Rd, ID_Rn, ID_Rm_Rs; // Rd, Rn, Rm/Rs
  wire [`WORD_SIZE-1:0] EX_ALU_out;// ALU_out at end of EX stage
  wire [5:0] ID_opcode;
  wire [5:0] EX_opcode; // internal Thumb opcode
  wire [10:0] ID_imm_offset; // immediate, offset or register list
  wire [7:0] EX_imm_offset;  // 8 bits required in WB stage
  wire [3:0] ID_cond;        // ARM condition code (same as THUMB)
  wire [2:0] ID_Rd_code, EX_Rd_code;  // Rd register number

  // Passing parameters in the middle
  reg [`WORD_SIZE-1:0] R [`REG_FILE_SIZE-1:0]; // general regs
  reg [`WORD_SIZE * `REG_FILE_SIZE -1:0] R_flat_in;
  wire [`WORD_SIZE * `REG_FILE_SIZE -1:0] R_flat_out;
  integer i;

  // ASSIGN STATEMENTS
  assign instruction_address = PC;  // set instr. address to PC
  assign data = (~write_data_n) ? DR : 0;  // tri-state data

  // convert R to R_flat_in
  always @(*) begin
    for (i = 0; i < `REG_FILE_SIZE; i = i + 1) begin
      R_flat_in[i*`WORD_SIZE +: `WORD_SIZE] <= R[i];
    end
  end

  // convert R_flat_out to R
  always @(*) begin
    for (i = 0; i < `REG_FILE_SIZE; i = i + 1) begin
      R[i] <= R_flat_out[i*`WORD_SIZE +: `WORD_SIZE] ;
    end
  end

  // IF: Instruction Fetch Stage
  IF step1(
    //output
    PC,  
    IF_IR, IF_PC, 
    read_instruction_n,
    // input
    instruction, branch_taken, branch_target, 
    clk, reset_n
  );

  // ID: Instruction Decode Stage
  ID step2(
    // output
    ID_PC, ID_Rd, ID_Rn, ID_Rm_Rs, ID_imm_offset, ID_opcode, 
    ID_cond, ID_Rd_code, 
    // input
    IF_IR, IF_PC, R_flat_in,
    branch_taken, 
    clk, reset_n
  );

  // EX: Instruction Execution Stage
  EX step3(
    // output
    data_address, write_data_n, read_data_n,
    branch_taken, branch_target, DR,
    EX_ALU_out, EX_opcode, EX_imm_offset, EX_Rd_code,
    // input
    ID_PC, ID_opcode, ID_Rd, ID_Rn, ID_Rm_Rs, 
    ID_imm_offset, ID_Rd_code, ID_cond,
    R_flat_in,
    clk, reset_n
    );

  // WB: Write Back Stage (final stage)
  WB step4(
    // output
    R_flat_out,
    // input
    data,
    EX_opcode, EX_ALU_out, EX_imm_offset, EX_Rd_code,
    clk, reset_n
  );
endmodule
/////////////////////////////////////////////////////////////////
