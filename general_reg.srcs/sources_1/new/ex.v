`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 16:36:06
// Design Name: 
// Module Name: ex
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


module ex(
    input wire rst,
    
    // 译码传过来的数据
    input wire[`AluOpBus] aluop_i,
    input wire[`AluSelBus] alusel_i,
    input wire[`RegBus] reg1_i,
    input wire[`RegBus] reg2_i,
    input wire[`RegAddrBus] wd_i,
    input wire wreg_i,
    
    // 执行结果的输出
    output reg[`RegAddrBus] wd_o,
    output reg wreg_o,
    output reg[`RegBus] wdata_o
    );
    
    // 计算结果的保存器
    reg[`RegBus] logicOut;
    
    // 开始计算
//    reg1_addr_o <= op_rs;
//    reg2_addr_o <= op_rt;
    always @ (*) 
    begin
        if(rst == `RstEnable)
        begin
            logicOut <= `ZeroWord;
        end
        else
        begin
            case (aluop_i)
                `EXE_SRLV_OP:
                begin
                    logicOut <= reg2_i >> reg1_i[4:0]; // reg1为rs，reg2为rt, 指令为rt >> rs[4:0]
                end
            default:
            begin
                logicOut <= `ZeroWord;
            end
            endcase
        end
    end
    
    // 选择运算结果，SRLV是条逻辑右移指令
    always @ (*)
    begin
        wd_o <= wd_i;
        wreg_o <= wreg_i;
        case (alusel_i)
            `EXE_RES_LOGIC:
            begin
                wdata_o <= logicOut;
            end
            default:
            begin
                wdata_o <= `ZeroWord;
            end
        endcase
    end
   
endmodule
