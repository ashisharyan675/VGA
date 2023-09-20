`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2023 16:20:24
// Design Name: 
// Module Name: Freqdiv
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


module Freqdiv(
    input Clk_8MHz,
    output Clk_1Hz,
    output Clk_220Hz
    );
    reg [22:0] present_state,next_state;
    always@(posedge Clk_8MHz)
       present_state<=next_state;
       
    always@(*)
       next_state=present_state+1;
       
    assign Clk_1Hz=present_state[22];
    assign Clk_220Hz=present_state[14];
endmodule
