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
    --period is determined by the frequency of the clock pulse. In this project, the clock pulse is 50MHz.
	 --Hence the period is 20ms * 50 MHz = 1000000
    constant period: integer:= 1000000;
	 
	 --duty_cycle_max determines the maximum width of the pulse (ie 2ms). Since clock is 20ns,
	 --duty_cycle_max = 2ms/20ns = 100000
	 constant duty_cycle_max: integer:= 100000;
	 
	 --duty_cycle_max determines the minimum width of the pulse (ie 1ms). Since clock is 20ns,
	 --duty_cycle_max = 1ms/20ns = 50000;
	 constant duty_cycle_min: integer:= 50000;
	 
	 --duty_in is determined by the speed of rotation of the servo motor. Assumin a rotation time period of 5ms 
	 --(standard for servo motors), duty_in = ((duty_cycle_max-duty_cycle_min)*period/speed_of_rotation = 200
	 constant duty_in: integer:= 200;
	 
	 signal pwm_reg, pwm_next: std_logic;
	 signal duty_cycle, duty_cycle_next: integer:= 0;
	 signal counter, counter_next: integer:= 0;
	 signal tick: std_logic;
	 
begin
   --register
	process (clk, reset)
		begin
			if reset = '1' then
				pwm_reg <= '0';
				counter <= 0;
				duty_cycle <= 0;
			elsif clk = '1' and clk'event then
				pwm_reg <= pwm_next;
				counter <= counter_next;
				duty_cycle <= duty_cycle_next;
			end if;
	end process;
	
	counter_next <= 0 when counter = period else counter + 1;
	
	tick <= '1' when counter = 0 else '0';
	
	--Changing duty cycle
	process(button_l, button_r, tick,duty_cycle) 
		begin
			duty_cycle_next <= duty_cycle;
				if tick = '1' then
					if button_l ='1' and duty_cycle > duty_cycle_min then
						duty_cycle_next <= duty_cycle - duty_in; 
					elsif button_r = '1' and duty_cycle < duty_cycle_max then
						duty_cycle_next <= duty_cycle + duty_in;
					end if;              
				end if;                            
	end process;
	
	--Buffer
	pwm<=pwm_reg;     
	pwm_next<= '1' when counter < duty_cycle else '0';    
	
end Behavioral;

