library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use work.Definitions.all;

entity Keyboard is
	port(
		KeyboardData	: in 	std_logic; --键盘数据输入
		KeyboardClk		: in 	std_logic; --键盘时钟输入
		FilterClk5M		: in 	std_logic; --滤波5M时钟输入
		KeyboardOut		: out std_logic_vector(7 downto 0) := "00000000" --当前按键状态
	);
end Keyboard;

architecture Behavioral of Keyboard is
	type state_type is (DELAY, START, D0, D1, D2, D3, D4, D5, D6, D7, PARITY, STOP, FINISH);
	signal state: state_type := DELAY; --当前状态
	signal code: std_logic_vector(7 downto 0) := "00000000"; --扫描码缓冲区
	signal last_code: std_logic_vector(7 downto 0) := "00000000"; --上一次扫描码
	signal filter_KeyboardData: std_logic := '0'; --滤波后的键盘数据
	signal tmp_clk1: std_logic := '0'; --滤波用临时时钟
	signal tmp_clk2: std_logic := '0'; --滤波用临时时钟
	signal filter_KeyboardClk: std_logic := '0'; --滤波后的键盘时钟
	signal code_odd: std_logic := '0'; --奇校验码
	signal code_ok: std_logic := '0'; --扫描码读取成功
	signal key_state: std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
	signal cur_key: integer :=0;
begin
	tmp_clk1 <= KeyboardClk when rising_edge(FilterClk5M);
	tmp_clk2 <= tmp_clk1 when rising_edge(FilterClk5M);
	filter_KeyboardClk <= not(tmp_clk1) and tmp_clk2;
	filter_KeyboardData <= KeyboardData when rising_edge(FilterClk5M);
	code_odd <= code(0) xor code(1) xor code(2) xor code(3) xor code(4) xor code(5) xor code(6) xor code(7);
	KeyboardOut <= conv_std_logic_vector(cur_key, 8);

	--读取扫描码
	process(FilterClk5M)
	begin
		if rising_edge(FilterClk5M) then
			code_ok <= '0';
			case state is
				when DELAY =>
					state <= START;
				when START =>
					if filter_KeyboardClk = '1' then
						if filter_KeyboardData = '0' then
							state <= D0;
						else
							state <= DELAY;
						end if;
					end if;
				when D0 =>
					if filter_KeyboardClk = '1' then
						code(0) <= filter_KeyboardData;
						state <= D1;
					end if;
				when D1 =>
					if filter_KeyboardClk = '1' then
						code(1) <= filter_KeyboardData;
						state <= D2;
					end if;
				when D2 =>
					if filter_KeyboardClk = '1' then
						code(2) <= filter_KeyboardData;
						state <= D3;
					end if;
				when D3 =>
					if filter_KeyboardClk = '1' then
						code(3) <= filter_KeyboardData;
						state <= D4;
					end if;
				when D4 =>
					if filter_KeyboardClk = '1' then
						code(4) <= filter_KeyboardData;
						state <= D5;
					end if;
				when D5 =>
					if filter_KeyboardClk = '1' then
						code(5) <= filter_KeyboardData;
						state <= D6;
					end if;
				when D6 =>
					if filter_KeyboardClk = '1' then
						code(6) <= filter_KeyboardData;
						state <= D7;
					end if;
				when D7 =>
					if filter_KeyboardClk = '1' then
						code(7) <= filter_KeyboardData;
						state <= PARITY;
					end if;
				when PARITY =>
					if filter_KeyboardClk = '1' then
						if (filter_KeyboardData xor code_odd) = '1' then
							state <= STOP;
						else
							state <= DELAY;
						end if;
					end if;
				when STOP => 
					if filter_KeyboardClk = '1' then
						if filter_KeyboardData = '1' then
							state <= FINISH;
						else
							state <= DELAY;
						end if;
					end if;
				when FINISH =>
					state <= DELAY;
					code_ok <= '1';
				when others =>
					state <= DELAY;
			end case;
		end if;
	end process;

	--按键状态维护
	process(code_ok)
	variable tmp_key: integer :=0;
	begin
		if rising_edge(code_ok) then
			if last_code = x"F0" then
				cur_key <= 0;
				case code is
					when x"1C" =>
						key_state(key_A) <= '0';
					when x"32" =>
						key_state(key_B) <= '0';
					when x"21" =>
						key_state(key_c) <= '0';
					when x"23" =>
						key_state(key_D) <= '0';
					when x"24" =>
						key_state(key_E) <= '0';
					when x"2B" =>
						key_state(key_F) <= '0';
					when x"34" =>
						key_state(key_G) <= '0';
					when x"33" =>
						key_state(key_H) <= '0';
					when x"43" =>
						key_state(key_I) <= '0';
					when x"3B" =>
						key_state(key_J) <= '0';
					when x"42" =>
						key_state(key_K) <= '0';
					when x"4B" =>
						key_state(key_L) <= '0';
					when x"3A" =>
						key_state(key_M) <= '0';
					when x"31" =>
						key_state(key_N) <= '0';
					when x"44" =>
						key_state(key_O) <= '0';
					when x"4D" =>
						key_state(key_P) <= '0';
					when x"15" =>
						key_state(key_Q) <= '0';
					when x"2D" =>
						key_state(key_R) <= '0';
					when x"1B" =>
						key_state(key_S) <= '0';
					when x"2C" =>
						key_state(key_T) <= '0';
					when x"3C" =>
						key_state(key_U) <= '0';
					when x"2A" =>
						key_state(key_V) <= '0';
					when x"1D" =>
						key_state(key_W) <= '0';
					when x"22" =>
						key_state(key_X) <= '0';
					when x"35" =>
						key_state(key_Y) <= '0';
					when x"1A" =>
						key_state(key_Z) <= '0';
					when x"45" =>
						key_state(key_0) <= '0';
					when x"16" =>
						key_state(key_1) <= '0';
					when x"1E" =>
						key_state(key_2) <= '0';
					when x"26" =>
						key_state(key_3) <= '0';
					when x"25" =>
						key_state(key_4) <= '0';
					when x"2E" =>
						key_state(key_5) <= '0';
					when x"36" =>
						key_state(key_6) <= '0';
					when x"3D" =>
						key_state(key_7) <= '0';
					when x"3E" =>
						key_state(key_8) <= '0';
					when x"46" =>
						key_state(key_9) <= '0';
					when x"29" =>
						key_state(key_space) <= '0';
					when x"66" =>
						key_state(key_bksp) <= '0';
					when x"5A" =>
						key_state(key_enter) <= '0';
					when x"75" =>
						key_state(key_up) <= '0';
					when x"6B" =>
						key_state(key_left) <= '0';
					when x"72" =>
						key_state(key_down) <= '0';
					when x"74" =>
						key_state(key_right) <= '0';
					when x"0E" =>
						key_state(key_point) <= '0';
					when x"4E" =>
						key_state(key_sub) <= '0';
					when x"55" =>
						key_state(key_equal) <= '0';
					when x"5D" =>
						key_state(key_bslash) <= '0';
					when x"54" =>
						key_state(key_lbracket) <= '0';
					when x"5B" =>
						key_state(key_rbracket) <= '0';
					when x"4C" =>
						key_state(key_semicolon) <= '0';
					when x"52" =>
						key_state(key_quote) <= '0';
					when x"41" =>
						key_state(key_comma) <= '0';
					when x"49" =>
						key_state(key_stop) <= '0';
					when x"4A" =>
						key_state(key_slash) <= '0';
					when x"12" =>
						key_state(key_lshft) <= '0';
					when x"59" =>
						key_state(key_rshft) <= '0';
					when others =>
				end case;
			else
				case code is
					when x"1C" =>
						tmp_key := key_A;
					when x"32" =>
						tmp_key := key_B;
					when x"21" =>
						tmp_key := key_c;
					when x"23" =>
						tmp_key := key_D;
					when x"24" =>
						tmp_key := key_E;
					when x"2B" =>
						tmp_key := key_F;
					when x"34" =>
						tmp_key := key_G;
					when x"33" =>
						tmp_key := key_H;
					when x"43" =>
						tmp_key := key_I;
					when x"3B" =>
						tmp_key := key_J;
					when x"42" =>
						tmp_key := key_K;
					when x"4B" =>
						tmp_key := key_L;
					when x"3A" =>
						tmp_key := key_M;
					when x"31" =>
						tmp_key := key_N;
					when x"44" =>
						tmp_key := key_O;
					when x"4D" =>
						tmp_key := key_P;
					when x"15" =>
						tmp_key := key_Q;
					when x"2D" =>
						tmp_key := key_R;
					when x"1B" =>
						tmp_key := key_S;
					when x"2C" =>
						tmp_key := key_T;
					when x"3C" =>
						tmp_key := key_U;
					when x"2A" =>
						tmp_key := key_V;
					when x"1D" =>
						tmp_key := key_W;
					when x"22" =>
						tmp_key := key_X;
					when x"35" =>
						tmp_key := key_Y;
					when x"1A" =>
						tmp_key := key_Z;
					when x"45" =>
						tmp_key := key_0;
					when x"16" =>
						tmp_key := key_1;
					when x"1E" =>
						tmp_key := key_2;
					when x"26" =>
						tmp_key := key_3;
					when x"25" =>
						tmp_key := key_4;
					when x"2E" =>
						tmp_key := key_5;
					when x"36" =>
						tmp_key := key_6;
					when x"3D" =>
						tmp_key := key_7;
					when x"3E" =>
						tmp_key := key_8;
					when x"46" =>
						tmp_key := key_9;
					when x"29" =>
						tmp_key := key_space;
					when x"66" =>
						tmp_key := key_bksp;
					when x"5A" =>
						tmp_key := key_enter;
					when x"75" =>
						tmp_key := key_up;
					when x"6B" =>
						tmp_key := key_left;
					when x"72" =>
						tmp_key := key_down;
					when x"74" =>
						tmp_key := key_right;
					when x"0E" =>
						tmp_key := key_point;
					when x"4E" =>
						tmp_key := key_sub;
					when x"55" =>
						tmp_key := key_equal;
					when x"5D" =>
						tmp_key := key_bslash;
					when x"54" =>
						tmp_key := key_lbracket;
					when x"5B" =>
						tmp_key := key_rbracket;
					when x"4C" =>
						tmp_key := key_semicolon;
					when x"52" =>
						tmp_key := key_quote;
					when x"41" =>
						tmp_key := key_comma;
					when x"49" =>
						tmp_key := key_stop;
					when x"4A" =>
						tmp_key := key_slash;
					when x"12" =>
						tmp_key := key_lshft;
					when x"59" =>
						tmp_key := key_rshft;
					when others =>
						tmp_key := 0;
				end case;
				if (tmp_key /= 0 and key_state(tmp_key) = '0') then
					key_state(tmp_key) <= '1';
					cur_key <= tmp_key;
				end if;
			end if;
			last_code <= code;
		end if;
	end process;
end Behavioral;
