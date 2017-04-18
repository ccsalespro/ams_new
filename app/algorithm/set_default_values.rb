class SetDefaultValues
	def initialize(statement)
		@statement = statement
	end

	def calculate

	    @statement.batches = 30
    	@statement.c_vmd_interchange = @statement.vmd_interchange
    	@statement.form_vmd_interchange = @statement.vmd_interchange
    	@statement.current_interchange = @statement.vmd_interchange
    	@statement.c_check_card_access_per_item = 0.0155
    	@statement.c_check_card_access_percentage = 11
    	@statement.c_visa_access_per_item = 0.0195
    	@statement.c_visa_access_percentage = 13
    	@statement.c_mc_access_per_item = 0.0185
    	@statement.c_mc_access_percentage = 12
    	@statement.c_disc_access_per_item = 0.0195
    	@statement.c_disc_access_percentage = 13
    	@statement.c_opt_blue_fees = @statement.amex_interchange
    	@statement.c_network_access_fees = @statement.debit_network_fees

    	if @statement.total_fees.nil?
	        @statement.total_fees = 0
	    end

	    if @statement.c_vmd_per_item_fee.nil?
	    	@statement.c_vmd_per_item_fee = 0
	    end

	    if @statement.c_vmd_bp_mark_up.nil?
	    	@statement.c_vmd_bp_mark_up = 0
	    end

		if @statement.vs_per_item_fee.nil?
			@statement.vs_per_item_fee = @statement.c_vmd_per_item_fee
		end

		if @statement.mc_per_item_fee.nil?
			@statement.mc_per_item_fee = @statement.c_vmd_per_item_fee
		end

		if @statement.ds_per_item_fee.nil?
			@statement.ds_per_item_fee = @statement.c_vmd_per_item_fee
		end

		if @statement.vs_bp_mark_up.nil?
			@statement.vs_bp_mark_up = @statement.c_vmd_bp_mark_up
		end

		if @statement.mc_bp_mark_up.nil?
			@statement.mc_bp_mark_up = @statement.c_vmd_bp_mark_up
		end

		if @statement.ds_bp_mark_up.nil?
			@statement.ds_bp_mark_up = @statement.c_vmd_bp_mark_up
		end

		if @statement.vs_avg_ticket.nil?
			@statement.vs_avg_ticket = @statement.vmd_avg_ticket
		end

		if @statement.mc_avg_ticket.nil?
			@statement.mc_avg_ticket = @statement.vmd_avg_ticket
		end

		if @statement.ds_avg_ticket.nil?
			@statement.ds_avg_ticket = @statement.vmd_avg_ticket
		end

		if @statement.c_amex_per_item_fee.nil?
			@statement.c_amex_per_item_fee = 0
		end

		if @statement.c_debit_per_item_fee.nil?
			@statement.c_debit_per_item_fee = 0
		end

		if @statement.c_amex_bp_mark_up.nil?
			@statement.c_amex_bp_mark_up = 0
		end

		if @statement.c_debit_bp_mark_up.nil?
			@statement.c_debit_bp_mark_up = 0
		end
	end
end