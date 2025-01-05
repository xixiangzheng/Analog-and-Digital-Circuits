`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 16:35:16
// Design Name: 
// Module Name: Top
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
    input                       clk,            // 时钟
    input                       btn,            // 按钮
    input       [ 7:0]          sw,             // 开关
    input                       uart_din,       /* 串口输入 */
    output      [ 7:0]          led,            // 灯
    output      [ 3:0]          seg_data,       // 数码管
    output      [ 2:0]          seg_an,
    output                      uart_dout       /* 串口输出 */
);

parameter IDLE      = 4'b0000;
parameter S1        = 4'b0001;
parameter S2        = 4'b0010;
parameter S3        = 4'b0011;
parameter S4        = 4'b0100;
parameter DONE      = 4'b0101;

wire [ 7:0] din_data;           /* 串口接收数据帧 */
wire        din_vld;            /* 串口接收数据帧有效信号*/

wire [15:0] output_uart;        /* 数码管低四位 */
wire [15:0] output_data;        // 数码管高四位

wire        posedge_btn;  
wire        rst;

reg         vld;
reg  [ 1:0] mode;
reg  [ 7:0] mode_temp;
reg  [15:0] addr;
reg  [ 3:0] transform; 

reg  [ 3:0] current_state;
reg  [ 3:0] next_state;

reg sig_r1, sig_r2;
always @(posedge clk) begin
    if (rst) begin
        sig_r1 <= 0;
        sig_r2 <= 0;
    end
    else begin
        sig_r1 <= btn;
        sig_r2 <= sig_r1;
    end
end
assign posedge_btn = (sig_r1 && ~sig_r2) ? 1 : 0;       // btn 取上升沿
assign led = {8{btn}};
assign rst = sw[7];

Controller controller(
    .clk            (clk),
    .rst            (rst),
    .btn            (posedge_btn),
    .sw             (sw[3:0]),
    .vld            (vld),
    .mode           (mode),
    .addr           (addr),                    
    .echo           (output_data), 
    .res            (output_uart)           
);

Segment segment(
    .clk            (clk),
    .rst            (rst),
    .output_data    ({output_data, output_uart}),
    .output_valid   (8'b11111111),
    .seg_data       (seg_data),
    .seg_an         (seg_an)
);

Receive receive (
    .clk        (clk),
    .rst        (rst),
    .din        (uart_din),
    .din_vld    (din_vld),
    .din_data   (din_data)
);

Send send(
    .clk        (clk),
    .rst        (rst),
    .dout       (uart_dout),
    .dout_vld   (vld),
    .dout_data  (mode_temp)
);

always @(posedge clk) begin     /* addr 始终为最后四位串口输入的字符 */
    if (rst)
        addr <= 16'b0;
    else if (din_vld)
        addr <= {addr[11:0], transform};
end

always @(*) begin
    transform = transform;
    if (din_vld) begin
        case (din_data)             /* 串口接收数据帧由 ASCII 转为十六进制数 */
            8'h30:      transform = 8'h0;
            8'h31:      transform = 8'h1;
            8'h32:      transform = 8'h2;
            8'h33:      transform = 8'h3;
            8'h34:      transform = 8'h4;
            8'h35:      transform = 8'h5;
            8'h36:      transform = 8'h6;
            8'h37:      transform = 8'h7;
            8'h38:      transform = 8'h8;
            8'h39:      transform = 8'h9;

            8'h41:      transform = 8'hA;
            8'h42:      transform = 8'hB;
            8'h43:      transform = 8'hC;
            8'h44:      transform = 8'hD;
            8'h45:      transform = 8'hE;
            8'h46:      transform = 8'hF;

            8'h61:      transform = 8'hA;
            8'h62:      transform = 8'hB;
            8'h63:      transform = 8'hC;
            8'h64:      transform = 8'hD;
            8'h65:      transform = 8'hE;
            8'h66:      transform = 8'hF;

            default:    transform = 8'h0;
        endcase
    end
end

// Part 1: 使用同步时序进行状态更新，即更新 current_state 的内容
always @(posedge clk) begin
    if (rst)  
        current_state <= IDLE;
    else 
        current_state <= next_state;
end

// Part 2: 使用组合逻辑判断状态跳转逻辑，即根据 current_state 与其他信号确定 next_state
always @(*) begin
    next_state = current_state;
    vld = 0;
    case (current_state)
        IDLE: begin
            if (din_vld) begin
                case (din_data)
                    8'h6A: begin    /* 'j' 跳转 */
                        mode = 0;
                        mode_temp = 8'h6A;
                        next_state = S1;
                    end
                    8'h72: begin    /* 'r' 读出 */
                        mode = 1;
                        mode_temp = 8'h72;
                        next_state = S1;
                    end
                    8'h73: begin    /* 's' 运行 */
                        mode = 2;
                        mode_temp = 8'h73;
                        next_state = S1;
                    end
                    8'h77: begin    /* 'w' 写入 */
                        mode = 3;
                        mode_temp = 8'h77;
                        next_state = S1;
                    end
                    default: next_state = IDLE;
                endcase
            end
        end
        S1: begin
            if (din_vld) begin
                case (din_data)
                    8'h6A: begin    /* 'j' 跳转 */
                        mode = 0;
                        mode_temp = 8'h6A;
                        next_state = S1;
                    end
                    8'h72: begin    /* 'r' 读出 */
                        mode = 1;
                        mode_temp = 8'h72;
                        next_state = S1;
                    end
                    8'h73: begin    /* 's' 运行 */
                        mode = 2;
                        mode_temp = 8'h73;
                        next_state = S1;
                    end
                    8'h77: begin    /* 'w' 写入 */
                        mode = 3;
                        mode_temp = 8'h77;
                        next_state = S1;
                    end
                    default: next_state = S2;
                endcase
            end
        end
        S2: begin
            if (din_vld) begin
                case (din_data)
                    8'h6A: begin    /* 'j' 跳转 */
                        mode = 0;
                        mode_temp = 8'h6A;
                        next_state = S1;
                    end
                    8'h72: begin    /* 'r' 读出 */
                        mode = 1;
                        mode_temp = 8'h72;
                        next_state = S1;
                    end
                    8'h73: begin    /* 's' 运行 */
                        mode = 2;
                        mode_temp = 8'h73;
                        next_state = S1;
                    end
                    8'h77: begin    /* 'w' 写入 */
                        mode = 3;
                        mode_temp = 8'h77;
                        next_state = S1;
                    end
                    default: next_state = S3;
                endcase
            end
        end
        S3: begin
            if (din_vld) begin
                case (din_data)
                    8'h6A: begin    /* 'j' 跳转 */
                        mode = 0;
                        mode_temp = 8'h6A;
                        next_state = S1;
                    end
                    8'h72: begin    /* 'r' 读出 */
                        mode = 1;
                        mode_temp = 8'h72;
                        next_state = S1;
                    end
                    8'h73: begin    /* 's' 运行 */
                        mode = 2;
                        mode_temp = 8'h73;
                        next_state = S1;
                    end
                    8'h77: begin    /* 'w' 写入 */
                        mode = 3;
                        mode_temp = 8'h77;
                        next_state = S1;
                    end
                    default: next_state = S4;
                endcase
            end
        end
        S4: begin
            if (din_vld) begin
                case (din_data)
                    8'h6A: begin    /* 'j' 跳转 */
                        mode = 0;
                        mode_temp = 8'h6A;
                        next_state = S1;
                    end
                    8'h72: begin    /* 'r' 读出 */
                        mode = 1;
                        mode_temp = 8'h72;
                        next_state = S1;
                    end
                    8'h73: begin    /* 's' 运行 */
                        mode = 2;
                        mode_temp = 8'h73;
                        next_state = S1;
                    end
                    8'h77: begin    /* 'w' 写入 */
                        mode = 3;
                        mode_temp = 8'h77;
                        next_state = S1;
                    end
                    default: next_state = DONE;
                endcase
            end
        end
        DONE: begin
            vld = 1;
            next_state = IDLE;
        end
    endcase
end

endmodule
