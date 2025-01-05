`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 15:15:39
// Design Name: 
// Module Name: lab
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


module multiple5_tb();
reg [7:0] num;
wire ismultiple5;

initial begin
    num = 8'b00000000;
    #10 num = 8'b01000110;
    #10 num = 8'b10001011;
    #10 num = 8'b10110110;
    #10 num = 8'b11001101;
end

multiple5 multiple5(
    .num(num),
    .ismultiple5(ismultiple5)
);
endmodule
