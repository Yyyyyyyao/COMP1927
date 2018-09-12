----------------------------------------------------------------------------------
-- Company: UNSW
-- Engineer: Jorgen Peddersen
-- 
-- Create Date:    16:06:48 09/26/2006 
-- Design Name:    Blackjack Player
-- Module Name:    Blackjack 7 Segment Display - Behavioural 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Blackjack_7Seg is
  
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    score : in  std_logic_vector(4 downto 0);
    data  : out std_logic_vector(0 to 7);
    addr  : out std_logic_vector(3 downto 0));

end Blackjack_7Seg;

architecture Behavioural of Blackjack_7Seg is

begin  -- Behavioural

  
  

end Behavioural;
