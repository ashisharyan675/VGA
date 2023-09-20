`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2023 09:13:59 AM
// Design Name: 
// Module Name: VGA_Graphics
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


module VGA_Graphic(
    input CLK_65MHz,
    input Clear,
    input GameOn,
    input VideoOn,
    input GameStartdb,
    input Bar_up,
    input Bar_down,
    input [16:0] HCount,
    input [16:0] VCount,
    output reg [3:0] Red,
    output reg [3:0] Green,
    output reg [3:0] Blue
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

    reg game_stop=1;
    reg refresh_time;
    
    reg WallOn;
    parameter WALL_R = 1080;
    parameter WALL_L = 1040;   
    
    always@(*)
    begin
        if(HCount > WALL_L && HCount < WALL_R)
            WallOn = 1;
        else 
            WallOn = 0;
    end
        
    reg BarOn;
    parameter BAR_L = 300;
    parameter BAR_R = 320;
    parameter BAR_U = 100;
    parameter BAR_S = 200;
    parameter BAR_Vel = 3;
    parameter dec=50;
//    parameter BAR_W=200;
    
    reg [16:0]  Bar_v_PS; // these are unknowns
    reg [16:0]  Bar_v_NS; // these are unknowns
    reg [16:0]  Bar_s_PS;
    reg [16:0]  Bar_s_NS;
    always@(*)
    begin
        if((HCount>BAR_L)&&(HCount<BAR_R)&&(VCount>Bar_v_PS)&&(VCount<Bar_v_PS+Bar_s_NS))
            BarOn=1;
        else
            BarOn=0;
    end
       
    always@(posedge CLK_65MHz)//default position
    if(Clear)
    begin
        Bar_v_PS<=BAR_U;
    end
    else
    begin
        Bar_v_PS<=Bar_v_NS;
    end
    //bar size
    always@(*)
    begin
      if(HIT_Counter_NS==2)
        Bar_s_NS = Bar_s_PS-dec;
      else if(GameStartdb == 1)
        Bar_s_NS = BAR_S;
      else if(game_stop)
        Bar_s_NS = BAR_S;
      else
        Bar_s_NS=Bar_s_PS;
        
    end
    always@(posedge CLK_65MHz)
    begin
        if(Clear)
                begin
                    Bar_s_PS <= BAR_S;
                    
                end
            else
                begin
                    Bar_s_PS <= Bar_s_NS;
                    
                end
    end
    
    always@(*)
    begin
      if(game_stop||~GameOn)
        Bar_v_NS=BAR_U;
      else if((Bar_up==1)&&(refresh_time==1) && (Bar_v_PS>VBP))
        Bar_v_NS=Bar_v_PS-BAR_Vel;
      else if((Bar_down==1)&&(refresh_time==1)&&(Bar_v_PS+Bar_s_NS<VFP))
        Bar_v_NS=Bar_v_PS+BAR_Vel;
      else 
        Bar_v_NS=Bar_v_PS;
    end
    
    reg BallOn;
    parameter BALL_L = 450;
    parameter BALL_U = 200;
    parameter BALL_S = 31;
    parameter BALL_Vel = 5;
    reg [16:0] Ball_h_PS, Ball_v_PS; // these are unknowns
    reg [16:0] Ball_h_NS, Ball_v_NS; // these are unknowns
    reg [16:0] Ball_hdir_PS, Ball_vdir_PS; // these are unknowns
    reg [16:0] Ball_hdir_NS, Ball_vdir_NS; // these are unknowns

    always@(*)
    begin
        if((HCount > Ball_h_PS) && (HCount < Ball_h_PS + BALL_S) && (VCount > Ball_v_PS) && (VCount < Ball_v_PS+BALL_S))
            BallOn = 1;
        else 
            BallOn = 0;
    end
    
    always@(posedge CLK_65MHz)
    begin
            if(Clear)
                begin
                    Ball_h_PS <= BALL_L;
                    Ball_v_PS <= BALL_U;
                end
            else
                begin
                    Ball_h_PS <= Ball_h_NS;
                    Ball_v_PS <= Ball_v_NS;
                end
    end
    
    always@(*)
    begin
        refresh_time = ((HCount ==0) && (VCount==0));
    end
    
    always@(*)
    begin
        if((refresh_time == 1) && (game_stop==0))
            begin
                Ball_h_NS = Ball_h_PS + Ball_hdir_PS;
                Ball_v_NS = Ball_v_PS + Ball_vdir_PS;
            end
       else if(game_stop)
            begin
                Ball_h_NS = BALL_L;
                Ball_v_NS = BALL_U;
            end
        else
            begin
                Ball_h_NS = Ball_h_PS;
                Ball_v_NS = Ball_v_PS;
            end
    end
    
   always@(posedge CLK_65MHz)
   begin
        if(Clear)
            begin
                Ball_hdir_PS <= BALL_Vel;
                Ball_vdir_PS <= BALL_Vel;
            end
        else
            begin
                Ball_hdir_PS <= Ball_hdir_NS;
                Ball_vdir_PS <= Ball_vdir_NS;
            end
   end
   
   reg[3:0] Ball_vel_PS,Ball_vel_NS;
   always@(*)
   begin
        if(Ball_h_PS+BALL_S >= WALL_L)
            begin
                Ball_hdir_NS = -Ball_vel_PS;
                Ball_vdir_NS = Ball_vdir_PS;
            end
        else if((Ball_h_PS <= BAR_R)&&(~((Ball_v_PS>Bar_v_PS+Bar_s_NS)||(Ball_v_PS+BALL_S<Bar_v_PS))))
            begin
                Ball_hdir_NS = Ball_vel_PS;
                Ball_vdir_NS = Ball_vdir_PS;
            end
        else if(Ball_v_PS <= VBP)
            begin
                Ball_hdir_NS = Ball_hdir_PS;
                Ball_vdir_NS = BALL_Vel;
            end
        else if(Ball_v_PS + BALL_S>= VFP)
            begin
                Ball_hdir_NS = Ball_hdir_PS;
                Ball_vdir_NS = -BALL_Vel;
            end
         else
            begin
                Ball_hdir_NS = Ball_hdir_PS;
                Ball_vdir_NS = Ball_vdir_PS;
            end
   end
   
   
   always@(posedge CLK_65MHz)
   begin
        if(Clear)
            Ball_vel_PS<=BALL_Vel;
        else
            Ball_vel_PS<=Ball_vel_NS;
   end
   
   reg [5:0] HIT_Counter_PS,HIT_Counter_NS;
   always@(posedge CLK_65MHz)
   begin
        if(Clear)
            HIT_Counter_PS <=0;
        else
            HIT_Counter_PS <= HIT_Counter_NS;
   end
   
   always@(*)
   begin
          if(HIT_Counter_PS==2)
                Ball_vel_NS=Ball_vel_PS+2;
          else if(game_stop)
                Ball_vel_NS = BALL_Vel;
          else if(GameStartdb)
                Ball_vel_NS =BALL_Vel;
          else
                Ball_vel_NS=Ball_vel_PS;
   end
   
   always@(*)
   begin
          if(HIT_Counter_PS>=2)
                HIT_Counter_NS=0;
          else if((Ball_h_PS+BALL_S >= WALL_L)  && (refresh_time==1))
                HIT_Counter_NS = HIT_Counter_PS +1;
          else if(game_stop)
                HIT_Counter_NS = 0;
          else if(GameStartdb)
                HIT_Counter_NS =0;
          else
                HIT_Counter_NS=HIT_Counter_PS;
   end
   
   always@(posedge CLK_65MHz)
   begin
        if(Clear)
            game_stop <=1;
        else if((Ball_h_PS <= BAR_R)&&((Ball_v_PS>Bar_v_PS+Bar_s_NS))||(Ball_v_PS+BALL_S<Bar_v_PS))
            begin
               game_stop <=1;
            end
        //else if((HIT_Counter_PS >= 5))
            //game_stop <= 1;
        else if(GameStartdb == 1)
            game_stop <= 0;
        else if(GameOn==0)
            game_stop<=1;
   end
   
   
   always@(*)
    begin
        Red = 4'b0000; 
        Green = 4'b0000; 
        Blue = 4'b0000;
        if (VideoOn == 1 && GameOn == 1 && BallOn==1)  // Background Display
        begin
            Red = 4'b1111; 
            Green = 4'b0000; 
            Blue = 4'b0000;
        end   
        else if (VideoOn == 1 && GameOn == 1 && BarOn==1)  // Background Display
        begin
            Red = 4'b0000; 
            Green = 4'b0000; 
            Blue = 4'b1111;
        end   
        else if (VideoOn == 1 && GameOn == 1 && WallOn==1)  // Background Display
        begin
            Red = 4'b0000; 
            Green = 4'b0000; 
            Blue = 4'b1111;
        end     
        else if (VideoOn == 1 && GameOn == 1)  // Background Display
        begin
            Red = 4'b1111; 
            Green = 4'b1111; 
            Blue = 4'b0000;
        end
        else if (VideoOn == 1) //Blankscreen Display
        begin
            Red = 4'b1111; 
            Green = 4'b1111; 
            Blue = 4'b1111;
        end
    end 
endmodule