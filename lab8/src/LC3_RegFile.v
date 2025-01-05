`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 15:57:51
// Design Name: 
// Module Name: RegFile
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
    input                     rst,          // 系统复位信号
    input         [2:0]       ra0,          // 读端口 0 地址
    input         [2:0]       ra1,          // 读端口 1 地址
    input         [2:0]       ra2,          // 读端口 2 地址
    input         [2:0]       wa,           // 写端口地址
    input                     we,           // 写使能信号
    input         [15:0]      din,          // 写数据
    output  reg   [15:0]      dout0,        // 读端口 0 数据输出
    output  reg   [15:0]      dout1,        // 读端口 1 数据输出
    output  reg   [15:0]      dout2         // 读端口 2 数据输出
);

reg [15:0] reg_file [7:0];                  // 8 个 16 位寄存器

// 写端口
always @(posedge clk) begin
    if (rst) begin
        reg_file[0] <= 0;
        reg_file[1] <= 0;
        reg_file[2] <= 0;
        reg_file[3] <= 0;
        reg_file[4] <= 0;
        reg_file[5] <= 0;
        reg_file[6] <= 0;
        reg_file[7] <= 0;
    end
    else begin
        if (we) begin
            reg_file[wa] <= din;
        end
        else begin
            reg_file[wa] <= reg_file[wa];
        end
    end
end

// 读端口
always @(*) begin
    dout0 = reg_file[ra0];
    dout1 = reg_file[ra1];
    dout2 = reg_file[ra2];
end

endmodule
