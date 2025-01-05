`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/07 22:59:54
// Design Name: 
// Module Name: lab6-1_tb
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


module Adder_tb();
reg     [31:0]  a,b;
reg             ci;
wire    [31:0]  s;
wire            co;

initial begin
    a=32'hffff; b=32'hffff; ci=1'b1;
    #10;
    a=32'h0f0f; b=32'hf0f0; ci=1'b1;
    #10;
    a=32'h1234; b=32'h4321; ci=1'b0;
    #10;
    a=32'h0000; b=32'h0000; ci=1'b0;
    #10;
    a=32'hffffffff; b=32'hffffffff; ci=1'b1;
    #10;
    a=32'h12345678; b=32'h87654321; ci=1'b0;
    #10;
    a=32'h11111111; b=32'h11111111; ci=1'b0;
    #10;
    a=32'h1111; b=32'h1111; ci=1'b1;
    #10;
    a=32'habcd; b=32'hbcda; ci=1'b0;
end

Adder adder(
    .a(a),
    .b(b),
    .ci(ci),
    .s(s),
    .co(co)
);

endmodule