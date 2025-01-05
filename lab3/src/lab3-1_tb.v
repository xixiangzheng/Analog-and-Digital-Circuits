`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 11:43:09
// Design Name: 
// Module Name: lab3_1_tb
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
reg [7:0]   sw;
wire [7:0]  led;

initial begin
    sw = 8'b0000_0000;
    #10;
    sw = 8'b0000_0001;
    #10;
    sw = 8'b0000_0011;
    #10;
    sw = 8'b0000_1011;
    #10;
    sw = 8'b1000_0001;
    #10;
    sw = 8'b1000_0000;
end

Top top(
    .sw(sw),
    .led(led)
);
endmodule
