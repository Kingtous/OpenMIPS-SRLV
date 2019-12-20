`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 23:40:19
// Design Name: 
// Module Name: pc_reg
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


module pc_reg(
    input wire rst, //复位信号
    input wire clk, //时钟信号
    output reg[`InstAddrBus] pc, //PC的值
    output reg ce //指令寄存器IR的使能信号
    );
    
    // IR
    always @ (posedge clk)
    begin
        // 当复位时，要把IR的使能信号关闭，反之开启
        if (rst == `RstEnable)
            begin
            ce <= `ChipDisable; //芯片禁止为0
            end
        else
            begin
            ce <= `ChipEnable;
            end
    end
    
    // PC加减复位操作
    always @ (posedge clk)
    begin
    if (ce == `ChipDisable)
        begin
            pc <= `ZeroWord; //IR使能禁用后把PC置为0
        end
    else
        begin
            pc <= pc + 4'h4 ;    //PC加4操作，取下一条指令
        end
    end

endmodule
