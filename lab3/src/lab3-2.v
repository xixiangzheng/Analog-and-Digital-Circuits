`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 14:57:38
// Design Name: 
// Module Name: lab3
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
    input clk,
    input btn,
    output reg[7:0] led
);

reg [31:0] cnt;

initial begin
    led = 8'b1111_1111;
    cnt = 0;
end

always @(posedge clk) begin
    if (btn) begin
        led <= 8'b0000_0000;
        cnt <= 0;
    end
    else if (cnt >= 50000000) begin
        cnt <= 0;
        led <= ~led;
    end
    else begin
        cnt <= cnt + 1;
    end
end
    
endmodule