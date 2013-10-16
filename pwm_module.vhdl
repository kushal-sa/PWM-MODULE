----------------------------------------------------------------------------------
-- Engineer:       Prakhar Singh  
-- Create Date:    20:55:28 10/15/2013 
-- Design Name:    PWM_MODULE
-- Module Name:    servo - Behavioral 
-- Project Name:   SERVO-PWM CONTROL

-- Revision 2.00 - Project Complete. Simulation Successful.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--declaring the servo entity
entity servo is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           button_l : in  STD_LOGIC;
           button_r : in  STD_LOGIC;
           pwm : out  STD_LOGIC);
end servo;

--beginning of Behavioral architecture of servo.
architecture Behavioral of servo is

    --period is determined by the frequency of the clock pulse. In this project, the clock pulse is of 50MHz.
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
	 
	 --pwm_temp holds the intermediate values of pwm. pwm_next holds the next value of pwm.
	 signal pwm_temp, pwm_next: std_logic;
	 
	 --duty_cycle, duty_cycle_next hold the corrosponding values of the duty_cycle.
	 signal duty_cycle, duty_cycle_next: integer:= 0;
	 
	 --counter maintains the period of the waveform wrt to clock. counter_next holds the next value of counter.
	 signal counter, counter_next: integer:= 0;
	 
begin
   --process to update the circuit, triggered by clock event.
	process (clk, reset)
		begin
			if reset = '1' then
				pwm_temp <= '0';
				counter <= 0;
				duty_cycle <= 0;
			elsif clk = '1' and clk'event then
				pwm_temp <= pwm_next;
				counter <= counter_next;
				duty_cycle <= duty_cycle_next;
			end if;
	end process;
	
	counter_next <= 0 when counter = period else counter + 1;
	
	--process for changing the duty cycle, operates on button (left or right) press. 
	process(button_l, button_r, duty_cycle) 
		begin
			duty_cycle_next <= duty_cycle;
				if button_l ='1' and duty_cycle > duty_cycle_min then
					duty_cycle_next <= duty_cycle - duty_in; 
				elsif button_r = '1' and duty_cycle < duty_cycle_max then
					duty_cycle_next <= duty_cycle + duty_in;
				end if;                                        
	end process;
	
	--buffer values are transferred to pwm and pwm_next. 
	pwm<=pwm_temp;     
	pwm_next<= '1' when counter < duty_cycle else '0';    
	
end Behavioral;
--end of Behavioral architecture of servo.

