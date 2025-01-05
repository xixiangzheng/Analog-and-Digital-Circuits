`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 22:32:42
// Design Name: 
// Module Name: Receive_tb
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


module Receive_tb();
reg clk;
reg rst;
wire [3:0] seg_data;
wire [2:0] seg_an;
reg uart_din;

initial begin
    clk = 0;
    rst = 1;
    uart_din = 1;
    #10 rst = 0;
    #1000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .rst(rst),
    .seg_data(seg_data),
    .seg_an(seg_an),
    .uart_din(uart_din)
);
endmodule