module WB(
    output reg [`WORD_SIZE * `REG_FILE_SIZE -1:0] R_flat,
    input [`WORD_SIZE-1:0] data,
    input [5:0] EX_opcode,
    input [`WORD_SIZE-1:0] EX_ALU_out,
    input [7:0] EX_imm_offset,
    input [2:0] EX_Rd_code,
    input clk,
    input reset_n
);
integer wb_i;        // index variables
integer found_wb_i;    // used for searching
integer i;
reg [`WORD_SIZE-1:0] R [`REG_FILE_SIZE-1:0];

// convert R_flat to R
always @(*)begin
    for (i = 0; i < `REG_FILE_SIZE; i = i + 1) begin
      R_flat[i*`WORD_SIZE +: `WORD_SIZE] <= R[i];
    end
end

always @(negedge reset_n or posedge clk) begin
    if (~reset_n) begin
        for (wb_i = 0;  wb_i < `REG_FILE_SIZE;  wb_i = wb_i + 1)
            R[wb_i] <= 'hffffffff;  // initialize general registers
    end
    else case (EX_opcode)
        `ADC, `ADD_1, `ADD_2, `ADD_3, `ADD_5, `ADD_6, `AND,
        `ASR_1, `ASR_2, `BIC, `EOR, `LSL_1, `LSL_2, `LSR_1,
        `LSR_2, `MOV_1, `ROR,
        `SBC, `SUB_1, `SUB_2, `SUB_3, `SUB_4:
            R[EX_Rd_code] <= EX_ALU_out;  // write back to Rd
        `LDR_1, `LDR_2, `LDR_3, `LDR_4:
            R[EX_Rd_code] <= data;  // read data from data memory
        `LDRB_1, `LDRB_2: R[EX_Rd_code] <= {24'b0, data[7:0]};
        `LDRH_1, `LDRH_2: R[EX_Rd_code] <=
                    {16'b0, data[`HWORD_SIZE-1:0]};
        `LDRSB: if (data[7])
                    R[EX_Rd_code] <= {24'hffffff, data[7:0]};
                else
                    R[EX_Rd_code] <= {24'h000000, data[7:0]};
        `LDRSH: if (data[`HWORD_SIZE-1])
                R[EX_Rd_code] <=             // 16 = `HWORD_SIZE
                    {16'hffff, data[`HWORD_SIZE-1:0]};
                else
                    R[EX_Rd_code] <=             // 16 = `HWORD_SIZE
                        {16'h0000, data[`HWORD_SIZE-1:0]};
        `POP_R0: begin
            found_wb_i = 0;
            for (wb_i = 0;  wb_i < `REG_FILE_SIZE;  wb_i = wb_i + 1)
                if (EX_imm_offset[wb_i]) // at least 1 bit must = 1
                    found_wb_i = wb_i;
            R[found_wb_i] <= data;
            end // of case `POP_R0
            `UNDEF: found_wb_i = 32'bx;
            default: found_wb_i = 32'bx;
        endcase
    end // of WB stage
endmodule