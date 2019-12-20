`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 23:51:43
// Design Name: 
// Module Name: if_id
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

// 将PC取指阶段得到的结果在每个时钟周期的上升沿传递到译码阶段
module if_id(
    input wire rst,
    input wire clk,
    input wire[`InstAddrBus] if_pc,
    input wire[`InstBus] if_inst,
    output reg[`InstAddrBus] id_pc,
    output reg[`InstBus] id_inst
    );
    
    always @ (posedge clk)
    begin
        if (rst == `RstEnable)
        begin
            id_pc <= `ZeroWord;
            id_inst <= `ZeroWord;
        end
        else
        begin
            id_pc <= if_pc;
            id_inst <= if_inst;
        end
    end
    
endmodule
