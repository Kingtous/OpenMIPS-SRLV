`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 00:52:10
// Design Name: 
// Module Name: id
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


module id(
    input wire rst,
    input wire[`InstAddrBus] pc_i,
    input wire[`InstBus] inst_i,
    
    // 两个寄存器的值
    input wire[`RegBus] reg1_data_i,
    input wire[`RegBus] reg2_data_i,
    
    // 写到两个寄存器
    output reg reg1_read_o,
    output reg reg2_read_o,
    output reg[`RegAddrBus] reg1_addr_o,
    output reg[`RegAddrBus] reg2_addr_o,
    
    // 送入执行阶段
    output reg[`AluOpBus] aluop_o,
    output reg[`AluSelBus] alusel_o,
    output reg[`RegBus] reg1_o,
    output reg[`RegBus] reg2_o,
    output reg[`RegAddrBus] wd_o,
    output reg wreg_o,
    
    
    // 处于执行阶段的指令运算结果：处理数据相关
    input wire ex_wreg_i,
    input wire[`RegBus] ex_wdata_i,
    input wire[`RegAddrBus] ex_wd_i,
    // 处于访存
    input wire mem_wreg_i,
    input wire[`RegBus] mem_wdata_i,
    input wire[`RegAddrBus] mem_wd_i
    );
    
    
    // SRLV指令格式为：
    // 000000 rs rt rd 00000 (SRLV)000110
    // 指令格式、6 + 5 + 5 + 5 + 5 +6
    wire[5:0] op_inst = inst_i[5:0];
    wire[4:0] op_rs = inst_i[25:21];
    wire[5:0] op_rt = inst_i[20:16];
    wire[4:0] op_rd = inst_i[15:11];
    wire[5:0] op_special = inst_i[31:26];
    
    // 保存指令执行需要的立即数,但是实现一条SRLV指令不需要用到，注释保留
    //reg[`RegBus] imm;
    // 指令是否是有效的
    reg inst_valid;
    
    always @ (*) 
    begin
        if(rst == `RstEnable)
        begin
            // 复位开启
            aluop_o <= `EXE_NOP_OP;
            alusel_o <= `EXE_RES_NOP;
            wd_o <= `NOPRegAddr;
            wreg_o <= `WriteDisable;
            inst_valid <= `InstValid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= `NOPRegAddr;
            reg2_addr_o <= `NOPRegAddr;
        end
        else
        begin
            aluop_o <= `EXE_NOP_OP;
            alusel_o <= `EXE_RES_NOP;
            wd_o <= inst_i[15:11];
            wreg_o <= `WriteDisable;
            inst_valid <= `InstInvalid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= op_rs;
            reg2_addr_o <= op_rt;
        end
        // 译码阶段
        case(op_special)
            5'b00000:
            begin
                case(op_inst)    //读取指令
                    `EXE_SRLV:
                    begin
                    // 计科170217金韬任务：实现SRLV指令
                    wreg_o <= `WriteEnable;
                    aluop_o <= `EXE_SRLV_OP;
                    alusel_o <= `EXE_RES_LOGIC;
                    // 两个源操作数都要读
                    reg1_read_o <= 1'b1;
                    reg2_read_o <= 1'b1;
                    // 要写入目的寄存器
                    wreg_o <= `WriteEnable;
                    wd_o <= op_rd; //目的寄存器地址
                    // 指令有效
                    inst_valid <= `InstValid;
                    end
                    default:
                    begin 
                    // 非SRLV指令不进行译码
                    end
                endcase
            end
            default:
            begin
            end
        endcase
    end
    
    // 确定源操作数1
    always @ (*) 
    begin
        if(rst == `RstEnable)
        begin
            reg1_o <= `ZeroWord;
        end
        else if (reg1_read_o == 1'b1 && ex_wreg_i == 1'b1 && ex_wd_i == reg1_addr_o)
        begin
            reg1_o <= ex_wdata_i;
        end
        else if (reg1_read_o == 1'b1 && mem_wreg_i == 1'b1 && mem_wd_i == reg1_addr_o)
        begin
            reg1_o <= mem_wdata_i;
        end
        else if(reg1_read_o == 1'b1)
        begin
            reg1_o <= reg1_data_i;
        end
        else if(reg1_read_o == 1'b0)
        begin
            reg1_o <= `ZeroWord;
        end
        else
        begin
            reg1_o <= `ZeroWord;
        end
    end
    
    // 确定源操作数2
    always @ (*) 
    begin
        if(rst == `RstEnable)
        begin
            reg2_o <= `ZeroWord;
        end
        else if (reg2_read_o == 1'b1 && ex_wreg_i == 1'b1 && ex_wd_i == reg2_addr_o)
        begin
            reg2_o <= ex_wdata_i;
        end
        else if (reg2_read_o == 1'b1 && mem_wreg_i == 1'b1 && mem_wd_i == reg2_addr_o)
        begin
            reg2_o <= mem_wdata_i;
        end
        else if(reg2_read_o == 1'b1)
        begin
            reg2_o <= reg2_data_i;
        end
        else if(reg2_read_o == 1'b0)
        begin
            reg2_o <= `ZeroWord;
        end
        else
        begin
            reg2_o <= `ZeroWord;
        end
    end
    
endmodule
