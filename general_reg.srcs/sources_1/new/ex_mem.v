`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 16:56:33
// Design Name: 
// Module Name: ex_mem
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


module ex_mem(
    input wire clk,
    input wire rst,
    // 执行阶段的结果
    input wire[`RegAddrBus] ex_wd,
    input wire ex_wreg,
    input wire[`RegBus] ex_wdata,
    // 传递给mem阶段的数据
    output reg[`RegAddrBus] mem_wd,
    output reg mem_wreg,
    output reg[`RegBus] mem_wdata
    );
    
    always @ (posedge clk)
    begin
        if(rst == `RstEnable)
        begin
            mem_wd <= `NOPRegAddr;
            mem_wreg <= `WriteDisable;
            mem_wdata <= `ZeroWord;
        end
        else
        begin
            mem_wd <= ex_wd;
            mem_wreg <= ex_wreg;
            mem_wdata <= ex_wdata;
        end
    end
      
endmodule
