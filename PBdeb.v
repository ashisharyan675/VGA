`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2023 17:23:51
// Design Name: 
// Module Name: PBdeb
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


module PBdeb(
    input Clk_220Hz,
    input reset_pb,
    output reset_deb
    );
    reg FF1,FF2,FF3;
    always@(posedge Clk_220Hz)
        FF1<=reset_pb;
    always@(posedge Clk_220Hz)
        FF2<=FF1;
    always@(posedge Clk_220Hz)
        FF3<=FF2;
        
    assign reset_deb=FF1 & FF2 & (~FF3);
endmodule
