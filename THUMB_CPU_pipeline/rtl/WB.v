// MODULE: WB Stage
module WB(
    input wire clk,
    input wire reset_n,
    input wire [5:0] EX_opcode,
    input wire [`WORD_SIZE-1:0] EX_ALU_out,
    input wire [`WORD_SIZE-1:0] data,
    input wire [2:0] EX_Rd_code,
    output reg [`WORD_SIZE-1:0] R [`REG_FILE_SIZE-1:0]
);
  integer wb_i, found_wb_i;
  always @(negedge reset_n or posedge clk) begin
    if (~reset_n) begin
      for (wb_i = 0; wb_i < `REG_FILE_SIZE; wb_i = wb_i + 1)
        R[wb_i] <= 0; // Reset all registers
    end else begin
      case (EX_opcode)
        `ADC, `ADD_1, `ADD_2, `ADD_3, `ADD_5, `ADD_6, `AND,
        `ASR_1, `ASR_2, `BIC, `EOR, `LSL_1, `LSL_2, `LSR_1,
        `LSR_2, `MOV_1, `ROR, `SBC, `SUB_1, `SUB_2, `SUB_3, `SUB_4:
          R[EX_Rd_code] <= EX_ALU_out;
        `LDR_1, `LDR_2, `LDR_3, `LDR_4:
          R[EX_Rd_code] <= data;
        `LDRB_1, `LDRB_2:
          R[EX_Rd_code] <= {24'b0, data[7:0]};
        `LDRH_1, `LDRH_2:
          R[EX_Rd_code] <= {16'b0, data[`HWORD_SIZE-1:0]};
        `LDRSB:
          R[EX_Rd_code] <= data[7] ? {24'hffffff, data[7:0]} : {24'h000000, data[7:0]};
        `LDRSH:
          R[EX_Rd_code] <= data[`HWORD_SIZE-1] ? {16'hffff, data[`HWORD_SIZE-1:0]} : {16'h0000, data[`HWORD_SIZE-1:0]};
        `POP_R0: begin
          found_wb_i = 0;
          for (wb_i = 0; wb_i < `REG_FILE_SIZE; wb_i = wb_i + 1)
            if (EX_Rd_code[wb_i])
              found_wb_i = wb_i;
          R[found_wb_i] <= data;
        end
        `UNDEF: found_wb_i = 32'bx;
        default: found_wb_i = 32'bx;
      endcase
    end
  end
endmodule
