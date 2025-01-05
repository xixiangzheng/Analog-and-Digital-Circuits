`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 18:17:00
// Design Name: 
// Module Name: lab3-3_tb
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


module Top_tb();
reg clk;
reg btn;
reg [7:0]   sw;
wire [2:0]  seg_an;
wire [3:0]  seg_data;

initial begin
    clk = 2'b0;
    btn = 2'b1;
    sw = 8'b11110000;
    #10 btn = 2'b0;
    #40000000 sw = 8'b01010101;
    #40000000 sw = 8'b11111111;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .btn(btn),
    .sw(sw),
    .seg_an(seg_an),
    .seg_data(seg_data)
);
endmodule