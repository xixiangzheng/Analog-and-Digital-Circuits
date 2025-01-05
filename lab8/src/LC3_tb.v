`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/25 10:16:54
// Design Name: 
// Module Name: LC3_tb
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


module LC3_tb();
reg             clk;
reg             btn;
reg     [7:0]   sw;
reg             uart_din;
wire    [7:0]   led;      
wire    [3:0]   seg_data;
wire    [2:0]   seg_an;
wire            uart_dout;

initial begin
    clk = 0;
    uart_din = 1;
    sw = 8'b10000000;
    btn = 0;
    #10 sw = 8'b00000000;

    // r0002
    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    repeat (3) begin
        #200000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
        #104000 uart_din = 1;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
    end
    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    // j000E
    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    repeat (3) begin
        #200000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
        #104000 uart_din = 1;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
    end
    #200000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    // wF025
    #200000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    
    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    
    #200000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    // j0000
    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    repeat (4) begin
        #200000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
        #104000 uart_din = 1;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
    end

    #200000;
    repeat (5) begin
        #110 btn = 1;
        #10 btn = 0;
    end

    // s0020
    #200000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    repeat (2) begin
        #200000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
        #104000 uart_din = 1;
        #104000 uart_din = 0;
        #104000 uart_din = 0;
        #104000 uart_din = 1;
    end
    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;

    #200000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
    #104000 uart_din = 1;
    #104000 uart_din = 0;
    #104000 uart_din = 0;
    #104000 uart_din = 1;
end

always #5 clk = ~clk;

Top top(
    .clk(clk),
    .btn(btn),
    .sw(sw),
    .uart_din(uart_din),
    .led(led),
    .seg_data(seg_data),
    .seg_an(seg_an),
    .uart_dout(uart_dout)
);
endmodule
