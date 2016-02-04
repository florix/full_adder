----------------------------------------------------------------------------------
-- Engineer: Andrea Floridia
-- 
-- Create Date:    16:02:39 02/04/2016 
-- Design Name:    Full Adder Signed/Unsigned
-- Module Name:    fadder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--			Generic Full Adder for signed(two's complement) or unsigned, with 
--			overflow detection.
--			Signal ovf should be taken into account only for operation in two's 
--       complement, whereas for binary addition should look at cout.
-- Dependencies: None.
--
-- Revision: 
-- 	Version 1.0
-- Additional Comments: 
--			The design is purely combinational(dataflow description).
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------


entity fadder is
	generic (N: integer := 8);
	port (
		a, b: in  std_logic_vector(N-1 downto 0);
		cin : in  std_logic;
		sign: in  std_logic;									-- sign <= '0' means unsigned, '1' means signed.
		cout: out std_logic;
		res : out std_logic_vector(N-1 downto 0);
		ovf : out std_logic
	);
end fadder;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------


architecture Behavioral of fadder is

signal tmp: std_logic_vector(N downto 0);

begin


	tmp <= std_logic_vector(signed('0'&a) + signed('0'&b) + ('0'&cin)) 
			 when(sign = '1') else std_logic_vector(unsigned('0'&a) + unsigned('0'&b) + ('0'&cin));
	cout <= tmp(N);
	res <= std_logic_vector(tmp(N-1 downto 0));
	ovf <= tmp(N) xor (a(N-1) xor b(N-1) xor tmp(N-1));

end Behavioral;

