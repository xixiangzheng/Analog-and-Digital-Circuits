`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/31 10:39:45
// Design Name: 
// Module Name: lab5-2_tb
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


module TIMER_tb();
reg             clk;
reg             rst;
wire    [3:0]   out;
wire    [2:0]   select;

initial begin
    clk = 1;
    rst = 1;
    #10;
    rst = 0;
end

always #5 clk = ~clk;

TIMER timer(
    .clk(clk),
    .rst(rst),
    .out(out),
    .select(select)
);
endmodule
