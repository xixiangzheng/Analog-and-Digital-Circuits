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
reg [13 : 0] div_cnt;       // 分频计数器，范围 0 ~ 867
reg [ 3 : 0] din_cnt;       // 位计数器，范围 0 ~ 8

// Main FSM
localparam WAIT     = 0;
localparam START    = 1;
localparam RECEIVE  = 2;
reg [1:0] current_state, next_state;
reg next_div_cnt_flag;
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
            if (din == 0) begin
                next_state = START;
            end
        end
        START:   begin
            if (div_cnt == HalfT) begin
                next_state = RECEIVE;
                next_div_cnt_flag = 1;
            end
        end
        RECEIVE: begin
            if (din_cnt == TOTAL_BITS && div_cnt == FullT) begin
                next_state = WAIT;
                next_div_cnt_flag = 1;
            end
            else if (div_cnt == FullT) begin
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
        else if (div_cnt == FullT) 
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
    if (div_cnt == FullT && din_cnt < TOTAL_BITS)
        accept_din = 1'B1;
end

always @(*) begin
    din_vld = 1'B0;
    // TODO
    if (div_cnt == FullT && din_cnt == TOTAL_BITS)
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
