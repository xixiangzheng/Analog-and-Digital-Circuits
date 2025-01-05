`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 11:50:42
// Design Name: 
// Module Name: Counter
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


module Counter #(
    parameter               MAX_VALUE = 8'd13,
    parameter               MIN_VALUE = 8'd10
)(
    input                   clk,
    input                   rst,
    input                   enable,
    output                  out
);

reg [7:0] counter;
always @(posedge clk) begin
    if (rst) 
        counter <= 0;
    else begin
        if (enable) begin
            if (counter >= MAX_VALUE)
                counter <= MIN_VALUE;
            else if(counter >= MIN_VALUE)
                counter <= counter + 1;
            else counter <= MIN_VALUE;
        end
        else
            counter <= 0;
    end
end

assign out = (counter == MAX_VALUE);
endmodule