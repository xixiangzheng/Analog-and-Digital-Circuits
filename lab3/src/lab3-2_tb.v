`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 15:13:59
// Design Name: 
// Module Name: lab3-2_tb
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


module Top_tb ();
reg clk;
reg btn;
wire [7:0] led;

initial begin
    clk = 2'b0;
    btn = 2'b0;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .btn(btn),
    .led(led)
);
endmodule