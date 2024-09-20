library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tb is
end ALU_tb;

architecture behavior of ALU_tb is
    signal A, B : std_logic_vector(3 downto 0);
    signal S     : std_logic_vector(2 downto 0);
    signal cf, zf,clk,reset: std_logic;
    signal OUTPUT: std_logic_vector(3 downto 0);

    component ALU
        port (
            A, B   : in std_logic_vector(3 downto 0);
            S      : in std_logic_vector(2 downto 0);
            clk,reset : in std_logic;
            cf, zf : out std_logic;
            OUTPUT : out std_logic_vector(3 downto 0)
        );
    end component;
begin
    uut: ALU port map (
        A      => A,
        B      => B,
        S      => S,
        clk => clk,
        reset => reset,
        cf     => cf,
        zf     => zf,
        OUTPUT => OUTPUT
    );
    
    clock : process
    begin
        clk<='0'; wait for 10ns;
        clk<='1';  wait for 10ns;
    end process;
    process
    begin
        
         reset<='1' ; reset<='0' after 5 ns;  A <= "1010"; B <= "0101"; S <= "000"; wait for 20ns;  --addtion
        S <= "001"; wait for 20 ns; -- subtraction
        S <= "010"; wait for 20 ns; -- 1's compliment
        S <= "011"; wait for 20 ns; -- Logical AND
        S <= "100"; wait for 20 ns; -- Bitwise XNOR
        S <= "101"; wait for 20 ns; -- Logical left shift A
        S <= "110"; wait for 20 ns; -- Rotate A
        S <= "111"; wait for 20 ns; -- Logical equlity comparision
        
        wait;
    end process;
end behavior;
