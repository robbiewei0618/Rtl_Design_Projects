`define REG_LEN 482+482+3-1
module LineBuffer(clk, rst, Y, en, R0, R1, R2, R3, R4, R5, R6, R7, R8);
    input clk, rst;
    input  signed [19:0] Y;
    output reg en;
    output reg signed [19:0] R0, R1, R2, R3, R4, R5, R6, R7, R8;

    integer i;
    // position (padded image, 482 wide) of the pixel now in Regs[`REG_LEN]
    reg [8:0] col, row;
    reg       have_pixel;
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
            col <= 0;
            row <= 0;
            have_pixel <= 0;
            en <= 0;
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

            // R0..R8 now receive the window that ends at the pixel in
            // Regs[`REG_LEN]; it is a real 3x3 window iff that pixel is at
            // column >= 2 and row >= 2 (otherwise it wraps around a row end
            // or still contains the rows before the image).
            en <= have_pixel && (col >= 9'd2) && (row >= 9'd2);

            // position of the pixel captured at this edge
            have_pixel <= 1'b1;
            if (!have_pixel) begin
                col <= 9'd0;
                row <= 9'd0;
            end else if (col == 9'd481) begin
                col <= 9'd0;
                row <= row + 9'd1;
            end else begin
                col <= col + 9'd1;
            end
        end
    end
endmodule