`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/25 20:50:27
// Design Name: 
// Module Name: lab5
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


module RegFile (
    input                     clk,          // 时钟信号
    input         [4:0]       ra1,          // 读端口 1 地址
    input         [4:0]       ra2,          // 读端口 2 地址
    input         [4:0]       wa,           // 写端口地址
    input                     we,           // 写使能信号
    input         [31:0]      din,          // 写数据
    output  reg   [31:0]      dout1,        // 读端口1数据输出
    output  reg   [31:0]      dout2         // 读端口2数据输出
);

reg [31:0] reg_file [31:0]; // 32 个 32 位寄存器，规模为 32×32 bits

// 写端口
always @(posedge clk) begin
    reg_file[0] <= 0;
    if (we && wa != 0) begin
        reg_file[wa] <= din;
    end
    else begin
        reg_file[wa] <= reg_file[wa];
    end
end

// 读端口
always @(*) begin
    if (ra1 == 0) begin
        dout1 = 0;
    end
    else if (we && ra1 == wa) begin
        dout1 = din;
    end
    else begin
        dout1 = reg_file[ra1];
    end
end

always @(*) begin
    if (ra2 == 0) begin
        dout2 = 0;
    end
    else if (we && ra2 == wa) begin
        dout2 = din;
    end
    else begin
        dout2 = reg_file[ra2];
    end
end
endmodule
