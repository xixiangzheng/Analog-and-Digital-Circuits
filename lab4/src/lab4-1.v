`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/24 15:54:35
// Design Name: 
// Module Name: lab4-1
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


module encode(
    input [3:0]         I,
    output reg [1:0]    Y,
    output reg          en
);
// Write your codes here 
always @(*) begin
    case (I)
        4'b1000: Y = 2'b11;
        4'b0100: Y = 2'b10;
        4'b0010: Y = 2'b01;
        4'b0001: Y = 2'b00;
        default: Y = 2'b00;
    endcase
end

always @(*) begin
    if (I == 4'b0000) begin
        en = 2'b0;
    end
    else begin
        en = 2'b1;
    end
end
// End of your codes
endmodule
