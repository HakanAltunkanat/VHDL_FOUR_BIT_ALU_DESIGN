--a 4-bit ALU as specified in the following. Inputs of the ALU are A[3:0] and B[3:0]. It is required
--3-bit select input S[2:0] for the ALU. Output of the ALU is 4-bit OUT[3:0] Use a one bit carry flag (CF)
--which is 1 if there is carry output and one-bit zero flag which is 1 if all outputs are 0. The required
--operations for the ALU are given in the following: launch simulation failed error hatasý alýyorum 
--  000 : addition
--  001 subtraction
--  010 1's compliment
--  011 logical end
--  100 bitwise xnor
--  101 logic shift left A
--  110 rotate left A
--  111 logical equality comparasion
library IEEE; --necessary libraries
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;


entity ALU is
    port (A,B: in std_logic_vector(3 downto 0); S: in std_logic_vector(2 downto 0); clk, reset : std_logic; cf,zf : out std_logic; OUTPUT : out std_logic_vector(3 downto 0) );
end ALU;

architecture Behavioral of ALU is
signal A_reg, B_reg : std_logic_vector(3 downto 0); --input and output registers
signal S_reg : std_logic_vector(2 downto 0);
signal cf_reg, zf_reg : std_logic;
signal OUTPUT_reg : std_logic_vector(3 downto 0);
begin
    process(A_reg,B_reg,S_reg)
    variable sum : std_logic_vector(4 downto 0);
    variable OUTPUT_var: std_logic_vector(3 downto 0);
    begin
        case S_reg is 
            when "000" =>  --addition
                sum:=('0' & A_reg)+('0' & B_reg);
                OUTPUT_var:=sum(3 downto 0);
                cf_reg<=sum(4);
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if; 
            when "001" => --subtraction
                sum:=('0'& A)-('0' & B);
                OUTPUT_var:=sum(3 downto 0);
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if; 
                if A_reg<B_reg then
                    cf_reg<='1';
                else 
                    cf_reg<='0';
                end if;               
            when "010" => --1's compliment
                OUTPUT_var:= NOT A_reg;
                cf_reg<='0'; --clear carry flag
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if;                
                
            when "011" => --logical and
                OUTPUT_var:=A_reg AND B_reg;
                cf_reg<='0'; --clear carry flag
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if;
            when "100" => --bitwise xnor
                OUTPUT_var:=A_reg XNOR B_reg;
                cf_reg<='0'; --clear carry flag
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if;            
            when "101" => --logical shift left A
                OUTPUT_var:=A_reg(2 downto 0) & '0';
                cf_reg<=A_reg(3);
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if;             
            when "110" => --rotate left
                OUTPUT_var:=A_reg(2 downto 0) & A(3);
                cf_reg<=A_reg(3);
                if OUTPUT_var="0000" then
                    zf_reg<='1';
                else 
                    zf_reg<='0';
                end if;
            when "111" => -- logical equality comparision
            cf_reg<='0'; --clear carry flag
            if A_reg=B_reg then
                OUTPUT_var:="0001";
                zf_reg<='0';
            else
                OUTPUT_var:="0000";
                zf_reg<='1';
             end if;
             when others =>
                OUTPUT_var:="0000";
                cf_reg<='0';
                zf_reg<='0';
        end case;
        OUTPUT_reg<=OUTPUT_var;
       
    end process;
    
    --register
    process(clk, reset)
    begin
        if reset='1' then
            OUTPUT<="0000";
            cf<='0';
            zf<='0';
            A_reg<="0000";
            B_reg<="0000";
            S_reg<="000";
             
        elsif rising_edge(clk) AND reset='0' then
            cf<=cf_reg;
            zf<=zf_reg;
            OUTPUT<=OUTPUT_reg;
            A_reg<=A;
            B_reg<=B;
            S_reg<=S;
        end if;
    end process;

end Behavioral;