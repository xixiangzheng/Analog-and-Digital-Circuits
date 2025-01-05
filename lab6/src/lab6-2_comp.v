`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/07 23:39:47
// Design Name: 
// Module Name: comp
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


module Comp(
    input                   [31 : 0]        a, b,
    output                  [ 0 : 0]        ul,
    output                  [ 0 : 0]        sl
);

wire flag;
assign ul = ~flag;
assign sl = (a[31] == b[31]) ? ~flag : flag;

Sub sub_comp(
    .a(a),
    .b(b),
    .out(),
    .co(flag)
);
 
endmodule
