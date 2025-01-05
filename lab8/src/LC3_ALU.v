`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 15:31:43
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
    input                   [15 : 0]        src0,       // 数据源 0    
    input                   [15 : 0]        src1,       // 数据源 1  
    input                   [ 3 : 0]        sel,        // 运算选择
    output                  [15 : 0]        res         // 运算结果
);

wire [15:0] add_out;        // ADD 运算，对应 sel = 4'b0001
wire [15:0] and_out;        // AND 运算，对应 sel = 4'b0010
wire [15:0] not_out;        // NOT 运算，对应 sel = 4'b0100
wire [15:0] src1_out;       // src 直出，对应 sel = 4'b1000

assign add_out = src0 + src1;
assign and_out = src0 & src1;
assign not_out = ~src0;
assign src1_out = src1;

assign res = ({16{sel[0]}} & add_out) |
             ({16{sel[1]}} & and_out) |
             ({16{sel[2]}} & not_out) |
             ({16{sel[3]}} & src1_out);

endmodule