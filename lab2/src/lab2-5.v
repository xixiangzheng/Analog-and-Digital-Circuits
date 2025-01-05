`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 14:21:56
// Design Name: 
// Module Name: lab2_5
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


module FindMode (
    input                               clk,
    input                               rst,
    input                               next,
    input       [7:0]                   number,
    output reg  [7:0]                   out
); 
// Your codes here.

reg [7:0] cnt[255:0];
reg [7:0] tmp;
integer i;

always @(posedge clk) begin
    if (rst) begin
        tmp <= 0;
        for (i = 0; i <= 255 ; i = i + 1)
            cnt[i] <= 0;
    end
    else if (next) begin
        cnt[number] <= cnt[number] + 1;
        if (cnt[number] >= cnt[tmp])
            tmp <= number;
        else
            tmp <= tmp;
    end
end

always @(*) begin
    out = tmp;
end

endmodule
