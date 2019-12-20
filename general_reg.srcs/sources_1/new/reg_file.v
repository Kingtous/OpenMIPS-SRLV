`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 23:59:12
// Design Name: 
// Module Name: reg_file
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

// MIPS的32个通用整数寄存器,可同时进行2个读操作
module reg_file(
    input rst,
    input clk,
    // 写端口
    input wire we,
    input wire[`RegAddrBus] waddr,
    input wire[`RegBus] wdata,
    // 读端口 1
    output wire re1,
    output wire[`RegAddrBus] raddr1,
    output reg[`RegBus] rdata1,
    // 读端口 2
    output wire re2,
    output wire[`RegAddrBus] raddr2,
    output reg[`RegBus] rdata2
    );
    
    //32个32位寄存器//
    reg[`RegBus] regs[0:`RegNum-1];
    // 用12345678H初始化32个寄存器
    reg cnt = `RegNum-1;
    initial
    begin
        while (cnt>0)
        begin
            regs[cnt] <= 32'h12345678;
            cnt <= cnt -1;
        end
    end
   
    
    //写操作//
    always @ (posedge clk)
    begin
        if(rst == `RstDisable) //复位无效的时候可以进行写操作
        begin
            if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) //写信号、寻址通用寄存器使用的地址位数
            begin
                regs[waddr] <= wdata;
            end
        end 
    end
    
    //1端口的读操作//
    always @ (posedge clk)
    begin
        if(rst == `RstEnable || raddr1 == `RegNumLog2'h0)
        begin
            rdata1 <= `ZeroWord;
        end
        else if (raddr1 == waddr && we == `WriteEnable && re1 == `ReadEnable)
        begin
            // 如果读出的内容就是写入的内容，那么直接将写入的内容转至读入内容
            rdata1 <= wdata;
        end
        else if (re1 == `ReadEnable)
        begin
            // 将端口内容给rdata1
            rdata1 <= regs[raddr1];
        end
        else
        begin
            // 未考虑的情况,默认写0
            rdata1 <= `ZeroWord;
        end
    end
    
    //2端口的读操作//
    always @ (posedge clk)
    begin
        if(rst == `RstEnable || raddr2 == `RegNumLog2'h0)
        begin
            rdata2 <= `ZeroWord;
        end
        else if (raddr2 == waddr && we == `WriteEnable && re2 == `ReadEnable)
        begin
            // 如果读出的内容就是写入的内容，那么直接将写入的内容转至读入内容
            rdata2 <= wdata;
        end
        else if (re2 == `ReadEnable)
        begin
            // 将端口内容给rdata1
            rdata2 <= regs[raddr2];
        end
        else
        begin
            // 未考虑的情况,默认写0
            rdata2 <= `ZeroWord;
        end
    end
endmodule
