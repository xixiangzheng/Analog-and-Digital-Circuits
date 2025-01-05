`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 18:15:03
// Design Name: 
// Module Name: lab3-3_seg
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


module Segment(
    input                       clk,
    input                       rst,
    input       [31:0]          output_data,

    output reg  [ 3:0]          seg_data,
    output reg  [ 2:0]          seg_an
);

reg [31:0]  counter;
reg [2:0]   seg_id;

always @(posedge clk) begin // Update counter
    if (rst) begin
        counter <= 0;
    end
    else if (counter >= 250000) begin
        counter <= 0;
    end
    else begin
        counter <= counter + 1;
    end
end

always @(posedge clk) begin // Update seg_id
    if (rst) begin
        seg_id <= 0;
    end
    else if (counter == 1) begin
        if (seg_id >= 8) begin
            seg_id <= 0;
        end
        else begin
            seg_id <= seg_id + 1;
        end
    end
    else begin
        seg_id <= seg_id;
    end
end

always @(*) begin   // Update seg_data according to seg_id. 
    seg_data = 0;
    seg_an = seg_id;    // <- Same for all cases

    case (seg_an)
        0: seg_data = output_data[3:0];
        1: seg_data = output_data[7:4];
        2: seg_data = output_data[11:8];
        3: seg_data = output_data[15:12];
        4: seg_data = output_data[19:16];
        5: seg_data = output_data[23:20];
        6: seg_data = output_data[27:24];
        7: seg_data = output_data[31:28];
        default: seg_data = 0;
    endcase
end
endmodule
