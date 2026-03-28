`define REG_LEN 482+482+3-1
module LineBuffer(clk, rst, Y, en, R0, R1, R2, R3, R4, R5, R6, R7, R8);
    input clk, rst;
    input  signed [19:0] Y;
    output reg en;
    output reg signed [19:0] R0, R1, R2, R3, R4, R5, R6, R7, R8;

    integer i, counter;
    reg signed [19:0] Regs[0:`REG_LEN];

    always @ (posedge clk or negedge rst) begin
        if (~rst) begin
            R0 <= 0;
            R1 <= 0;
            R2 <= 0;
            R3 <= 0;
            R4 <= 0;
            R5 <= 0;
            R6 <= 0;
            R7 <= 0;
            R8 <= 0;
            counter <= 0;
        end
        else begin
            for (i = 0; i < `REG_LEN; i=i+1) begin
                Regs[i] <= Regs[i+1];
            end
            Regs[`REG_LEN] <= Y;
            
            R0 <= Regs[0];
            R1 <= Regs[1];
            R2 <= Regs[2];

            R3 <= Regs[482];
            R4 <= Regs[483];
            R5 <= Regs[484];

            R6 <= Regs[964];
            R7 <= Regs[965];
            R8 <= Regs[966];

            if (counter == 481 || counter == 0)
                en <= 0;
            else
                en <= 1;
            counter <= (counter == 481 ? 0 : counter + 1);
        end
    end
endmodule