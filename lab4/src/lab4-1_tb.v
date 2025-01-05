`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/24 15:55:07
// Design Name: 
// Module Name: lab4-1_tb
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


module encode_tb();
reg [3:0]   I;
wire [1:0]  Y;
wire        en;

initial begin
    I = 4'b1000;
    #10 I = 4'b0100;
    #10 I = 4'b0110;
    #10 I = 4'b0010;
    #10 I = 4'b0000;
    #10 I = 4'b0001;
end

encode encode(
    .I(I),
    .Y(Y),
    .en(en)
);
endmodule
