----------------------------------------------------------------------------------
-- Engineer:       Prakhar Singh  
-- Create Date:    20:55:28 10/15/2013 
-- Design Name:    PWM_MODULE
-- Module Name:    servo - Behavioral 
-- Project Name:   SERVO-PWM CONTROL

-- Revision 1.00 - File Created
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY pwm_testbench IS
END pwm_testbench;
 
ARCHITECTURE behavior OF pwm_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT servo
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         button_l : IN  std_logic;
         button_r : IN  std_logic;
         pwm : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal button_l : std_logic := '0';
   signal button_r : std_logic := '0';

 	--Outputs
   signal pwm : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: servo PORT MAP (
          clk => clk,
          reset => reset,
          button_l => button_l,
          button_r => button_r,
          pwm => pwm
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
