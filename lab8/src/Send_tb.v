`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 20:08:54
// Design Name: 
// Module Name: Send_tb
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


module Send_tb();
reg clk;
reg btn;
reg [7:0] sw;
wire [3:0] seg_data;
wire [2:0] seg_an;
wire uart_dout;

initial begin
    clk = 0;
    sw = 8'b10000000;
    btn = 1;
    #10 btn = 0;
    sw = 8'h30;
    btn = 1;
    #10 btn = 0;

    #50000 sw = 8'h36;
    #50000 btn = 1;
    #10 btn = 0;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .btn(btn),
    .sw(sw),
    .seg_data(seg_data),
    .seg_an(seg_an),
    .uart_dout(uart_dout)
);
endmodule