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


module ALU_tb();
reg     [31:0]  src0;
reg     [31:0]  src1;
reg     [11:0]  sel;
wire    [31:0]  res;

initial begin
    src0=32'h90abc0ee; src1=32'h90678024; sel=12'h001;
    repeat(12) begin
        #10 sel = sel << 1;
    end
    src0=32'hffffffff; src1=32'h1; sel=12'h001;
    repeat(4) begin
        #10 sel = sel << 1;
    end
    src0=32'h1; src1=32'h0; sel=12'h001;
    repeat(4) begin
        #10 sel = sel << 1;
    end
    src0=32'hffffffff; src1=32'hfffffffe; sel=12'h001;
    repeat(4) begin
        #10 sel = sel << 1;
    end
    src0=32'h0; src1=32'hffffffff; sel=12'h001;
    repeat(4) begin
        #10 sel = sel << 1;
    end
end

ALU alu(
    .src0(src0),
    .src1(src1),
    .sel(sel),
    .res(res)
);

endmodule