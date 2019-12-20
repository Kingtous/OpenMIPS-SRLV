`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 17:11:14
// Design Name: 
// Module Name: mem_wb
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


module mem_wb(
    input wire rst,
    input wire clk,
    // 输入
    input wire[`RegAddrBus] mem_wd,
    input wire mem_wreg,
    input wire[`RegBus] mem_wdata,
    // 输出给回写阶段的数据
    output reg[`RegAddrBus] wb_wd,
    output reg wb_wreg,
    output reg[`RegBus] wb_wdata
    );
    
    
    always @ (posedge clk)
    begin
        if(rst == `RstEnable)
        begin
            wb_wd <= `NOPRegAddr;
            wb_wreg <= `WriteDisable;
            wb_wdata <= `ZeroWord;
        end
        else
        begin
           wb_wd <= mem_wd;
           wb_wreg <= mem_wreg;
           wb_wdata <= mem_wdata;
        end
    end
    
endmodule
