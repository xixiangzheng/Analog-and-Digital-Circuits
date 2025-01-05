`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 13:12:55
// Design Name: 
// Module Name: lab
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

module FullAdder (
    input       a, b, cin,
    output      s, cout
);
wire temp_s, temp_c_1, temp_c_2;
HalfAdder ha1(
    .a(a),
    .b(b),
    .s(temp_s),
    .c(temp_c_1)
);

HalfAdder ha2(
    .a(temp_s),
    .b(cin),
    .s(s),
    .c(temp_c_2)
);

HalfAdder ha3(
    .a(temp_c_1),
    .b(temp_c_2),
    .s(cout),
    .c()
);
endmodule