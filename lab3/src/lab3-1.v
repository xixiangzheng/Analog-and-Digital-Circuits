`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 11:24:39
// Design Name: 
// Module Name: lab3_1
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


module Top (
    input   [7:0]       sw,
    output  [7:0]       led
);
// Write your codes here.

reg [7:0] temp;
always @(*) begin
    temp[7] = sw[4];
    temp[6] = sw[5];
    temp[5] = sw[6];
    temp[4] = sw[7];
    temp[3] = sw[0];
    temp[2] = sw[1];
    temp[1] = sw[2];
    temp[0] = sw[3];
end

assign led = temp;
endmodule