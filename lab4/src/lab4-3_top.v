`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 15:09:54
// Design Name: 
// Module Name: m
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiple5(
    input           [7:0]          num,
    output   reg                   ismultiple5
);

// Write your code here
// Use the 2-bits adder, or you will not get the score!
wire [2:0] tmp1;
wire [2:0] tmp2;
wire [3:0] tmp3;
wire [3:0] tmp4;

adder2bit a2bit1(
    .a(num[1:0]),
    .b(num[5:4]),
    .out(tmp1[1:0]),
    .Cout(tmp1[2])
);

adder2bit a2bit2(
    .a(num[3:2]),
    .b(num[7:6]),
    .out(tmp2[1:0]),
    .Cout(tmp2[2])
);

adder3bit a3bit1(
    .a(tmp1),
    .b(3'b101),
    .out(tmp3[2:0]),
    .Cout(tmp3[3])
);


adder3bit a3bit2(
    .a(tmp2),
    .b(3'b101),
    .out(tmp4[2:0]),
    .Cout(tmp4[3])
);


always @(*) begin
    if (tmp1 == tmp2 | {0, tmp1} == tmp4 | tmp3 == {0, tmp2}) begin
        ismultiple5 = 1;
    end
    else begin
        ismultiple5 = 0;
    end
end

// End of your code
endmodule
