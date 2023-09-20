`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2023 04:35:22 PM
// Design Name: 
// Module Name: VGA_CTRL
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


module VGA_CTRL(
    input CLK_65MHz,
    input Clear,
    output reg HSync,//Horizontal Sync signal
    output reg VSync,
    output reg VideoOn,
    output [16:0] HCount, // Location of electronic beam in H direction
    output [16:0] VCount
    );
    
    // No of pixels in a row
    parameter HPIXELS = 1344; 
    // Total number of lines/rows
    parameter VLINES = 806;
    parameter HBP = 296; //Horizontal back porch
    parameter HFP = 1320;//Horizontal front porch
    parameter VBP = 35; //Veritical back porch
    parameter VFP = 803; //Vertical front porch
    parameter HSP = 136;//Horizontal Sync Pulse
    parameter VSP = 6; //Vertical Sync Pulse
    
    reg [16:0]  H_present_state, H_next_state;
    always@(posedge CLK_65MHz)
        if(Clear)
            H_present_state <= 0;
        else
            H_present_state <= H_next_state;
            
     always@(*)
     begin
        if(H_present_state == HPIXELS-1)
            H_next_state = 0;
        else
            H_next_state = H_present_state + 1;
     end       
    assign HCount = H_present_state;
    
    always@(*)
        if(H_present_state < HSP)
            HSync = 0;
        else
            HSync = 1;
       
     reg VSync_flag;
     always@(*)
     begin
        if(H_present_state == HPIXELS-1)
            VSync_flag = 1;
        else
            VSync_flag = 0;
     end     
     
     reg [16:0] V_present_state, V_next_state;
     always@(posedge CLK_65MHz)
        if(Clear)
            V_present_state <= 0;
        else
            V_present_state <= V_next_state;
     
     always@(*)
     begin
        if(VSync_flag)
            if(V_present_state == VLINES-1)
                V_next_state = 0;
            else
                V_next_state = V_present_state + 1;             
       else
            V_next_state = V_present_state;
     end       
     
     assign VCount = V_present_state;

     
    always@(*)
        if(V_present_state < VSP)
            VSync = 0;
        else
            VSync = 1;
     
     always@(*)
     begin
        if((H_present_state > HBP) && (H_present_state < HFP) && (V_present_state > VBP)&& (V_present_state < VFP))
            VideoOn = 1;
        else
            VideoOn = 0;
     end
            
endmodule









