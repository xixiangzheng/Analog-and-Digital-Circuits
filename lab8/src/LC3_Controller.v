`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 16:13:43
// Design Name: 
// Module Name: Controller
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


module Controller(
    input                       clk,            // 时钟信号
    input                       rst,            // 系统复位信号
    input                       btn,            // 按下按钮后，处理器从 IF 状态开始执行一条指令的完整流程
    input       [ 3:0]          sw,             // 控制寄存器编号的开关
    input                       vld,            /* 串口输入的有效信号 */
    input       [ 1:0]          mode,           /* 串口输入的指令类型 */
    input       [15:0]          addr,           /* 串口输入的指令参数 */
    output reg  [15:0]          echo,           // 数码管的高四位显示对应寄存器中的数值
    output      [15:0]          res             /* 数码管的低四位显示串口读出操作的结果 */
);

parameter IDLE      = 8'b1101_0000;             // 待机状态
parameter FETCH_0   = 8'b1101_0001;             // 取指令阶段
parameter FETCH_1   = 8'b1101_0010;
parameter FETCH_2   = 8'b1101_0011;
parameter FETCH_3   = 8'b1101_0100;
parameter DECODE    = 8'b1101_0101;             // 译码阶段

parameter ADD_0     = 8'b0001_0000;             // 各 LC-3 指令的地址计算、取操作数、执行、存储阶段
parameter ADD_1     = 8'b0001_0001;

parameter AND_0     = 8'b0101_0000;
parameter AND_1     = 8'b0101_0001;

parameter BR_0      = 8'b0000_0000;
parameter BR_1      = 8'b0000_0001;

parameter JMP_0     = 8'b1100_0000;
parameter JMP_1     = 8'b1100_0001;

parameter JSR_0     = 8'b0100_0000;
parameter JSR_1     = 8'b0100_0001;
parameter JSR_2     = 8'b0100_0010;

parameter LD_0      = 8'b0010_0000;
parameter LD_1      = 8'b0010_0001;
parameter LD_2      = 8'b0010_0010;
parameter LD_3      = 8'b0010_0011;

parameter LDR_0     = 8'b0110_0000;
parameter LDR_1     = 8'b0110_0001;
parameter LDR_2     = 8'b0110_0010;
parameter LDR_3     = 8'b0110_0011;

parameter LEA_0     = 8'b1110_0000;
parameter LEA_1     = 8'b1110_0001;

parameter NOT_0     = 8'b1001_0000;
parameter NOT_1     = 8'b1001_0001;

parameter ST_0      = 8'b0011_0000;
parameter ST_1      = 8'b0011_0001;
parameter ST_2      = 8'b0011_0010;
parameter ST_3      = 8'b0011_0011;

parameter STR_0     = 8'b0111_0000;
parameter STR_1     = 8'b0111_0001;
parameter STR_2     = 8'b0111_0010;
parameter STR_3     = 8'b0111_0011;

parameter TRAP      = 8'b1111_0000;             // 仅支持 TRAP x25，用于串口运行操作的停机，需要 rst 方可恢复
parameter JUMP      = 8'b1111_0001;  
parameter START     = 8'b1111_0010; 
parameter WRITE_0   = 8'b1111_0011;
parameter WRITE_1   = 8'b1111_0100;

wire [15:0] DataPath;

reg  [ 2:0] DR_sel; 
reg  [ 2:0] SR1_sel; 
reg  [ 2:0] SR2_sel; 
reg  [ 3:0] ALU_sel; 
reg         MEM_sel;

wire [15:0] SR1_out;
wire [15:0] SR2_out;
wire [15:0] ALU_out;
wire [15:0] MEM_out;

reg         SR2MUX_sel;
reg         ADDR1MUX_sel;
reg  [ 1:0] ADDR2MUX_sel;
reg  [ 1:0] PCMUX_sel;
reg         MARMUX_sel;
reg         MDRMUX_sel;

reg  [15:0] SR2MUX_out;
reg  [15:0] ADDR1MUX_out;
reg  [15:0] ADDR2MUX_out;
reg  [15:0] PCMUX_out;
reg  [15:0] MARMUX_out;
reg  [15:0] MDRMUX_out;

reg         LD_MDR;
reg         LD_MAR;
reg         LD_IR;
reg         LD_CC;
reg         LD_REG;
reg         LD_PC;

reg         GateMDR; 
reg         GateALU;
reg         GatePC;
reg         GateMARMUX;

reg  [15:0] IR; 
reg  [ 2:0] CC; 
reg  [15:0] PC;
reg  [15:0] MDR;
reg  [15:0] MAR;

wire [15:0] echo_out;
reg  [15:0] addr_temp;
reg         jump_flag;
reg         start_flag;
reg         write_flag;

reg  [15:0] cnt;

reg  [ 7:0] current_state;
reg  [ 7:0] next_state;

assign DataPath = ({16{GateMDR}} & MDR) | ({16{GateALU}} & ALU_out) | ({16{GatePC}} & PC) | ({16{GateMARMUX}} & MARMUX_out);

always @(*) begin
    case (sw)
        4'b1000: echo = PC;
        4'b1001: echo = IR;
        4'b1010: echo = CC;
        4'b1011: echo = MAR;
        4'b1100: echo = MDR;
        4'b1101: echo = current_state;
        4'b1110: echo = current_state;
        4'b1111: echo = current_state; 
        default: echo = echo_out;       /* sw[3] == 0 时回显各寄存器的值 */
    endcase
end

// Part 1: 使用同步时序进行状态更新，即更新 current_state 的内容
always @(posedge clk) begin
    if (rst)  
        current_state <= IDLE;
    else 
        current_state <= next_state;
end

always @(posedge clk) begin
    if (rst)  
        cnt <= 0;
    else if (start_flag)
        cnt <= addr;
    else if (current_state == IDLE && cnt > 0)      /* 指令条数倒计数，用于串口运行操作 */
        cnt <= cnt - 1;
    else
        cnt <= cnt;
end

// Part 2: 使用组合逻辑判断状态跳转逻辑，即根据 current_state 与其他信号确定 next_state
always @(*) begin
    next_state = current_state;
    case (current_state)
        IDLE: begin
            if (vld) begin
                case (mode)
                    2'b00: begin            /* 串口跳转 jump 操作 */
                        jump_flag = 1;      /* 直接修改 PC */
                        next_state = JUMP;
                    end
                    2'b01: begin            /* 串口读出 read 操作*/
                        addr_temp = addr;   /* 将此时的地址保存至 temp */
                        next_state = IDLE;
                    end
                    2'b10: begin            /* 串口运行 start 操作*/
                        start_flag = 1;     /* 连续执行指令并进行倒计数，遇到 TRAP x25 或达到最大指令条数时停止 */
                        next_state = START;
                    end
                    2'b11: begin            /* 串口写入 write 操作*/
                        write_flag = 1;     /* 直接修改 MAR, MDR 以修改内存 */   
                        next_state = WRITE_0;
                    end      
                endcase
            end
            else if (cnt > 0) begin
                next_state = FETCH_0;
            end
            else if (btn) begin
                next_state = FETCH_0;
            end
        end
        FETCH_0: begin
            GatePC = 1;
            LD_MAR = 1;
            next_state = FETCH_1;
        end
        FETCH_1: begin
            LD_MAR = 0;
            GatePC = 0;
            MDRMUX_sel = 0;
            LD_MDR = 1;
            next_state = FETCH_2;
        end
        FETCH_2: begin
            LD_MDR = 0;
            GateMDR = 1;
            LD_IR = 1;
            next_state = FETCH_3;
        end
        FETCH_3: begin
            GateMDR = 0;
            LD_IR = 0;
            PCMUX_sel = 0;
            LD_PC = 1;
            next_state = DECODE;
        end
        DECODE: begin
            LD_PC = 0;
            case (IR[15:12])
                4'b0001: next_state = ADD_0;
                4'b0101: next_state = AND_0;
                4'b0000: next_state = BR_0;
                4'b1100: next_state = JMP_0;
                4'b0100: next_state = JSR_0;
                4'b0010: next_state = LD_0;
                4'b0110: next_state = LDR_0;
                4'b1110: next_state = LEA_0;
                4'b1001: next_state = NOT_0;
                4'b0011: next_state = ST_0;
                4'b0111: next_state = STR_0;
                4'b1111: next_state = TRAP;
                default: next_state = IDLE;
            endcase
        end

        ADD_0: begin
            SR1_sel = IR[8:6];
            SR2_sel = IR[2:0];   

            SR2MUX_sel = (IR[5] == 0) ? 0 : 1;
            ALU_sel = 4'b0001;
            GateALU = 1;

            DR_sel = IR[11:9];
            LD_REG = 1;
            LD_CC = 1;
            next_state = ADD_1;
        end
        ADD_1: begin
            GateALU = 0;
            LD_REG = 0;
            LD_CC = 0;
            next_state = IDLE;
        end

        AND_0: begin
            SR1_sel = IR[8:6];
            SR2_sel = IR[2:0];
  
            SR2MUX_sel = (IR[5] == 0) ? 0 : 1;
            ALU_sel = 4'b0010;
            GateALU = 1;

            DR_sel = IR[11:9];
            LD_REG = 1;
            LD_CC = 1;
            next_state = AND_1;
        end
        AND_1: begin
            GateALU = 0;
            LD_REG = 0;
            LD_CC = 0;
            next_state = IDLE;
        end

        BR_0: begin
            if (CC[2] & IR[11] == 1 | CC[1] & IR[10] == 1 | CC[0] & IR[9] == 1) begin
                ADDR1MUX_sel = 0;
                ADDR2MUX_sel = 2;
                PCMUX_sel = 1;
                LD_PC = 1;
                next_state = BR_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        BR_1: begin    
            LD_PC = 0;
            next_state = IDLE;
        end

        JMP_0: begin
            SR1_sel = IR[8:6];

            ADDR1MUX_sel = 1;
            ADDR2MUX_sel = 0;
            PCMUX_sel = 1;
            LD_PC = 1;
            next_state = JMP_1;
        end
        JMP_1: begin    
            LD_PC = 0;
            next_state = IDLE;
        end

        JSR_0: begin
            GatePC = 1;
            DR_sel = 7;
            LD_REG = 1;
            next_state = JSR_1;
        end
        JSR_1: begin
            LD_REG = 0;
            GatePC = 0;
            if (IR[11] == 0) begin
                SR1_sel = IR[8:6];
                ADDR1MUX_sel = 1;
                ADDR2MUX_sel = 0;
            end
            else begin
                ADDR1MUX_sel = 0;
                ADDR2MUX_sel = 3;
            end
            PCMUX_sel = 1;
            LD_PC = 1;
            next_state = JSR_2;
        end
        JSR_2: begin    
            LD_PC = 0;
            next_state = IDLE;
        end

        LD_0: begin
            ADDR1MUX_sel = 0;
            ADDR2MUX_sel = 2;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            LD_MAR = 1;
            next_state = LD_1;
        end
        LD_1: begin
            LD_MAR = 0;
            GateMARMUX = 0;
            MDRMUX_sel = 0;
            LD_MDR = 1;
            LD_CC = 1;
            next_state = LD_2;
        end
        LD_2: begin
            LD_MDR = 0;
            GateMDR = 1;
            DR_sel = IR[11:9];
            LD_REG = 1;
            next_state = LD_3;
        end
        LD_3: begin
            LD_REG = 0;
            LD_CC = 0;
            GateMDR = 0;
            next_state = IDLE;
        end

        LDR_0: begin
            SR1_sel = IR[8:6];

            ADDR1MUX_sel = 1;
            ADDR2MUX_sel = 1;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            LD_MAR = 1;
            next_state = LDR_1;
        end
        LDR_1: begin
            LD_MAR = 0;
            GateMARMUX = 0;
            MDRMUX_sel = 0;
            LD_MDR = 1;
            LD_CC = 1;
            next_state = LDR_2;
        end
        LDR_2: begin
            LD_MDR = 0;
            GateMDR = 1;
            DR_sel = IR[11:9];
            LD_REG = 1;
            next_state = LDR_3;
        end
        LDR_3: begin
            LD_REG = 0;
            LD_CC = 0;
            GateMDR = 0;
            next_state = IDLE;
        end

        LEA_0: begin
            ADDR1MUX_sel = 0;
            ADDR2MUX_sel = 2;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            DR_sel = IR[11:9];
            LD_REG = 1;
            LD_CC = 1;
            next_state = LEA_1;
        end
        LEA_1: begin
            LD_REG = 0;
            LD_CC = 0;
            GateMARMUX = 0;
            next_state = IDLE;
        end

        NOT_0: begin
            SR1_sel = IR[8:6];
   
            SR2MUX_sel = 0;
            ALU_sel = 4'b0100;
            GateALU = 1;

            DR_sel = IR[11:9];
            LD_REG = 1;
            LD_CC = 1;
            next_state = NOT_1;
        end
        NOT_1: begin
            GateALU = 0;
            LD_REG = 0;
            LD_CC = 0;
            next_state = IDLE;
        end

        ST_0: begin
            ADDR1MUX_sel = 0;
            ADDR2MUX_sel = 2;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            LD_MAR = 1;
            next_state = ST_1;
        end
        ST_1: begin
            LD_MAR = 0;
            GateMARMUX = 0;
            SR1_sel = IR[11:9];

            ADDR1MUX_sel = 1;
            ADDR2MUX_sel = 0;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            MDRMUX_sel = 1;
            LD_MDR = 1;
            next_state = ST_2;
        end
        ST_2: begin
            LD_MDR = 0;
            GateMARMUX = 0;
            MEM_sel = 1;
            next_state = ST_3;
        end
        ST_3: begin
            MEM_sel = 0;
            next_state = IDLE;
        end

        STR_0: begin
            SR1_sel = IR[8:6];
            ADDR1MUX_sel = 1;
            ADDR2MUX_sel = 1;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            LD_MAR = 1;
            next_state = STR_1;
        end
        STR_1: begin
            LD_MAR = 0;
            GateMARMUX = 0;
            SR1_sel = IR[11:9];

            ADDR1MUX_sel = 1;
            ADDR2MUX_sel = 0;
            MARMUX_sel = 1;
            GateMARMUX = 1;
            MDRMUX_sel = 1;
            LD_MDR = 1;
            next_state = STR_2;
        end
        STR_2: begin
            LD_MDR = 0;
            GateMARMUX = 0;
            MEM_sel = 1;
            next_state = STR_3;
        end
        STR_3: begin
            MEM_sel = 0;
            next_state = IDLE;
        end

        TRAP: begin
            next_state = TRAP;
        end
		JUMP: begin
            jump_flag = 0;
            next_state = IDLE;
        end
        START: begin
            start_flag = 0;
            next_state = IDLE;
        end
        WRITE_0: begin
            write_flag = 0; 
            MEM_sel = 1;
            next_state = WRITE_1;
        end
		WRITE_1: begin
            MEM_sel = 0;
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin 
    if (rst)                MAR <= 0;
    else if (write_flag)    MAR <= PC;
    else if (LD_MAR)        MAR <= DataPath;
    else                    MAR <= MAR;
end

always @(posedge clk) begin 
    if (rst)                MDR <= 0;
    else if (write_flag)    MDR <= addr;
    else if (LD_MDR)        MDR <= MDRMUX_out;
    else                    MDR <= MDR;
end

always @(posedge clk) begin
    if (rst)                IR <= 0;
    else if (LD_IR)         IR <= DataPath;
    else                    IR <= IR;
end

always @(posedge clk) begin
    if (rst)                CC <= 0;
    else if (LD_CC) begin
        CC[2] <= (DataPath[15] == 1) ? 1 : 0;
        CC[1] <= (DataPath == 0) ? 1 : 0;
        CC[0] <= (DataPath[15] == 0 && DataPath != 0) ? 1 : 0;
    end
    else                    CC <= CC;
end

always @(posedge clk) begin
    if (rst)                PC <= 0;
    else if (jump_flag)     PC <= addr;
	else if (write_flag)    PC <= PC + 1;
    else if (LD_PC)         PC <= PCMUX_out;
    else                    PC <= PC;
end

always @(*) begin
    case (SR2MUX_sel)       // SR2 多路选择器
        1'b0:   SR2MUX_out = SR2_out;
        1'b1:   SR2MUX_out = {{12{IR[4]}}, {IR[3:0]}};
    endcase
end

always @(*) begin
    case (ADDR1MUX_sel)     // ADDR1 多路选择器
        1'b0:   ADDR1MUX_out = PC;
        1'b1:   ADDR1MUX_out = SR1_out;
    endcase 
end

always @(*) begin
    case (ADDR2MUX_sel)     // ADDR2 多路选择器
        2'b00:   ADDR2MUX_out = 0;
        2'b01:   ADDR2MUX_out = {{11{IR[5]}}, {IR[4:0]}};
        2'b10:   ADDR2MUX_out = {{8{IR[ 8]}}, {IR[7:0]}};
        2'b11:   ADDR2MUX_out = {{6{IR[10]}}, {IR[9:0]}};
    endcase
end

always @(*) begin
    case (PCMUX_sel)        // PC 多路选择器
        2'b00:   PCMUX_out = PC + 1;
        2'b11:   PCMUX_out = PC + 1;
        2'b01:   PCMUX_out = ADDR1MUX_out + ADDR2MUX_out;
        2'b10:   PCMUX_out = DataPath;    
    endcase
end

always @(*) begin
    case (MARMUX_sel)       // MAR 多路选择器
        1'b0:   MARMUX_out = {{9{IR[ 7]}}, {IR[6:0]}};
        1'b1:   MARMUX_out = ADDR1MUX_out + ADDR2MUX_out;
    endcase
end

always @(*) begin           // MDR 多路选择器
    case (MDRMUX_sel)
        1'b0:   MDRMUX_out = MEM_out;
        1'b1:   MDRMUX_out = DataPath;
    endcase
end

ALU alu(
    .src0(SR1_out),
    .src1(SR2MUX_out),
    .sel(ALU_sel),
    .res(ALU_out)
);

RegFile regfile(
    .clk(clk),
    .rst(rst),
    .ra0(sw[2:0]),
    .ra1(SR1_sel),
    .ra2(SR2_sel),
    .wa(DR_sel),
    .we(LD_REG),
    .din(DataPath),
    .dout0(echo_out),
    .dout1(SR1_out),
    .dout2(SR2_out)
);

dist_mem_gen_0 memory(
    .a(MAR[9:0]),
    .d(MDR),
    .dpra(addr_temp[9:0]),   /* 串口读出操作的地址 */
    .clk(clk),
    .we(MEM_sel),
    .spo(MEM_out),
    .dpo(res)           /* 串口读出操作的输出 */
);

initial begin           // 用于仿真的 initial
    LD_MDR = 0;
    LD_MAR = 0;
    LD_IR = 0;
    LD_CC = 0;
    LD_REG = 0;
    LD_PC = 0;
    MEM_sel = 0;
    GateMDR = 0; 
    GateALU = 0;
    GatePC = 0;
    GateMARMUX = 0;
    jump_flag = 0;
    start_flag = 0;
    write_flag = 0;
    cnt = 0;
end
endmodule