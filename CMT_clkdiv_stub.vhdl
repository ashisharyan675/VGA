-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Wed Jul 19 16:19:53 2023
-- Host        : LAPTOP-37PUOHV7 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/aryan/lab_game/lab_game.srcs/sources_1/ip/CMT_clkdiv/CMT_clkdiv_stub.vhdl
-- Design      : CMT_clkdiv
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CMT_clkdiv is
  Port ( 
    CLK_65MHz : out STD_LOGIC;
    CLK_8MHz : out STD_LOGIC;
    CLK_100MHz : in STD_LOGIC
  );

end CMT_clkdiv;

architecture stub of CMT_clkdiv is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK_65MHz,CLK_8MHz,CLK_100MHz";
begin
end;
