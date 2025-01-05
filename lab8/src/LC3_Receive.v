`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 21:35:38
// Design Name: 
// Module Name: Receive
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


module Receive(
    input                   [ 0 : 0]        clk,
    input                   [ 0 : 0]        rst,

    input                   [ 0 : 0]        din,

    output      reg         [ 0 : 0]        din_vld,
    output      reg         [ 7 : 0]        din_data
);

// Counter and parameters
localparam FullT        = 10416;
localparam HalfT        = 5208;
localparam TOTAL_BITS   = 8;
reg [13 : 0] div_cnt;       // 分频计数器，范围 0 ~ 10416
reg [ 3 : 0] din_cnt;       // 位计数器，范围 0 ~ 8

// Main FSM
localparam WAIT     = 0;
localparam START    = 1;	// 接收起始状态，该状态只持续 HalfT
localparam RECEIVE  = 2;	// 接收数据状态，每位数据持续 FullT
reg [1:0] current_state, next_state;
reg next_div_cnt_flag;		// div_cnt 归零标记
always @(posedge clk) begin
    if (rst)
        current_state <= WAIT;
    else
        current_state <= next_state;
end

always @(*) begin
    next_state = current_state;
    next_div_cnt_flag = 0;
    case (current_state)
        // TODO
        WAIT:    begin
            if (din == 0) begin			// 起始位为 0
                next_state = START;
            end
        end
        START:   begin
            if (div_cnt == HalfT) begin		// START 态持续 HalfT，结束后进入 RECEIVE 态，并将 div_cnt 归零
                next_state = RECEIVE;
                next_div_cnt_flag = 1;
            end
        end
        RECEIVE: begin
            if (din_cnt == TOTAL_BITS && div_cnt == FullT) begin	// 所有数据位接收结束后回至 WAIT 态
                next_state = WAIT;
                next_div_cnt_flag = 1;
            end
            else if (div_cnt == FullT) begin	// 每位接收持续 FullT，每位结束后需将 div_cnt 归零
                next_div_cnt_flag = 1;
            end
        end
    endcase
end

// Counter
always @(posedge clk) begin
    if (rst)
        div_cnt <= 0;
    else if (current_state == START) begin
        // TODO
        if (next_div_cnt_flag)
            div_cnt <= 0;
        else
            div_cnt <= div_cnt + 1;
    end
    else if (current_state == RECEIVE) begin
        // TODO
        if (next_div_cnt_flag)
            div_cnt <= 0;
        else
            div_cnt <= div_cnt + 1;
    end
    else 
        div_cnt <= 0;
end

always @(posedge clk) begin
    if (rst)
        din_cnt <= 0;
    else if (current_state == RECEIVE) begin
        // TODO
        if (din_cnt == TOTAL_BITS && div_cnt == FullT) begin
            din_cnt <= 0;
        end
        else if (div_cnt == FullT) 		// 每位接收持续 FullT，每位结束后 din_cnt 增加 1
            din_cnt <= din_cnt + 1;
        else
            din_cnt <= din_cnt;
    end
    else
        din_cnt <= 0;
end


// Output signals
reg [ 0 : 0] accept_din;    // 位采样信号
always @(*) begin
    accept_din = 1'B0;
    // TODO
    if (div_cnt == FullT && din_cnt < TOTAL_BITS)		// 该位的中间时刻为最佳采样时刻
        accept_din = 1'B1;
end

always @(*) begin
    din_vld = 1'B0;
    // TODO
    if (div_cnt == FullT && din_cnt == TOTAL_BITS)		// 完成本轮接收
        din_vld = 1'B1;
end

always @(posedge clk) begin
    if (rst)
        din_data <= 8'B0;
    else if (current_state == WAIT)
        din_data <= 8'B0;
    else if (current_state == START)
        din_data <= 8'B0;
    else if (accept_din)
        din_data <= din_data | (din << din_cnt);
    else
        din_data <= din_data;
end
endmodule
