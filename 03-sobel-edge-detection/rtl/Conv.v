module Conv(threshold, R0, R1, R2, R3, R4, R5, R6, R7, R8, x, y);
    input signed [19:0] threshold;
    input signed [19:0] R0, R1, R2, R3, R4, R5, R6, R7, R8;
    output reg [7:0] x, y;
    reg signed [19:0] Gx, Gy;
    always @ (*) begin
        Gx <= ((R2 - R0) + (R5 - R3)) + ((R5 - R3) + (R8 - R6));
        if (Gx > threshold)
            x <= 8'd255;
        else
            x <= 0;

        Gy <= ((R0 - R6) + (R1 - R7)) + ((R1 - R7) + (R2 - R8));
        if (Gy > threshold)
            y <= 8'd255;
        else
            y <= 0;
    end
endmodule