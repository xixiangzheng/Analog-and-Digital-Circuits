`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 14:16:02
// Design Name: 
// Module Name: lab2_4
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

module lab2_4_tb();
reg clk,a,b;
reg [7:0] c;

initial begin
    c = 8'b0000_0000;
    clk = 1'b1;
    a = 1'b0;
    b = 1'b0;
    #10;

    c = 8'b0000_0001;
    #10;

    b = ~b;
    #5;
    
    b = ~b;
    #5;

    c = 8'b0000_0010;
    #10;

    b = ~b;
    #10;

    c = 8'b0000_0011;
    #20;

    b = ~b;
    #5;

    b=~b;
    #5;

    c = 8'b0000_0100;
    #10;

    b = ~b;
    #10;

    a = ~a;
end

always #5 clk = ~clk;
endmodule