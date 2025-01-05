`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 13:03:23
// Design Name: 
// Module Name: lab4
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


module adder2bit_tb();
reg [1:0] a;
reg [1:0] b;
wire [1:0] out;
wire Cout;

initial begin
    a = 2'b00;
    b = 2'b00;
    #10;
    a = 2'b01;
    b = 2'b10;
    #10;
    a = 2'b01;
    b = 2'b11;
    #10;
    a = 2'b10;
    b = 2'b11;
    #10;
    a = 2'b11;
    b = 2'b11;
end

adder2bit adder2bit(
    .a(a),
    .b(b),
    .out(out),
    .Cout(Cout)
);
endmodule
