`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 17:52:28
// Design Name: 
// Module Name: Send
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


module Send(
    input                   [ 0 : 0]        clk, 
    input                   [ 0 : 0]        rst,

    output      reg         [ 0 : 0]        dout,

    input                   [ 0 : 0]        dout_vld,
    input                   [ 7 : 0]        dout_data
);

// Counter and parameters
localparam FullT        = 10416;
localparam TOTAL_BITS   = 9;
reg [13 : 0] div_cnt;           // 分频计数器，范围 0 ~ 867
reg [ 4 : 0] dout_cnt;          // 位计数器，范围 0 ~ 9

// Main FSM
localparam WAIT     = 0;
localparam SEND     = 1;
reg current_state, next_state;
always @(posedge clk) begin
    if (rst)
        current_state <= WAIT;
    else
        current_state <= next_state;
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        // TODO
        WAIT:   begin
            if (dout_vld == 1) begin
                next_state = SEND;
            end
        end
        SEND:   begin
            if (dout_cnt == TOTAL_BITS && div_cnt == FullT) begin
                next_state = WAIT;
            end
        end
    endcase

end

// Counter
always @(posedge clk) begin
    if (rst)
        div_cnt <= 13'H0;
    else if (current_state == SEND) begin
        // TODO
        if (div_cnt > FullT)
            div_cnt <= 13'H0;
        else
            div_cnt <= div_cnt + 13'H1;
    end
    else
        div_cnt <= 13'H0;
end

always @(posedge clk) begin
    if (rst)
        dout_cnt <= 4'H0;
    else if (current_state == SEND) begin
        // TODO
        if (dout_cnt > TOTAL_BITS)
            dout_cnt <= 10'H0;
        else begin
            if (div_cnt == FullT)
                dout_cnt <= dout_cnt + 10'H1;
            else
                dout_cnt <= dout_cnt;
        end
    end
    else
        dout_cnt <= 4'H0;
end

reg [7 : 0] temp_data;      // 用于保留待发送数据，这样就不怕 dout_data 的变化了
always @(posedge clk) begin
    if (rst)
        temp_data <= 8'H0;
    else if (current_state == WAIT && dout_vld)
        temp_data <= dout_data;
end

always @(posedge clk) begin
    if (rst)
        dout <= 1'B1;
    else begin
        // TODO
        if (next_state == WAIT) begin
            dout <= 1'B1;
        end
        else begin
            case (dout_cnt)
                0:  dout <= 1'B0;
                9:  dout <= 1'B1;
                default:    dout <= temp_data[dout_cnt-1];
            endcase
        end
    end
end
endmodule