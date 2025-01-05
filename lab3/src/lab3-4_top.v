`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 18:15:33
// Design Name: 
// Module Name: lab3-3_top
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

module Top(
    input                   clk,
    input                   btn,
    input  [7:0]            sw,
    output [2:0]            seg_an,
    output [3:0]            seg_data
);
Segment segment(
    .clk(clk),
    .rst(btn),
    .output_data(32'h23000020),
    .output_valid(sw),
    .seg_data(seg_data),
    .seg_an(seg_an)
);
endmodule