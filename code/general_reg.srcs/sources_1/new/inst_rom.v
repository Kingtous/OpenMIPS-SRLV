`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 17:22:59
// Design Name: 
// Module Name: inst_rom
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

// 指令存储器
module inst_rom(
    input wire ce,
    input wire[`InstAddrBus] addr, // 32bit 指令地址
    output reg[`InstBus] inst       // 32bit 指令
    );
    // 存储器初始化
    reg[`InstBus] inst_mem[0:`InstMemNum-1];
    // 使用.data文件进行初始化
    initial 
    begin
        $readmemh ("inst_rom.data",inst_mem);
        $display ("0x00: %h",inst_mem[8'h00]);
        $display ("0x01: %h",inst_mem[8'h01]);
        $display ("0x02: %h",inst_mem[8'h02]);
        $display ("0x03: %h",inst_mem[8'h03]);
    end
    
    always @ (*)
    begin
        if (ce == `ChipDisable)
        begin
            inst <= `ZeroWord;
        end
        else
        begin
            inst <= inst_mem[addr[`InstMemNumLog2+1:2]]; //取值是4字节一次，所以地址/4,也就是相当于地址右移2位
        end
    end
       
endmodule
