-- megafunction wizard: %LPM_COMPARE%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_COMPARE 

-- ============================================================
-- File Name: compare11.vhd
-- Megafunction Name(s):
-- 			LPM_COMPARE
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2013 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY compare11 IS
	PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		aeb		: OUT STD_LOGIC 
	);
END compare11;


ARCHITECTURE SYN OF compare11 IS

	SIGNAL sub_wire0	: STD_LOGIC ;
	SIGNAL sub_wire1_bv	: BIT_VECTOR (4 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (4 DOWNTO 0);



	COMPONENT lpm_compare
	GENERIC (
		lpm_hint		: STRING;
		lpm_representation		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			aeb	: OUT STD_LOGIC ;
			dataa	: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	sub_wire1_bv(4 DOWNTO 0) <= "01011";
	sub_wire1    <= To_stdlogicvector(sub_wire1_bv);
	aeb    <= sub_wire0;

	LPM_COMPARE_component : LPM_COMPARE
	GENERIC MAP (
		lpm_hint => "ONE_INPUT_IS_CONSTANT=YES",
		lpm_representation => "UNSIGNED",
		lpm_type => "LPM_COMPARE",
		lpm_width => 5
	)
	PORT MAP (
		dataa => dataa,
		datab => sub_wire1,
		aeb => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: AeqB NUMERIC "1"
-- Retrieval info: PRIVATE: AgeB NUMERIC "0"
-- Retrieval info: PRIVATE: AgtB NUMERIC "0"
-- Retrieval info: PRIVATE: AleB NUMERIC "0"
-- Retrieval info: PRIVATE: AltB NUMERIC "0"
-- Retrieval info: PRIVATE: AneB NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
-- Retrieval info: PRIVATE: Latency NUMERIC "0"
-- Retrieval info: PRIVATE: PortBValue NUMERIC "11"
-- Retrieval info: PRIVATE: Radix NUMERIC "10"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SignedCompare NUMERIC "0"
-- Retrieval info: PRIVATE: aclr NUMERIC "0"
-- Retrieval info: PRIVATE: clken NUMERIC "0"
-- Retrieval info: PRIVATE: isPortBConstant NUMERIC "1"
-- Retrieval info: PRIVATE: nBit NUMERIC "5"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_HINT STRING "ONE_INPUT_IS_CONSTANT=YES"
-- Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "UNSIGNED"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_COMPARE"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "5"
-- Retrieval info: USED_PORT: aeb 0 0 0 0 OUTPUT NODEFVAL "aeb"
-- Retrieval info: USED_PORT: dataa 0 0 5 0 INPUT NODEFVAL "dataa[4..0]"
-- Retrieval info: CONNECT: @dataa 0 0 5 0 dataa 0 0 5 0
-- Retrieval info: CONNECT: @datab 0 0 5 0 11 0 0 5 0
-- Retrieval info: CONNECT: aeb 0 0 0 0 @aeb 0 0 0 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare11.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare11.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare11.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare11.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL compare11_inst.vhd TRUE
-- Retrieval info: LIB_FILE: lpm
