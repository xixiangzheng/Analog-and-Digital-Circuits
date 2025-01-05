`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/07 22:59:54
// Design Name: 
// Module Name: lab6-1_tb
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
reg                                   clk;
reg                                   rst;
reg                                   enable;
reg                   [ 4 : 0]        in;
reg                   [ 1 : 0]        ctrl;
wire                  [ 3 : 0]        seg_data;
wire                  [ 2 : 0]        seg_an;

initial begin
    clk=0;
    rst=1;
    #10 rst=0;

    in=5'b10110; ctrl=2'b01; enable=1'b1;
    #10;
    enable=1'b0;
    #30;
    in=5'b01101; ctrl=2'b10; enable=1'b1;
    #10;
    enable=1'b0;
    #30;
    in=5'b00010; ctrl=2'b00; enable=1'b1;
    #10;
    enable=1'b0;
    #30;
    ctrl=2'b11; enable=1'b1;
    #10;
    in=5'b01101; ctrl=2'b01; enable=1'b0;
    #30 ctrl=2'b11; enable=1'b1;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .in(in),
    .ctrl(ctrl),
    .seg_data(seg_data),
    .seg_an(seg_an)
);
endmodule