----------------------------------------------------------------------------------
-- Company: UNSW
-- Engineer: Jorgen Peddersen
-- 
-- Create Date:    16:06:48 09/26/2006 
-- Design Name:    Blackjack Player
-- Module Name:    Blackjack FSM - Behavioural 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Blackjack_FSM is
  
  port (
    clk                       : in  std_logic;
    rst                       : in  std_logic;
    cardReady                 : in  std_logic;
    newCard                   : out std_logic;
    lost                      : out std_logic;
    finished                  : out std_logic;
    cmp11, cmp16, cmp21       : in  std_logic;
	 Counter							: in  std_logic_vector(4 downto 0); --Counter
    sel                       : out std_logic;
	 enaCounter_p 					: out std_logic_vector(1 downto 0);
	 --enaCounter_m, enaCounter_p: out std_logic; -- Counter-- and Counter++
    enaLoad, enaAdd, enaScore : out std_logic);

end Blackjack_FSM;


architecture Behavioural of Blackjack_FSM is


TYPE State_type IS (S1,S2,S3,S4,S5,S6,S7,S8);
SIGNAL y: State_type;


begin  -- Behavioural

	fsm_transtance:
process(clk,rst)
begin 
  if rst = '0' then 
    y<=s1;
  elsif clk'event and clk='1' then 
    case y is

      when s1=>
        if cardReady = '0' then
          y<=s1;
        else 
          y<=s2;
      end if;
      when s2=>
        if cardReady = '0' then
          y<=s3;
        else
          y<=s2;
      end if;
      when s3=>
      if cmp11 ='1' then
        y<=s6;
      else 
        y<=s4;
      end if;
      when s4=>
        if cmp16 = '0' then
          y<=s8;
        else 
          if cmp21 ='1' then
            if Counter ="00000" then
              y<=s7;
            else
              y<=s5;
            end if; 
			    end if;
        end if;
      when s5=>
        y<=s3;
      when s6=>
        y<=s4;
		 when s7 =>
			y <= S7;
		when S8 =>
			y <= S1;
    end case;
  end if;
end process;

fsm_output:
process (y)
begin
	enaCounter_p <= "00"; -----------
  sel<='1';
  newCard<='1';enaLoad<='0';enaScore<='0';finished<='0';lost<='0';enaAdd<='0';
  case y is

    when s1=>
      newCard<='1';
    when s2=>
      newCard<='0';
      enaLoad<='1';
    when s3=>
      newCard<='1';
      enaAdd<='1';
    when s4=>

      if cmp16 = '1' then
        if cmp21 = '0' then
          lost<='0';
          finished<='1';
			 enaScore<='1';
			 newCard<='0';
        end if;
     else 
      newCard<='1';
      end if; 
    when s5=>
      sel<='0';
      enaCounter_p<="10";--Q = Q-1
      enaLoad<='1';
    when s6=>
      enaCounter_p<="11"; --Q=Q+1
	when S7 =>
		lost <= '1';
		enaScore<='1';
		finished <= '0';
		newcard <= '0';
	when S8 =>
		enaScore<='1';
  end case;
end process; 

end Behavioural;
