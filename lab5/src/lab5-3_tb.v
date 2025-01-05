`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/31 13:45:52
// Design Name: 
// Module Name: la
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
reg           clk;            // 时钟信号
reg           rst;            // 复位信号，使状态机回到初始态
reg   [31:0]  src;            // 输入数据
reg           src_valid;      // 表明输入结果是否有效
wire          ready;          // 表明是否正在检测
wire          res;            // 输出结果
wire          res_valid;      // 表明输出结果是否有效

initial begin
    clk = 0;
    rst = 1;

    #10;
    rst = 0;
    src_valid = 1;
    src = 7;
    #10;
    src_valid = 0;

    #400
    src_valid = 1;
    src = 14;
    #10;
    src_valid = 0;
    
    #400
    src_valid = 1;
    src = 15;
    #10;
    src_valid = 0;

    #400
    rst = 1;

    #10;
    rst = 0;
    src_valid = 1;
    src = 896;
    #10;
    src_valid = 0;

    #200
    src_valid = 1;
    src = 1;
    #10;
    src_valid = 0;

    #400
    src_valid = 1;
    src = 165;
    #10;
    src_valid = 0;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .rst(rst),
    .src(src),
    .src_valid(src_valid),
    .ready(ready),
    .res(res),
    .res_valid(res_valid)
);
endmodule
