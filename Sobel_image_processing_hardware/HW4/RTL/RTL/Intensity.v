module Intensity(R, G, B, Y);
    input  [7:0] R, G, B;
    output signed [19:0] Y;
    assign Y = (R >> 2) + (R >> 5) + (G >> 1) + (G >> 4) + ((B >> 3) - (B >> 7));
endmodule