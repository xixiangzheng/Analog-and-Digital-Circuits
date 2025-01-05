module Count4Ones(
    input       [2:0]         in,
    output reg  [1:0]         out
);
// Your codes should start from here.

reg [2:0] temp;

always @(*) begin
    out = 2'd0;
    temp = in;
    if (temp[0]) out = out + 2'd1;
    if (temp[1]) out = out + 2'd1;
    if (temp[2]) out = out + 2'd1;
end

// End of your codes.
endmodule