`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/31 10:01:19
// Design Name: 
// Module Name: lab
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

module TIMER (
    input           clk, 
    input           rst,
    output  [3:0]   out,
    output  [2:0]   select
);

reg [3:0] out_h;
reg [7:0] out_m;
reg [7:0] out_s;
reg [39:0] cnt;

reg [3:0] next_h;
reg [7:0] next_m;
reg [7:0] next_s;
reg [39:0] next_cnt;

wire [31:0] data;
reg [3:0] flag;

assign data = {12'b000000000000, out_h, out_m, out_s};

always @(posedge clk) begin
    if (rst) begin
        out_h <= 4'h9;
        out_m <= 8'h58;
        out_s <= 8'h30;
        cnt <= 1;
    end
    else begin
        out_h <= next_h;
        out_m <= next_m;
        out_s <= next_s;
        cnt <= next_cnt;
    end
end

always @(*) begin
    next_cnt = cnt;
    if (cnt >= 100000000) begin
        next_cnt = 1;
    end
    else begin
        next_cnt = cnt + 1;
    end
end

always @(*) begin
    next_s = out_s;
    if(cnt == 1) begin
        case(out_s)
            8'h09:   next_s = 8'h10;
            8'h19:   next_s = 8'h20;
            8'h29:   next_s = 8'h30;
            8'h39:   next_s = 8'h40;
            8'h49:   next_s = 8'h50;
            8'h59:   next_s = 8'h00;
            default: next_s = out_s + 1;
        endcase
    end
end

always @(*) begin
    next_m = out_m;
    if(cnt == 1 && out_s == 8'h59) begin
        case(out_m)
            8'h09:   next_m = 8'h10;
            8'h19:   next_m = 8'h20;
            8'h29:   next_m = 8'h30;
            8'h39:   next_m = 8'h40;
            8'h49:   next_m = 8'h50;
            8'h59:   next_m = 8'h00;
            default: next_m = out_m + 1;
        endcase
    end
end

always @(*) begin
    next_h = out_h;
    if(cnt == 1 && out_s == 8'h59 && out_m == 8'h59) begin
        next_h = out_h + 1;
    end
end

Segment segment(
    .clk(clk),
    .rst(rst),
    .output_data(data),
    .output_valid(8'b11111111),
    .seg_data(out),
    .seg_an(select)
);

endmodule
