`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/09 00:16:31
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


module Top (
    input                                       clk,
    input                                       rst,
    input                                       start,
    input                   [31 : 0]            a,
    input                   [31 : 0]            b,
    input                                       mul_signed,
    output      reg         [62 : 0]            res,
    output                                      finish
);

wire [31:0] a_sub, a_mul, b_sub, b_mul;
wire [61:0] res_sub, res_mul, res_unsigned;
wire        res_mid;
assign a_mul = a[31] ? a_sub : a;
assign b_mul = b[31] ? b_sub : b;

always @(*) begin
    if (rst) begin
        res = 0;
    end
    else begin
        if (finish) begin
            if (mul_signed) begin
                res = (a[31] == b[31]) ? {{1'b0}, {res_mul}} : {{1'b1}, {res_sub}};
            end
            else begin
                res = res_unsigned;
            end
            
        end
        else begin
            res = res;
        end
    end
end

Adder adder0(
    .a(0),
    .b(~a),
    .ci(1),
    .s(a_sub),
    .co()
);

Adder adder1(
    .a(0),
    .b(~b),
    .ci(1),
    .s(b_sub),
    .co()
);

Adder adder2(
    .a(0),
    .b(~(res_mul[31:0])),
    .ci(1),
    .s(res_sub[31:0]),
    .co(res_mid)
);

Adder adder3(
    .a(0),
    .b(~(res_mul[61:32])),
    .ci(res_mid),
    .s(res_sub[61:32]),
    .co()
);

MUL mul(
    .clk        (clk),
    .rst        (rst),
    .start      (start),
    .a          (a_mul),
    .b          (b_mul),
    .res        (res_mul),
    .finish     (finish)
);

MUL mul_unsigned(
    .clk        (clk),
    .rst        (rst),
    .start      (start),
    .a          (a),
    .b          (b),
    .res        (res_unsigned),
    .finish     (finish)
);
endmodule
