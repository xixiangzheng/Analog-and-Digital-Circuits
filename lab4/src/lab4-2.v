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


module adder2bit(
    input           [1:0]         a,
    input           [1:0]         b,
    output          [1:0]         out,
    output                        Cout
);

// Write your code here
wire tmp;
FullAdder fa1(
    .a(a[0]),
    .b(b[0]),
    .cin(0),
    .s(out[0]),
    .cout(tmp)
);

FullAdder fa2(
    .a(a[1]),
    .b(b[1]),
    .cin(tmp),
    .s(out[1]),
    .cout(Cout)
);
// End of your code
endmodule