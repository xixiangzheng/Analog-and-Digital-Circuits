`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/09 00:12:35
// Design Name: 
// Module Name: mul
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


module MUL (
    input                                       clk,
    input                                       rst,
    input                                       start,
    input                   [31 : 0]            a,
    input                   [31 : 0]            b,
    output      reg         [61 : 0]            res,
    output      reg                             finish
);

reg [   1 : 0]     current_state, next_state;
reg [  31 : 0]     current_bit, next_bit; 
reg [  31 : 0]     current_multiplicand, next_multiplicand;       // 被乘数寄存器
reg [  31 : 0]     current_product_low, next_product_low;         // 乘积寄存器低位
reg [  32 : 0]     current_product_high, next_product_high;       // 乘积寄存器高位
wire[  32 : 0]     adder_temp;

localparam IDLE = 2'b00;            // 空闲状态。这个周期寄存器保持原值不变。当 start 为 1 时跳转到 INIT。
localparam INIT = 2'b01;            // 初始化。下个周期跳转到 CALC
localparam CALC = 2'b10;            // 计算中。计算完成时跳转到 DONE
localparam DONE = 2'b11;            // 计算完成。下个周期跳转到 IDLE

always @(posedge clk) begin
    if(rst) begin
        current_state <= IDLE;
        current_bit <= 0;
        current_multiplicand <= 0;
        current_product_low <= 0;
        current_product_high <= 0;
    end 
    else begin
        current_state <= next_state;
        current_bit <= next_bit;
        current_multiplicand <= next_multiplicand;
        current_product_low <= next_product_low;
        current_product_high <= next_product_high;
    end
end

always @(*) begin
    next_state = current_state;
    next_bit = current_bit;
    next_multiplicand = current_multiplicand;
    next_product_low = current_product_low;
    next_product_high = current_product_high;
    case(current_state)
        IDLE: begin
            if (start) begin
                next_state = INIT;
                next_bit = 0;
                next_multiplicand = a;
                next_product_low = b;
                next_product_high = 0;
            end
        end
        INIT: begin
            next_state = CALC;
            next_bit = current_bit + 1;
            next_product_low = {current_product_high[0], current_product_low[31:1]};
            if(current_product_low[0] == 1) begin
                next_product_high = adder_temp;
            end
            else begin
                next_product_high = current_product_high[32:1];
            end
        end
        CALC: begin
            if (current_bit == 32) begin
                next_state = DONE;
                next_bit = 0;
            end
            else begin
                next_bit = current_bit + 1;
                next_product_low = {current_product_high[0], current_product_low[31:1]};
                if(current_product_low[0] == 1) begin
                    next_product_high = adder_temp;
                end
                else begin
                    next_product_high = current_product_high[32:1];
                end
            end
        end
        DONE: begin
            next_state = IDLE;
        end
    endcase
end

always @(*)begin
    if (rst) begin
        finish = 0;
        res = 0;
    end
    else begin
        finish = (current_state == DONE) ? 1 : 0;
        res = finish ? {current_product_high[32:0], current_product_low[31:1]} : res;
    end
end

Adder adder_mul(
    .a(current_multiplicand),
    .b(current_product_high[32:1]),
    .ci(0),
    .s(adder_temp[31:0]),
    .co(adder_temp[32])
);
endmodule

