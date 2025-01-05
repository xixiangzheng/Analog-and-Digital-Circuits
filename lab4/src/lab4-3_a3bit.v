`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 13:02:55
// Design Name: 
// Module Name: lab4
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


module adder3bit(
    input           [2:0]         a,
    input           [2:0]         b,
    output          [2:0]         out,
    output                        Cout
);

// Write your code here
wire tmp1;
FullAdder fa1(
    .a(a[0]),
    .b(b[0]),
    .cin(0),
    .s(out[0]),
    .cout(tmp1)
);

FullAdder fa2(
    .a(a[1]),
    .b(b[1]),
    .cin(tmp1),
    .s(out[1]),
    .cout(tmp2)
);

FullAdder fa3(
    .a(a[2]),
    .b(b[2]),
    .cin(tmp2),
    .s(out[2]),
    .cout(Cout)
);
// End of your code
endmodule