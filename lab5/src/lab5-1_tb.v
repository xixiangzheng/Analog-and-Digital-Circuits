`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 20:50:45
// Design Name: 
// Module Name: lab5-1_tb
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


module RegFile_tb ();
reg              clk;
reg     [ 4 : 0] ra1;
reg     [ 4 : 0] ra2;
reg     [ 4 : 0] wa;
reg              we;
reg     [31 : 0] din;
wire    [31 : 0] dout1;
wire    [31 : 0] dout2;

initial begin
    clk = 0;
    ra1 = 5'H0; ra2 = 5'H0; wa = 5'H0; we = 1'H0; din = 32'H0;

    #12;
    ra1 = 5'H0; ra2 = 5'H0; wa = 5'H3; we = 1'H1; din = 32'H12345678;

    #5;
    ra1 = 5'H0; ra2 = 5'H0; wa = 5'H0; we = 1'H0; din = 32'H0;

    #5;
    ra1 = 5'H3; ra2 = 5'H2; wa = 5'H2; we = 1'H1; din = 32'H87654321;

    #5;
    ra1 = 5'H0; ra2 = 5'H0; wa = 5'H0; we = 1'H0; din = 32'H0;

    #5;
    ra1 = 5'H3; ra2 = 5'H0; wa = 5'H0; we = 1'H1; din = 32'H87654321;
end

always #5 clk = ~clk;

RegFile regfile(
    .clk(clk),
    .ra1(ra1),
    .ra2(ra2),
    .wa(wa),
    .we(we),
    .din(din),
    .dout1(dout1),
    .dout2(dout2)
);
endmodule