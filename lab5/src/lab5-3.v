`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/31 13:45:18
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


module Top(
    input           clk,            // 时钟信号
    input           rst,            // 复位信号，使状态机回到初始态
    input   [31:0]  src,            // 输入数据
    input           src_valid,      // 表明输入结果是否有效
    output  reg     ready,          // 表明是否正在检测
    output  reg     res,            // 输出结果
    output  reg     res_valid       // 表明输出结果是否有效
);

// 状态变量
reg [6:0] current_state;
reg [6:0] next_state;
reg [3:0] current_mod;
reg [3:0] next_mod;
reg [31:0] tmp;

// Part 1: 使用同步时序进行状态更新，即更新 current_state 的内容。
always @(posedge clk) begin
    if (rst) begin
        current_state <= 33;
        current_mod <= 0;
    end 
    else begin
        current_state <= next_state;
        current_mod <= next_mod;
    end
end

// Part 2: 使用组合逻辑判断状态跳转逻辑，即根据 current_state 与其他信号确定 next_state。
always @(*) begin
    next_state = current_state;
    case (current_state)
        33: begin
            if (src_valid == 1) begin
                tmp = src;
                next_state = 31;
            end
        end
        32: begin
            if (src_valid == 1) begin
                tmp = src;
                next_state = 31;
            end
        end
        0:  begin
            next_state = 32;
        end
        default: begin
            next_state = next_state - 1;
        end
    endcase
end

always @(*) begin
    next_mod = current_mod;
    if (current_state <= 31 && current_state >= 0) begin
        case (current_mod)
            0: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 1;
                end
                else begin
                    next_mod = 0;
                end  
            end
            1: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 3;
                end
                else begin
                    next_mod = 2;
                end  
            end
            2: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 5;
                end
                else begin
                    next_mod = 4;
                end  
            end
            3: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 0;
                end
                else begin
                    next_mod = 6;
                end  
            end
            4: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 2;
                end
                else begin
                    next_mod = 1;
                end  
            end
            5: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 4;
                end
                else begin
                    next_mod = 3;
                end  
            end
            6: begin
                if (tmp[current_state] == 1) begin
                    next_mod = 6;
                end
                else begin
                    next_mod = 5;
                end  
            end
        endcase
    end
end

// Part 3: 使用组合逻辑描述状态机的输出。
always @(*) begin
    case (current_state)
        33: begin
            ready = 1;
            res_valid = 0;
        end
        32: begin
            ready = 1;
            res_valid = 1;
        end
        0:  begin
            ready = 0;
            res_valid = 0;
        end
        default: begin
            ready = 0;
            res_valid = 0;
        end
    endcase
end

always @(*) begin
    res = 0;
    if (current_state == 32 && current_mod == 0) begin
        res = 1;
    end
end

endmodule