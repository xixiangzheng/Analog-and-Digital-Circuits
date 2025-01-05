`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/08 09:55:52
// Design Name: 
// Module Name: top
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
    input                                   clk,
    input                                   rst,
    input                                   enable,

    input                   [ 4 : 0]        in,
    input                   [ 1 : 0]        ctrl,

    output                  [ 3 : 0]        seg_data,
    output                  [ 2 : 0]        seg_an
);

reg     [3:0]   decoder1_temp;
reg     [11:0]  decoder2_temp;
wire    [4:0]   alu_temp;
wire            sel_en;
wire            src0_en;
wire            src1_en;
wire            out_en;
reg     [3:0]   sel_reg;
reg     [4:0]   src0_reg;
reg     [4:0]   src1_reg;
reg     [4:0]   out_reg;

assign sel_en = decoder1_temp[0];
assign src0_en = decoder1_temp[1];
assign src1_en = decoder1_temp[2];
assign out_en = decoder1_temp[3];

always @(*) begin
    if (rst) begin
        decoder1_temp = 4'b0000;
    end
    else begin
        if (enable) begin
            case (ctrl)
                2'b00:      decoder1_temp = 4'b0001;
                2'b01:      decoder1_temp = 4'b0010;
                2'b10:      decoder1_temp = 4'b0100;
                2'b11:      decoder1_temp = 4'b1000;
            endcase
        end
        else begin
            decoder1_temp = 4'b0000;
        end
    end   
end

always @(*) begin
    if (rst) begin
        decoder2_temp = 12'b0000_0000_0000;
    end
    else begin
        case (sel_reg)
            4'b0001:      decoder2_temp = 12'b0000_0000_0001;
            4'b0010:      decoder2_temp = 12'b0000_0000_0010;
            4'b0011:      decoder2_temp = 12'b0000_0000_0100;
            4'b0100:      decoder2_temp = 12'b0000_0000_1000;
            4'b0101:      decoder2_temp = 12'b0000_0001_0000;
            4'b0110:      decoder2_temp = 12'b0000_0010_0000;
            4'b0111:      decoder2_temp = 12'b0000_0100_0000;
            4'b1000:      decoder2_temp = 12'b0000_1000_0000;
            4'b1001:      decoder2_temp = 12'b0001_0000_0000;
            4'b1010:      decoder2_temp = 12'b0010_0000_0000;
            4'b1011:      decoder2_temp = 12'b0100_0000_0000;
            4'b1100:      decoder2_temp = 12'b1000_0000_0000;
            default:      decoder2_temp = 12'b0000_0000_0000;
        endcase
    end
end

ALU alu(
    .src0(src0_reg),
    .src1(src1_reg),
    .sel(decoder2_temp),
    .res(alu_temp)
);

Segment segment(
    .clk(clk),
    .rst(rst),
    .output_data({27'b0, out_reg}),
    .output_valid(8'b11111111),
    .seg_data(seg_data),
    .seg_an(seg_an)
);

always @(*) begin
    if(rst) begin
        sel_reg = 0;
    end
    else begin
        if(sel_en) begin
            sel_reg = in[3:0];
        end
        else begin
            sel_reg = sel_reg;
        end
    end 
end

always @(*) begin
    if(rst) begin
        src0_reg = 0;
    end
    else begin
        if(src0_en) begin
            src0_reg = in[4:0];
        end
        else begin
            src0_reg = src0_reg;
        end
    end 
end

always @(*) begin
    if(rst) begin
        src1_reg = 0;
    end
    else begin
        if(src1_en) begin
            src1_reg = in[4:0];
        end
        else begin
            src1_reg = src1_reg;
        end
    end 
end

always @(*) begin
    if(rst) begin
        out_reg = 0;
    end
    else begin
        if(out_en) begin
            out_reg = alu_temp;
        end
        else begin
            out_reg = out_reg;
        end
    end 
end

endmodule
