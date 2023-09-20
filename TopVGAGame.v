`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2023 05:29:08 PM
// Design Name: 
// Module Name: TopVGAGame
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


module TopVGAGame(
    input CLK_100MHz,
    input Clear,
    input GameOn,
    input GameStart,
    input Bar_up,
    input Bar_down,
    output HSync,
    output VSync,
    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
    );
    
    
    
      CMT_clkdiv instance_name
   (
    // Clock out ports
    .CLK_65MHz(CLK_65MHz),     // output CLK_65MHz
    .CLK_8MHz(CLK_8MHz),     // output CLK_8MHz
   // Clock in ports
    .CLK_100MHz(CLK_100MHz));      // input CLK_100MHz
    
    wire [16:0] HCount,VCount;
    
    Freqdiv F1(.Clk_8MHz(CLK_8MHz),.Clk_220Hz(Clk_220Hz));
    PBdeb P1(.Clk_220Hz(Clk_220Hz),.reset_pb(GameStart),.reset_deb(GameStartdb));
    
    VGA_CTRL V1(.CLK_65MHz(CLK_65MHz), .Clear(Clear), .HSync(HSync), .VSync(VSync),
    .VideoOn(VideoOn),.HCount(HCount),.VCount(VCount));
    
    VGA_Graphic V2(.CLK_65MHz(CLK_65MHz),.Clear(Clear),.GameOn(GameOn),.GameStartdb(GameStartdb),
                         .VideoOn(VideoOn),.Bar_up(Bar_up),.Bar_down(Bar_down),.HCount(HCount), .VCount(VCount), .Red(Red),
                         .Green(Green),.Blue(Blue));
    
    endmodule





