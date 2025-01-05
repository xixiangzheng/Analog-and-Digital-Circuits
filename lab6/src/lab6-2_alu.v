`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/07 23:40:11
// Design Name: 
// Module Name: ALU
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


module ALU(
    input                   [31 : 0]        src0, src1,
    input                   [11 : 0]        sel,
    output                  [31 : 0]        res
);
// Write your code here
wire [31:0] adder_out;
wire [31:0] sub_out;
wire [0 :0] slt_out;
wire [0 :0] sltu_out;
wire [31:0] and_out;
wire [31:0] or_out;
wire [31:0] nor_out;
wire [31:0] xor_out;
wire [31:0] sll_out;
wire [31:0] srl_out;
wire [31:0] sra_out;
wire [31:0] src1_out;

Adder adder(
    .a(src0),
    .b(src1),
    .ci(0),
    .s(adder_out),
    .co()
);

Sub sub(
    .a(src0),
    .b(src1),
    .out(sub_out),
    .co()
);

Comp comp(
    .a(src0),
    .b(src1),
    .ul(sltu_out),
    .sl(slt_out)
);

assign and_out = src0 & src1;
assign or_out = src0 | src1;
assign nor_out = ~(src0 | src1);
assign xor_out = src0 ^ src1;
assign sll_out = src0 << src1[4:0];
assign srl_out = src0 >> src1[4:0];
assign sra_out = src0 >>> src1[4:0];
assign src1_out = src1;

// TODO：完成 res 信号的选择
assign res = ({32{sel[0]}} & adder_out) |
             ({32{sel[1]}} & sub_out) |
             ({32{sel[2]}} & slt_out) |
             ({32{sel[3]}} & sltu_out) |
             ({32{sel[4]}} & and_out) |
             ({32{sel[5]}} & or_out) |
             ({32{sel[6]}} & nor_out) |
             ({32{sel[7]}} & xor_out) |
             ({32{sel[8]}} & sll_out) |
             ({32{sel[9]}} & srl_out) |
             ({32{sel[10]}} & sra_out) |
             ({32{sel[11]}} & src1_out);

endmodule