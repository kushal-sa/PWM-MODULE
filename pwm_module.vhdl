----------------------------------------------------------------------------------
-- Company: 
-- Engineer:       Prakhar Singh 
-- 
-- Create Date:    20:55:28 10/15/2013 
-- Design Name:    PWM_MODULE
-- Module Name:    servo - Behavioral 
-- Project Name:   SERVO-PWM CONTROL
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity servo is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           button_l : in  STD_LOGIC;
           button_r : in  STD_LOGIC;
           pwm : out  STD_LOGIC);
end servo;

architecture Behavioral of servo is

begin


end Behavioral;

