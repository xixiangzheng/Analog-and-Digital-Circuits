`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/08 20:28:45
// Design Name: 
// Module Name: top
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
    input           clk,
    input           btn,
    input   [7:0]   sw,
    output  [7:0]   led,
    output  [3:0]   d,
    output  [2:0]   an
);

wire    [7:0]   res;
assign  led = res[7:0];

MUL mul(
    .clk(clk),
    .rst(sw[7]),
    .start(btn),
    .a({{1'b0}, {sw[6:4]}}),
    .b(sw[3:0]),
    .res(res),
    .finish()
);

Segment segment(
    .clk(clk),
    .rst(rst),
    .output_data({{24'b0}, {res[7:0]}}),
    .output_valid(8'b00000011),
    .seg_data(d),
    .seg_an(an)
);
endmodule
