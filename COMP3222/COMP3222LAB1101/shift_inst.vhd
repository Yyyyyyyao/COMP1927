shift_inst : shift PORT MAP (
		clock	 => clock_sig,
		data	 => data_sig,
		enable	 => enable_sig,
		load	 => load_sig,
		sclr	 => sclr_sig,
		shiftout	 => shiftout_sig
	);
