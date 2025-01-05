`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/09 00:33:39
// Design Name: 
// Module Name: Top_tb
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
reg  [31:0]         a, b;
reg                 rst, clk, start, mul_signed;
wire [62:0]         res;
wire                finish;
integer             seed;

initial begin
    clk = 0;
    seed = 2024; // 种子值
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    rst = 1;
    mul_signed = 1;
    start = 0;
    #20;
    rst = 0;
    #20;
    repeat (10) begin
        a = $random(seed);          // $random 返回的是 32 位随机数，如果你需要得到少于 32 位的随机数，可以通过 % 运算得到
        b = $random(seed + 1);      // 你可以通过设置种子值改变随机数的序列
        start = 1;
        #20 start = 0;
        #400;
    end
end

always #1000 mul_signed = ~mul_signed; 

Top top(
    .clk        (clk),
    .rst        (rst),
    .start      (start),
    .a          (a),
    .b          (b),
    .mul_signed (mul_signed),
    .res        (res),
    .finish     (finish)
);
endmodule