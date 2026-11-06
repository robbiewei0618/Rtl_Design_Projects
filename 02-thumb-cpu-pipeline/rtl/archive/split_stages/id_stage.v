module ID(
    output reg [`WORD_SIZE-1:0] ID_PC,
    output reg [`WORD_SIZE-1:0] ID_Rd, 
    output reg [`WORD_SIZE-1:0] ID_Rn, 
    output reg [`WORD_SIZE-1:0] ID_Rm_Rs,
    output reg [10:0] ID_imm_offset,
    output reg [5:0] ID_opcode,
    output reg [3:0] ID_cond, 
    output reg [2:0] ID_Rd_code,
    
    input [`HWORD_SIZE-1:0] IF_IR,
    input [`WORD_SIZE-1:0] IF_PC,
    input [`WORD_SIZE * `REG_FILE_SIZE -1:0] R_flat,
    input branch_taken, 
    input clk,
    input reset_n
);
reg [`WORD_SIZE-1:0] R [`REG_FILE_SIZE-1:0];
integer i;

always @(*)begin
    for (i = 0; i < `REG_FILE_SIZE; i = i + 1) begin
      R[i] <= R_flat[i*`WORD_SIZE +: `WORD_SIZE];
    end
end

always @(negedge reset_n or posedge clk) begin
    if(~reset_n) begin
        ID_PC <= 32'h0000_0000;
        ID_Rd <= 32'h0000_0000;
        ID_Rn <= 32'h0000_0000;
        ID_Rm_Rs <= 32'h0000_0000;
        ID_imm_offset <= 11'b000_0000_0000;
        ID_opcode <= 6'b00_0000;
        ID_cond <= 4'b0000;
        ID_Rd_code <= 3'b000;
    end
    else begin
        case (IF_IR[`HWORD_SIZE-1:13])
        3'b000: begin // shift by immediate or add/sub
            case (IF_IR[12:11])
            2'b11: begin
                case (IF_IR[10:9])
                2'b10: begin // if imm = 000, same as MOV_2
                    ID_opcode <= `ADD_1;
                    ID_imm_offset[2:0] <= IF_IR[8:6];
                    ID_Rn <= R[IF_IR[5:3]];
                    ID_Rd <= R[IF_IR[2:0]];
                    ID_Rd_code <= IF_IR[2:0];
                end
                2'b00: begin
                    ID_opcode <= `ADD_3;
                    ID_Rm_Rs <= R[IF_IR[8:6]];
                    ID_Rn <= R[IF_IR[5:3]];
                    ID_Rd <= R[IF_IR[2:0]];
                    ID_Rd_code <= IF_IR[2:0];
                end
                2'b11: begin
                    ID_opcode <= `SUB_1;
                    ID_imm_offset[2:0] <= IF_IR[8:6];
                    ID_Rn <= R[IF_IR[5:3]];
                    ID_Rd <= R[IF_IR[2:0]];
                    ID_Rd_code <= IF_IR[2:0];
                end
                default: begin // == case 2'b01
                    ID_opcode <= `SUB_3;
                    ID_Rm_Rs <= R[IF_IR[8:6]];
                    ID_Rn <= R[IF_IR[5:3]];
                    ID_Rd <= R[IF_IR[2:0]];
                    ID_Rd_code <= IF_IR[2:0];
                end
                endcase
            end // of case IF_IR[12:11] = 2'b11
            2'b10: begin
                ID_opcode <= `ASR_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            2'b00: begin
                ID_opcode <= `LSL_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            default: begin // == case 2'b01
                ID_opcode <= `LSR_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            endcase
        end // of case IF_IR[15:13] = 3'b000
        3'b001: begin // add/sub/compare/move immediate
            case (IF_IR[12:11])
            2'b10: begin
                ID_opcode <= `ADD_2;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            2'b01: begin
                ID_opcode <= `CMP_1;
                ID_Rn <= R[IF_IR[10:8]];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            2'b00: begin
                ID_opcode <= `MOV_1;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            default: begin // == case 2'b11
                ID_opcode <= `SUB_2;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            endcase
        end // of case IF_IR[15:13] = 3'b001
        3'b010: begin // data processing
            casex (IF_IR[12:6])
            7'b000_0101: begin
                ID_opcode <= `ADC;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_0000: begin
                ID_opcode <= `AND;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_0100: begin
                ID_opcode <= `ASR_2;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1110: begin
                ID_opcode <= `BIC;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1011: begin
                ID_opcode <= `CMN;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rn <= R[IF_IR[2:0]];
            end
            7'b000_1010: begin
                ID_opcode <= `CMP_2;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rn <= R[IF_IR[2:0]];
            end
            7'b000_0001: begin
                ID_opcode <= `EOR;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_0010: begin
                ID_opcode <= `LSL_2;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_0011: begin
                ID_opcode <= `LSR_2;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_0111: begin
                ID_opcode <= `ROR;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_0110: begin
                ID_opcode <= `SBC;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1101: begin
                ID_opcode <= `MUL;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1111: begin
                ID_opcode <= `MVN;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1001: begin
                ID_opcode <= `NEG;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1100: begin
                ID_opcode <= `ORR;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b000_1000: begin
                ID_opcode <= `TST;
                ID_Rm_Rs <= R[IF_IR[5:3]];
                ID_Rn <= R[IF_IR[2:0]];
            end
            7'b1100_xxx: begin
                ID_opcode <= `LDR_2;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b01_xxxxx: begin
                ID_opcode <= `LDR_3;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            7'b1110_xxx: begin
                ID_opcode <= `LDRB_2;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b1101_xxx: begin
                ID_opcode <= `LDRH_2;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b1011_xxx: begin
                ID_opcode <= `LDRSB;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b1111_xxx: begin
                ID_opcode <= `LDRSH;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b1000_xxx: begin
                ID_opcode <= `STR_2;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b1010_xxx: begin
                ID_opcode <= `STRB_2;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            7'b1001_xxx: begin
                ID_opcode <= `STRH_2;
                ID_Rm_Rs <= R[IF_IR[8:6]];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            default: ID_opcode <= `UNDEF;
            endcase
        end // of case IF_IR[15:13] = 3'b010
        3'b011: begin // load/store word/byte immediate offset
            case (IF_IR[12:11])
            2'b01: begin
                ID_opcode <= `LDR_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            2'b11: begin
                ID_opcode <= `LDRB_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            2'b00: begin
                ID_opcode <= `STR_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            default: begin // == case 2'b10
                ID_opcode <= `STRB_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            endcase
        end // of case IF_IR[15:13] = 3'b011
        3'b100: begin // other load/store
            case (IF_IR[12:11])
            2'b11: begin
                ID_opcode <= `LDR_4;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            2'b01: begin
                ID_opcode <= `LDRH_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            2'b10: begin
                ID_opcode <= `STR_3;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            default: begin // == case 2'b00
                ID_opcode <= `STRH_1;
                ID_imm_offset[4:0] <= IF_IR[10:6];
                ID_Rn <= R[IF_IR[5:3]];
                ID_Rd <= R[IF_IR[2:0]];
                ID_Rd_code <= IF_IR[2:0];
            end
            endcase
        end // of case IF_IR[15:13] = 3'b100
        3'b101: begin // add to SP/PC or Miscellaneous
            case (IF_IR[12:11])
            2'b00: begin // add to PC and store in Rd
                ID_opcode <= `ADD_5;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            2'b01: begin // add to SP and store in Rd
                ID_opcode <= `ADD_6;
                ID_Rd <= R[IF_IR[10:8]];
                ID_Rd_code <= IF_IR[10:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            2'b10: begin // add imm_7 to SP
                case (IF_IR[10:8])
                3'b000: begin
                    if (IF_IR[7] == 1'b0) begin
                    ID_opcode <= `ADD_7;
                    ID_imm_offset[6:0] <= IF_IR[6:0];
                    end
                    else begin // IF_IR[7] == 1'b1
                    ID_opcode <= `SUB_4;
                    ID_imm_offset[6:0] <= IF_IR[6:0];
                    end
                end
                3'b100: begin
                    ID_opcode <= `PUSH_R0;
                    ID_imm_offset[7:0] <= IF_IR[7:0];
                end
                3'b101: begin
                    ID_opcode <= `PUSH_R1;
                    ID_imm_offset[7:0] <= IF_IR[7:0];
                end
                default: ID_opcode <= `UNDEF;
                endcase
            end // of case IF_IR[12:11] = 2'b10
            default: begin // == case 2'b11
                case (IF_IR[10:8])
                3'b100: begin
                    ID_opcode <= `POP_R0;
                    ID_imm_offset[7:0] <= IF_IR[7:0];
                end
                3'b101: begin
                    ID_opcode <= `POP_R1;
                    ID_imm_offset[7:0] <= IF_IR[7:0];
                end
                default: ID_opcode <= `UNDEF;
                endcase
            end // of case IF_IR[12:11] = 2'b11 (default)
            endcase
        end // of case IF_IR[15:13] = 3'b101
        3'b110: begin // load/store multiple, branch, interrupt
            case (IF_IR[12:11])
            2'b01: begin
                ID_opcode <= `LDMIA;
                ID_Rn <= R[IF_IR[10:8]];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            2'b00: begin
                ID_opcode <= `STMIA;
                ID_Rn <= R[IF_IR[10:8]];
                ID_imm_offset[7:0] <= IF_IR[7:0];
            end
            default: begin // has (IF_IR[12] == 1'b1)
                if (IF_IR[11:8] == 4'b1110) ID_opcode <= `UNDEF;
                else if (IF_IR[11:8] == 4'b1111) begin
                ID_opcode <= `SWI; // SWI used as HALT instruction
                ID_imm_offset[7:0] <= IF_IR[7:0];
                end
                else begin // others are valid conditional branch
                ID_opcode <= `B_1;
                ID_cond <= IF_IR[11:8];
                ID_imm_offset[7:0] <= IF_IR[7:0];
                end
            end // of case IF_IR[12] = 1'b1 (default)
            endcase
        end // of case IF_IR[15:13] = 3'b110
        3'b111: begin // uncond. branch or subroutine call (BL)
            case (IF_IR[12:11])
            2'b00: begin
                ID_opcode <= `B_2;
                ID_imm_offset <= IF_IR[10:0];
            end
            2'b10: begin
                ID_opcode <= `BL_BLX_H10;
                ID_imm_offset <= IF_IR[10:0];
            end
            2'b11: begin
                ID_opcode <= `BL_BLX_H11;
                ID_imm_offset <= IF_IR[10:0];
            end  // note: H=01 is not supported in T Variant 4
            default: ID_opcode <= `UNDEF;
            endcase
        end // of case IF_IR[15:13] = 3'b111
        default: ID_opcode <= `UNDEF; // added for completeness
        endcase
        // check for branch, and insert bubble if branch
        if (branch_taken)
        ID_opcode <= `UNDEF;
        // save other pipeline register values
        ID_PC <= IF_PC;
    end
end  // of ID stage
endmodule