// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Wed Jul 19 16:19:53 2023
// Host        : LAPTOP-37PUOHV7 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/aryan/lab_game/lab_game.srcs/sources_1/ip/CMT_clkdiv/CMT_clkdiv_stub.v
// Design      : CMT_clkdiv
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module CMT_clkdiv(CLK_65MHz, CLK_8MHz, CLK_100MHz)
/* synthesis syn_black_box black_box_pad_pin="CLK_65MHz,CLK_8MHz,CLK_100MHz" */;
  output CLK_65MHz;
  output CLK_8MHz;
  input CLK_100MHz;
endmodule
