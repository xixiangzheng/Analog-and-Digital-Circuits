`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/07 23:39:21
// Design Name: 
// Module Name: sub
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


module Sub(
    input                   [ 4 : 0]        a, b,
    output                  [ 4 : 0]        out,
    output                  [ 0 : 0]        co
);

Adder adder_sub(
    .a(a),
    .b(~b),
    .ci(1),
    .s(out),
    .co(co)
);
endmodule
