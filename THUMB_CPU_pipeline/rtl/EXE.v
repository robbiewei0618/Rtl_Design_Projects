// MODULE: EX Stage
module EX(
    input wire clk,
    input wire reset_n,
    input wire [5:0] ID_opcode,
    input wire [`WORD_SIZE-1:0] ID_Rd, ID_Rn, ID_Rm_Rs,
    input wire [10:0] ID_imm_offset,
    input wire [3:0] ID_cond,
    output reg branch_taken,
    output reg [`WORD_SIZE-1:0] branch_target,
    output reg read_data_n,
    output reg write_data_n,
    output reg [`WORD_SIZE-1:0] EX_ALU_out,
    output reg [2:0] EX_Rd_code
);
  // Insert the execution logic from the original code here.
  // Ensure that results of execution are assigned to outputs.
  always @(negedge reset_n or posedge clk) begin
    if (~reset_n) begin
      branch_taken <= 1'b0;
      read_data_n <= 1'b1;
      write_data_n <= 1'b1;
    end else begin
              read_data_n <= 1'b1;   // set default values for data mem.
      write_data_n <= 1'b1;
      if (branch_taken) begin
        EX_opcode <= `UNDEF;
        branch_taken <= 1'b0;
      end
      else begin
        case (ID_opcode)  // 1st part of EX operations
          `ADC: ALU_out = ID_Rd + ID_Rm_Rs + C_Flag;
          `ADD_1: ALU_out = ID_Rn + ID_imm_offset[2:0];
          `ADD_2: ALU_out = ID_Rd + ID_imm_offset[7:0];
          `ADD_3: ALU_out = ID_Rn + ID_Rm_Rs;
          `ADD_5: EX_ALU_out <= (ID_PC & 33'hfffffffc)
            + {ID_imm_offset[7:0], 2'b00}; // 33 = `WORD_SIZE+1
          `ADD_6: EX_ALU_out <= SP + {ID_imm_offset[7:0], 2'b00};
          `ADD_7: SP <= SP + {ID_imm_offset[7:0], 2'b00};
          `AND: ALU_out = ID_Rd & ID_Rm_Rs;
          `ASR_1: begin
            if (ID_imm_offset[4:0] == 0) begin
              if (ID_Rm_Rs[`WORD_SIZE-1] == 0)
                ALU_out = 0;
              else
                ALU_out = 33'h1ffffffff; //(`WORD_SIZE+1) = 33
            end
            else begin  // imm != 0
              ALU_out = {1'b0, ID_Rm_Rs};
              for (i = 0;  i < `WORD_SIZE;  i = i + 1) begin
                if (i < ID_imm_offset[4:0]) begin
                  {ALU_out[`WORD_SIZE-1:0], ALU_out[`WORD_SIZE]} =
                    {ALU_out[`WORD_SIZE-1:0], ALU_out[`WORD_SIZE]} >> 1;
                  ALU_out[`WORD_SIZE-1] = ID_Rm_Rs[`WORD_SIZE-1];
                end // of if
              end // of for
            end // of else if imm != 0
          end // of case `ASR_1
          `ASR_2: begin
            if (ID_Rm_Rs[7:0] < `WORD_SIZE) begin
              ALU_out = {1'b0, ID_Rd};
              for (i = 0;  i < `WORD_SIZE;  i = i + 1) begin
                if (i < ID_Rm_Rs[7:0]) begin
                  {ALU_out[`WORD_SIZE-1:0], ALU_out[`WORD_SIZE]} =
                    {ALU_out[`WORD_SIZE-1:0], ALU_out[`WORD_SIZE]} >> 1;
                  ALU_out[`WORD_SIZE-1] = ID_Rd[`WORD_SIZE-1];
                end // of if
              end // of for
            end // of if (Rs[7:0] < `WORD_SIZE)
            else begin // Rs[7:0] >= `WORD_SIZE
              if (ID_Rd[`WORD_SIZE-1] == 0)
                ALU_out = 0;
              else // Rd[`WORD_SIZE-1] == 1
                ALU_out = 33'h1ffffffff; // (`WORD_SIZE+1) = 33
            end // of else if Rs[7:0] >= `WORD_SIZE
          end // of case `ASR_2
          `B_1: begin  // conditional branch
            if (condition_passed(ID_cond)) begin
              for (i = `WORD_SIZE-1;  i > 8;  i = i - 1)
                ALU_out[i] = ID_imm_offset[7]; // sign-extension
              ALU_out[8:1] = ID_imm_offset[7:0];
              ALU_out[0] = 1'b0;
              branch_taken <= 1'b1;
              branch_target <= ID_PC+2 + ALU_out[`WORD_SIZE-1:0];
            end
          end // of case `B_1
          `B_2: begin  // unconditional branch
            for (i = `WORD_SIZE-1;  i > 11;  i = i - 1)
              ALU_out[i] = ID_imm_offset[10]; // sign-extension
            ALU_out[11:1] = ID_imm_offset[10:0];
            ALU_out[0] = 1'b0;
            branch_taken <= 1'b1;
            branch_target <= (ID_PC+2) + ALU_out[`WORD_SIZE-1:0];
          end // of case `B_2
          `BIC: ALU_out[`WORD_SIZE-1:0] = ID_Rd & (~ID_Rm_Rs);
          `BL_BLX_H10: begin
            for (i = `WORD_SIZE-1;  i > 22;  i = i - 1)
              ALU_out[i] = ID_imm_offset[10];
            ALU_out[22:12] = ID_imm_offset[10:0];
            for (i = 11;  i >= 0;  i = i - 1)
              ALU_out[i] = 1'b0;
            LR <= ID_PC + ALU_out[`WORD_SIZE-1:0];
          end // of case `BL_BLX_H10
          `BL_BLX_H11: begin
            ALU_out = LR + {ID_imm_offset[10:0], 1'b0};
            branch_taken <= 1'b1;
            branch_target <= ALU_out[`WORD_SIZE-1:0];
            LR <= ALU_out[`WORD_SIZE-1:0] | 'h00000001;
          end // of case `BL_BLX_H11
          `CMN: ALU_out = ID_Rn + ID_Rm_Rs;
          `CMP_1: ALU_out = ID_Rn - ID_imm_offset[7:0];
          `CMP_2: ALU_out = ID_Rn - ID_Rm_Rs;
          `EOR: ALU_out = ID_Rd ^ ID_Rm_Rs; // Exclusive-OR
          //`LDMIA: null; // currently unimplemented
          `LDR_1: ALU_out = ID_Rn + {ID_imm_offset[4:0], 2'b00};
          `LDR_2, `LDRB_2, `LDRH_2, `LDRSB, `LDRSH:
                  ALU_out = ID_Rn + ID_Rm_Rs;
          `LDR_3: ALU_out = {ID_PC[`WORD_SIZE-1:2], 2'b00}
                            + {ID_imm_offset[7:0], 2'b00};
          `LDR_4: ALU_out = SP + {ID_imm_offset[7:0], 2'b00};
          `LDRB_1: ALU_out = ID_Rn + ID_imm_offset[4:0];
          `LDRH_1: ALU_out = ID_Rn + {ID_imm_offset[4:0], 1'b0};
          `LSL_1: ALU_out = {1'b0,ID_Rm_Rs} <<ID_imm_offset[4:0];
          `LSL_2: if (ID_Rm_Rs[7:0] <= `WORD_SIZE)
                    ALU_out = {1'b0, ID_Rd} << ID_Rm_Rs[7:0];
                  else
                    ALU_out = 0;
          `LSR_1: {ALU_out[`WORD_SIZE-1:0], ALU_out[`WORD_SIZE]}
                    = {ID_Rm_Rs, 1'b0} >> ID_imm_offset[4:0];         
          `LSR_2: if (ID_Rm_Rs[7:0] <= `WORD_SIZE)
                    {ALU_out[`WORD_SIZE-1:0],ALU_out[`WORD_SIZE]}
                      = {ID_Rd, 1'b0} >> ID_Rm_Rs[7:0];         
                  else
                    ALU_out = 0;
          `MOV_1: ALU_out[`WORD_SIZE-1:0] =
                    {24'b0, ID_imm_offset[7:0]};
          `MUL: ALU_out[`WORD_SIZE-1:0] = ID_Rd * ID_Rm_Rs;
          `MVN: ALU_out[`WORD_SIZE-1:0] = ~ID_Rm_Rs;
          `NEG: ALU_out = 0 - {ID_Rm_Rs[`WORD_SIZE-1], ID_Rm_Rs};
          `ORR: ALU_out[`WORD_SIZE-1:0] = ID_Rd | ID_Rm_Rs;
          `POP_R0: begin // only POP of 1 register supported
            data_address <= SP;
            read_data_n <= 1'b0;
            SP <= SP + 4;
            EX_imm_offset[7:0] <= ID_imm_offset[7:0];
          end // of case `POP_R0
          //`POP_R1: null; // POP(PC) not supported yet
          `PUSH_R0: begin // only PUSH of 1 register supported
            ALU_out[`WORD_SIZE-1:0] = SP - 4;
            found_i = 0;
            for (i = 0;  i < `REG_FILE_SIZE; i = i + 1)
              if (ID_imm_offset[i]) // at least 1 bit must = 1
                found_i = i;
            DR <= R[found_i];
            write_data_n <= 1'b0;
            data_address <= ALU_out[`WORD_SIZE-1:0];
            SP <= ALU_out[`WORD_SIZE-1:0];
            EX_imm_offset[7:0] <= ID_imm_offset[7:0];
          end // of case `PUSH_R0
          //`PUSH_R1: null; // PUSH(PC) not supported yet
          `ROR: {ALU_out[`WORD_SIZE-1:0], ALU_out[`WORD_SIZE]} =
                    {ID_Rd, 1'b0} >> ID_Rm_Rs[4:0];         
          `SBC: ALU_out = ID_Rd - ID_Rm_Rs - (~C_Flag);
          //`STMIA: null; // not supported yet
          `STR_1: ALU_out = ID_Rn + {ID_imm_offset[4:0], 2'b00};
          `STR_2, `STRB_2, `STRH_2:
                  ALU_out = ID_Rn + ID_Rm_Rs;
          `STR_3: ALU_out = SP + {ID_imm_offset[7:0], 2'b00};
          `STRB_1: ALU_out = ID_Rn + ID_imm_offset[4:0];
          `STRH_1: ALU_out = ID_Rn + {ID_imm_offset[4:0], 1'b0};
          `SUB_1: ALU_out = ID_Rn - ID_imm_offset[2:0];
          `SUB_2: ALU_out = ID_Rn - ID_imm_offset[7:0];
          `SUB_3: ALU_out = ID_Rn - ID_Rm_Rs;
          `SUB_4: SP <= SP - {ID_imm_offset[6:0], 2'b00};
          `SWI: begin // currently implemented as a HALT instr.
            branch_taken <= 1'b1;
            branch_target <= ID_PC - 2; // repeat SWI forever
          end
          `TST: begin
            ALU_out = ID_Rn & ID_Rm_Rs;
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
          end
          default: ALU_out = 'bx;  // added for completeness
        endcase
        case (ID_opcode)  // 2nd part of EX operations
          `ADD_1: begin // note: (imm == 000) implies MOV_2
            EX_ALU_out[`WORD_SIZE-1:0] <=ALU_out[`WORD_SIZE-1:0];
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
            if (ID_imm_offset[2:0] != 3'b000) begin  // not MOV_2
              C_Flag <= ALU_out[`WORD_SIZE];
              V_Flag <=
                (ALU_out[`WORD_SIZE] != ALU_out[`WORD_SIZE-1]);
            end
          end
          `ADC, `ADD_2, `ADD_3, `CMN, `CMP_1, `CMP_2,
          `NEG, `SBC, `SUB_1, `SUB_2, `SUB_3, `SUB_4: begin
            EX_ALU_out[`WORD_SIZE-1:0] <= ALU_out[`WORD_SIZE-1:0];
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
            C_Flag <= ALU_out[`WORD_SIZE];
            V_Flag <=
              (ALU_out[`WORD_SIZE] != ALU_out[`WORD_SIZE-1]);
          end
          `ASR_1, `ASR_2, `LSL_1, `LSL_2, `LSR_2: begin
            EX_ALU_out[`WORD_SIZE-1:0] <=ALU_out[`WORD_SIZE-1:0];
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
            C_Flag <= ALU_out[`WORD_SIZE];
          end
          `LDR_1, `LDR_2, `LDR_3, `LDR_4, `LDRB_1, `LDRB_2,
          `LDRH_1, `LDRH_2, `LDRSB, `LDRSH: begin
            data_address <= ALU_out[`WORD_SIZE-1:0];
            read_data_n <= 1'b0;
          end
          `LSR_1: begin
            if (ID_imm_offset[4:0] == 0) begin
              C_Flag <= ALU_out[`WORD_SIZE-1];
              EX_ALU_out[`WORD_SIZE-1:0] <= 'b0;
            end
            else begin
              C_Flag <= ALU_out[`WORD_SIZE];
              EX_ALU_out[`WORD_SIZE-1:0] <=
                ALU_out[`WORD_SIZE-1:0];
            end
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
          end // of case `LSR_1
          `AND, `BIC, `EOR, `MOV_1, `MUL, `MVN, `ORR: begin
            EX_ALU_out[`WORD_SIZE-1:0] <=
              ALU_out[`WORD_SIZE-1:0];
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
          end
          `ROR: begin
            if (ID_Rm_Rs[7:0] == 0)
              EX_ALU_out[`WORD_SIZE-1:0] <= ID_Rd;
            else if (ID_Rm_Rs[4:0] == 0) begin
              C_Flag <= ALU_out[`WORD_SIZE-1];
              EX_ALU_out[`WORD_SIZE-1:0] <= ID_Rd;
            end
            else begin // Rs[4:0] > 0
              C_Flag <= ALU_out[`WORD_SIZE];
              EX_ALU_out[`WORD_SIZE-1:0] <=
                ALU_out[`WORD_SIZE-1:0];
            end
            N_Flag <= ALU_out[`WORD_SIZE-1];
            Z_Flag <= (ALU_out[`WORD_SIZE-1:0] == 0);
          end // of case `ROR
          `STR_1, `STR_2, `STR_3, `STRB_1, `STRB_2, `STRH_1,
          `STRH_2: begin
            data_address <= ALU_out[`WORD_SIZE-1:0];
            DR <= ID_Rd;
            write_data_n <= 1'b0;
          end
          default: EX_ALU_out <= 'bx;
        endcase // of second case
        // then save values into pipeline registers
        EX_opcode <= ID_opcode;
        EX_Rd_code <= ID_Rd_code;
      end // of else (branch not taken)
    end // of else (posedge clk)
  end // of EX stage
      // Execution logic from the original code (case structures)
      // Assign EX_ALU_out, branch_taken, branch_target, etc.
endmodule