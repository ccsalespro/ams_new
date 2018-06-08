class DetailPdf < Prawn::Document

	def initialize(prospect, statement, comparison, view, user)
		super(top_margin: 50)
		@prospect = prospect
		@statement = statement
		@comparison = comparison
		@program = Program.find_by_id(@comparison.program_id)
		@view = view
		@user = user
		image "#{Rails.root}/app/assets/images/williams_transparent.png", :height => 90
		company_info
		if @user
			prospect_name
			user_labels
		end
		proposal_note
		if @statement.total_fees > 0
			savings_amounts_table
		end
		card_type_title
		card_types_table
		individual_costs_title
		individual_cost_table
		individual_fields_table
		one_time_fees_table
	end

	def proposal_note
		move_down 20
		text "#{@comparison.notes}", size: 13, style: :italic, align: :left
	end

	def last_title
		move_down 10
		text "#{@one_time_cursor_possition} - #{@total_one_time_table_height}"
	end

	def company_info
		move_down 10
		text "Phone:  (919) 556-3616", size: 15, style: :bold, align: :left
		text "williamspaymentsolutions.com", size: 15, style: :bold, align: :left
	end

	def card_type_title
		move_down 30
		text "Card Type Summary", size: 16, style: :bold, align: :center
	end

	def individual_costs_title
		move_down 30
		text "Itemized Costs", size: 16, style: :bold, align: :center
	end

	def other_fees_title
		text "Other Fees", size: 16, style: :bold, align: :center
	end

	def one_time_title
		text "One Time Fees", size: 16, style: :bold, align: :center
	end

	def one_time_fees_table
		if @annual_fee_fields.empty? == false || @one_time_fields.empty? == false || @comparison.annual_pci_fees > 0
		@one_time_table_row_height = font.ascender - font.descender + font.line_gap
		@one_time_table_height = @one_time_table_row_height * (one_time_field_rows.count)
		@total_one_time_table_height = @one_time_table_height + 5 + 10 + 10
		@one_time_cursor_possition = cursor
		if cursor - @total_one_time_table_height < 0
			start_new_page
		end
			one_time_title
			move_down 5
			table one_time_field_rows do
				row(0..30).border_width = 0.3
				row(0).font_style = :bold
				columns(0..4).align = :left
				row(0).align = :center
				columns(0).width = 135
				columns(1).width = 180
				columns(2).width = 75
				columns(3).width = 60
				columns(4).width = 65
				self.row_colors = ["f2f2f2", "FFFFFF"]
				self.header = true
				self.row(0).background_color = '1B427D'
				self.row(0).text_color = 'FFFFFF'
				self.position = :center
			end
		end
	end

	def one_time_field_header
		["Description", "Type", "Qty", "Cost", "Amount"]
	end

	def individual_fields_table
		@field_table_row_height = font.ascender - font.descender + font.line_gap
		@field_table_height = @field_table_row_height * (field_rows.count + 1)
		@total_table_height = @field_table_height + 20 + 5 + 10 + 20
		@cursor_possition = cursor
		if cursor - @total_table_height < 0
			start_new_page
		end
		other_fees_title
		move_down 5
		table field_rows do
			row(0..30).border_width = 0.3
			row(0).font_style = :bold
			columns(0..4).align = :left
			row(0).align = :center
			columns(0).width = 135
			columns(1).width = 180
			columns(2).width = 75
			columns(3).width = 60
			columns(4).width = 65
			self.row_colors = ["f2f2f2", "FFFFFF"]
			self.header = true
			self.row(0).background_color = '1B427D'
			self.row(0).text_color = 'FFFFFF'
			self.position = :center
		end
		move_down 30
	end

	def individual_field_header
		["Description", "Type", "Qty", "Cost", "Amount"]
	end

	def statement_fee_row
		["Statement Fee", "Monthly Fee", "1", to_currency(@comparison.monthly_fees), to_currency(@comparison.monthly_fees)]
	end

	def monthly_pci_fee_row
		["PCI Fee", "Monthly Fee", "1", to_currency(@comparison.monthly_pci_fees), to_currency(@comparison.monthly_pci_fees)]
	end

	def monthly_debit_fee_row
		["Debit Fee", "Monthly Fee", "1", to_currency(@comparison.monthly_debit_fee), to_currency(@comparison.monthly_debit_fee)]
	end

	def annual_fee_row
		["Annual Fee", "Annual Fee", "1", to_currency(@comparison.annual_pci_fee), to_currency(@comparison.annual_pci_fee)]
	end

	def application_fee_row
		["Application Fee", "One Time Fee", "1", to_currency(@comparison.application_fee), to_currency(@comparison.application_fee)]
	end

	def batch_fee_row
		["Settlement Fee", "Per Batch Fee", to_integer(@statement.batches), to_currency(@comparison.per_batch_fee), to_currency(@comparison.batch_fees)]
	end

	def custom_monthly_fee_rows
		if @monthly_fee_fields != nil
		@monthly_fee_array = []
			@monthly_fee_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << "1"
				@array << to_currency(fee.amount)
				@array << to_currency(fee.amount)
				@monthly_fee_array << @array
			end
		@monthly_fee_array
		end
	end

	def custom_annual_fee_rows
		if @annual_fee_fields != nil
		@annual_fee_array = []
			@annual_fee_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << "1"
				@array << to_currency(fee.amount)
				@array << to_currency(fee.amount)
				@annual_fee_array << @array
			end
		@annual_fee_array
		end
	end

	def custom_one_time_fee_rows
		if @one_time_fields != nil
		@one_time_array = []
			@one_time_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << "1"
				@array << to_currency(fee.amount)
				@array << to_currency(fee.amount)
				@one_time_array << @array
			end
		@one_time_array
		end
	end

	def custom_vmd_per_item_rows
		if @vmd_per_item_fields != nil
		@build_array = []
			@vmd_per_item_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << to_integer(@statement.vmd_trans)
				@array << to_currency(fee.amount)
				@array << to_currency(@statement.vmd_trans * fee.amount)
				@build_array << @array
			end
		@build_array
		end
	end

	def custom_vmd_vol_bp_rows
		if @vmd_vol_bp_fields != nil
		@build_array = []
			@vmd_vol_bp_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << to_currency(@statement.vmd_vol)
				@array << "#{to_integer(fee.amount)} BP"
				@array << to_currency(@statement.vmd_vol * (fee.amount.to_f / 10000))
				@build_array << @array
			end
		@build_array
		end
	end

	def custom_amex_per_item_rows
		if @amex_per_item_fields != nil
		@build_array = []
			@amex_per_item_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << to_integer(@statement.amex_trans)
				@array << to_currency(fee.amount)
				@array << to_currency(@statement.amex_trans * fee.amount)
				@build_array << @array
			end
		@build_array
		end
	end

	def custom_amex_vol_bp_rows
		if @amex_vol_bp_fields != nil
		@build_array = []
			@amex_vol_bp_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << to_currency(@statement.amex_vol)
				@array << "#{to_integer(fee.amount)} BP"
				@array << to_currency(@statement.amex_vol * (fee.amount.to_f / 10000))
				@build_array << @array
			end
		@build_array
		end
	end

	def custom_debit_per_item_rows
		if @debit_per_item_fields != nil
		@build_array = []
			@debit_per_item_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << to_integer(@statement.debit_trans)
				@array << to_currency(fee.amount)
				@array << to_currency(@statement.debit_trans * fee.amount)
				@build_array << @array
			end
		@build_array
		end
	end

	def custom_debit_vol_bp_rows
		if @debit_vol_bp_fields != nil
		@build_array = []
			@debit_vol_bp_fields.each do |fee|
				@array = []
				@array << fee.name
				@array << "#{fee.custom_field_type.name}"
				@array << to_currency(@statement.debit_vol)
				@array << "#{to_integer(fee.amount)} BP"
				@array << to_currency(@statement.debit_vol * (fee.amount.to_f / 10000))
				@build_array << @array
			end
		@build_array
		end
	end

	def one_time_field_rows
		custom_field_arrays
		@field_rows = []
		@field_rows << one_time_field_header
		if @one_time_fields != nil
			@field_rows += custom_one_time_fee_rows
		end
		if @comparison.annual_pci_fee > 0
			@field_rows << annual_fee_row
		end
		if @annual_fee_fields != nil
			@field_rows += custom_annual_fee_rows
		end
		if @comparison.application_fee > 0
			@field_rows << application_fee_row
		end

		return @field_rows
	end

	def field_rows
		custom_field_arrays
		@field_rows = []
		@field_rows << individual_field_header
		if @comparison.monthly_fees > 0
			@field_rows << statement_fee_row
		end
		if @comparison.monthly_pci_fee > 0
			@field_rows << monthly_pci_fee_row
		end
		if @statement.debit_vol > 0 && @comparison.monthly_debit_fee > 0
			@field_rows << monthly_debit_fee_row
		end
		if @monthly_fee_fields != nil
			@field_rows += custom_monthly_fee_rows
		end
		if @vmd_per_item_fields != nil
			@field_rows += custom_vmd_per_item_rows
		end
		if @vmd_vol_bp_fields != nil
			@field_rows += custom_vmd_vol_bp_rows
		end
		if @amex_per_item_fields != nil
			@field_rows += custom_amex_per_item_rows
		end
		if @amex_vol_bp_fields != nil
			@field_rows += custom_amex_vol_bp_rows
		end
		if @debit_per_item_fields != nil
			@field_rows += custom_debit_per_item_rows
		end
		if @debit_vol_bp_fields != nil
			@field_rows += custom_debit_vol_bp_rows
		end
		if @statement.batches > 0
			@field_rows << batch_fee_row
		end

		return @field_rows
	end

	def custom_field_arrays
		@monthly_fee_fields = []
		@annual_fee_fields = []
		@one_time_fields = []
		@vmd_per_item_fields = []
		@vmd_vol_bp_fields = []
		@amex_per_item_fields = []
		@amex_vol_bp_fields = []
		@debit_per_item_fields = []
		@debit_vol_bp_fields = []
		@custom_fields = @comparison.cc_fields
		@custom_fields.each do |cf|
			case cf.custom_field_type.slug_string
				when "monthly_fee"
					@monthly_fee_fields << cf
				when "annual_fee"
					@annual_fee_fields << cf
				when "one_time_fee"
					@one_time_fields << cf
				when "vmd_per_item"
					@vmd_per_item_fields << cf
				when "vmd_volume_bp"
					@vmd_vol_bp_fields << cf
				when "amex_per_item"
					@amex_per_item_fields << cf
				when "amex_volume_bp"
					@amex_vol_bp_fields << cf
				when "pin_per_item"
					@debit_per_item_fields << cf
				when "pin_volume_bp"
					@debit_vol_bp_fields << cf
			end
	  	end
	end

	def card_types_table
		move_down 5
		table card_type_rows do
			row(0..6).border_width = 0.3
			row(0).font_style = :bold
			row(-1).font_style = :bold
			columns(0..3).align = :left
			row(0).align = :center
			columns(0).width = 85
			columns(1).width = 100
			columns(2).width = 70
			columns(3).width = 90
			columns(4).width = 90
			columns(5).width = 80
			self.row_colors = ["f2f2f2", "FFFFFF"]
			self.header = true
			self.row(0).background_color = '1B427D'
			self.row(0).text_color = 'FFFFFF'
			self.position = :center
		end
	end

	def card_type_rows
		total_vs_fees
		total_mc_fees
		total_ds_fees
		total_amex_fees
		total_debit_fees
		total_transactions
		total_program_costs
		total_access_fees
		other_fees_total
		total_processing_fees

	rows = card_type_header + card_type_vmd_rows
	rows += card_type_amex_row if @statement.amex_vol > 0.01
	rows += card_type_debit_row if @statement.debit_vol > 0.01
	rows += other_fees_row if @other_fees > 0.01
	rows += service_fees_row if @comparison.service_fees > 0.01
	rows += card_type_totals
	rows


	end

	def card_type_header
		[["Type", "Volume", "Items", "Passthrough", "Processing", "Fees"]]
	end

	def card_type_vmd_rows
		[["VS", to_currency(@statement.vs_volume), to_integer(@statement.vs_transactions), to_currency(@comparison.vs_fees + @comparison.total_vs_access_fees), to_currency(@comparison.vs_trans_fees + @comparison.vs_mark_up_fees), to_currency(@total_visa_fees)],
		["MC", to_currency(@statement.mc_volume), to_integer(@statement.mc_transactions), to_currency(@comparison.mc_fees + @comparison.total_mc_access_fees), to_currency(@comparison.mc_trans_fees + @comparison.mc_mark_up_fees), to_currency(@total_mc_fees)],
		["DS", to_currency(@statement.ds_volume), to_integer(@statement.ds_transactions), to_currency(@comparison.ds_fees + @comparison.total_ds_access_fees), to_currency(@comparison.ds_trans_fees + @comparison.ds_mark_up_fees), to_currency(@total_ds_fees)]]
	end

	def card_type_totals
		[["Totals", to_currency(@statement.total_vol), to_integer(@transactions), to_currency(@total_cost), to_currency(@total_processing_fees), to_currency(@comparison.total_program_fees - @comparison.service_fees)]]
	end

	def card_type_debit_row
		[["Debit", to_currency(@statement.debit_vol), to_integer(@statement.debit_trans), to_currency(@comparison.debit_network_fees), to_currency(@comparison.debit_bp_mark_up_fees + (@statement.debit_trans * @comparison.pin_debit_per_item_fee)), to_currency(@total_debit_fees)]]
	end

	def card_type_amex_row
		[["Amex", to_currency(@statement.amex_vol), to_integer(@statement.amex_trans), to_currency(@comparison.amex_interchange), to_currency(@comparison.amex_mark_up_fees + @comparison.amex_trans_fees), to_currency(@total_amex_fees)]]
	end

	def other_fees_row
			[["Other Fees", "-", "-", "-", to_currency(@other_fees), to_currency(@other_fees)]]
	end

	def service_fees_row
		[["#{@comparison.service_fee / 100}% Fee", to_currency(@statement.total_vol), "-", "-", "(#{to_currency(@comparison.service_fees)})", "(#{to_currency(@comparison.service_fees)})"]]
	end

	def other_fees_total
    	@other_fees = ( @comparison.total_program_fees - (@total_amex_fees + @total_debit_fees + @total_visa_fees + @total_mc_fees + @total_ds_fees))
    end

	def savings_amounts_table
		move_down 20
		table savings_row do
			row(0..1).border_width = 0.3
			row(0).font_style = :bold
			row(1).font_style = :bold
			columns(0..1).align = :left
			row(0).align = :center
			columns(0..3).width = 171.666
			self.header = true
			self.row(0).background_color = '1B427D'
			self.row(0).text_color = 'FFFFFF'
			self.position = :center

		end
	end

	def individual_cost_table
		move_down 5
		table individual_cost_rows do
			row(0..6).border_width = 0.3
			row(0).font_style = :bold
			columns(0..3).align = :left
			row(0).align = :center
			columns(0).width = 130
			columns(1).width = 80
			columns(2).width = 50
			columns(3..5).width = 85
			self.row_colors = ["f2f2f2", "FFFFFF"]
			self.header = true
			self.row(0).background_color = '1B427D'
			self.row(0).text_color = 'FFFFFF'
			self.position = :center
		end
		move_down 30
		@cursor_possition = cursor
	end

	def individual_cost_rows
		total_vs_fees
		total_mc_fees
		total_ds_fees
		total_amex_fees
		total_debit_fees
		total_transactions
		total_program_costs
		total_access_fees

		rows = individual_cost_header + vmd_fees_row
		rows += vmd_costs_row if @program.pricing_structure.interchange
		rows += amex_fees_row if @statement.amex_vol > 0.01
		rows += amex_costs_row if @statement.amex_vol > 0.01 && @program.pricing_structure.interchange
		rows += debit_fees_row if @statement.debit_vol > 0.01
		rows += debit_costs_row if @statement.debit_vol > 0.01 && @program.pricing_structure.interchange
		rows
	end

	def prospect_name
		move_up 80
		if @prospect.business_name.length < 17
			text "Proposal: #{@prospect.business_name}", size: 20, style: :bold, align: :right
			move_down 5
		else
			move_down 28
		end

	end

	def user_labels
		text "Contact: #{@user.first_name} #{@user.last_name}", size: 12, style: :bold, align: :right
		move_down 4
		text "Phone: #{@user.phone_number}", size: 12, style: :bold, align: :right
		move_down 4
		text "Email: #{@user.email}", size: 12, style: :bold, align: :right
		move_down 0
	end

	def savings_row
		[["Monthly Savings", "Annual Savings", "3 Year Savings"],
		[to_currency(@comparison.total_program_savings), to_currency(@comparison.total_program_savings * 12), to_currency(@comparison.total_program_savings * 36)]]
	end

	def individual_cost_header
		[["Description", "Volume", "Qty", "Per Item", "Percent", "Amount"]]
	end

	def vmd_fees_row
		[["VMD Fees", to_currency(@statement.vmd_vol), to_integer(@statement.vmd_trans), to_currency(@comparison.per_item_fee), to_percent_two(@comparison.bp_mark_up.to_f / 100), to_currency(@comparison.total_vmd_trans_fees + @comparison.total_vmd_mark_up_fees)]]
	end

	def vmd_costs_row
		[["VMD Interchange", to_currency(@statement.vmd_vol), to_integer(@statement.vmd_trans), "Varies", "Varies", to_currency(@statement.vmd_interchange)]]
	end

	def amex_fees_row
		[["Amex Fees", to_currency(@statement.amex_vol), to_integer(@statement.amex_trans), to_currency(@comparison.amex_per_item_fee), to_percent_two(@comparison.amex_bp_mark_up.to_f / 100), to_currency(@amex_mark_up)]]
	end

	def amex_costs_row
		[["Amex Opt Blue", to_currency(@statement.amex_vol), to_integer(@statement.amex_trans), to_currency(@comparison.amex_per_item_cost), to_percent_two(@comparison.amex_percentage_cost), to_currency(@comparison.amex_total_opt_blue)]]
	end

	def debit_fees_row
		[["Debit Fees", to_currency(@statement.debit_vol), to_integer(@statement.debit_trans), to_currency(@comparison.pin_debit_per_item_fee), to_percent_two(@comparison.debit_bp_mark_up / 100), to_currency((@comparison.pin_debit_per_item_fee * @statement.debit_trans) + @comparison.debit_bp_mark_up_fees)]]
	end

	def debit_costs_row
		[["Debit Network Fees", to_currency(@statement.debit_vol), to_integer(@statement.debit_trans), "Varies", "Varies", to_currency(@statement.debit_network_fees)]]
	end

	def interchange
		move_down 20
		table interchange_items
	end

	def interchange_items
		@interchange_items = Inttableitems.where(statement_id: @statement.id)
		[["Description", "Volume", "Savings"]]
	end

	def to_currency(var)
		@view.number_to_currency(var)
	end

	def to_integer(var)
		@view.number_with_precision(var, precision: 0)
	end

	def to_percent_two(var)
		"#{@view.number_with_precision(var, precision: 2)}%"
	end

    def total_transactions
    	@transactions = @statement.vs_transactions + @statement.mc_transactions + @statement.ds_transactions + @statement.amex_trans + @statement.debit_trans
    end

	def total_vs_fees
		@vs_access_fees = (@comparison.vs_access_per_item_fees) + (@comparison.vs_access_percentage_fees)
  	@total_visa_fees = (@comparison.vs_fees + @comparison.vs_trans_fees + @vs_access_fees + @comparison.vs_mark_up_fees)
	end

	def total_mc_fees
		@mc_access_fees = (@comparison.mc_access_per_item_fees) + (@comparison.mc_access_percentage_fees)
  	@total_mc_fees = (@comparison.mc_fees + @comparison.mc_trans_fees + @mc_access_fees + @comparison.mc_mark_up_fees)
	end

	def total_ds_fees
		@ds_access_fees = (@comparison.ds_access_per_item_fees) + (@comparison.ds_access_percentage_fees)
  	@total_ds_fees = (@comparison.ds_fees + @comparison.ds_trans_fees + @ds_access_fees + @comparison.ds_mark_up_fees)
	end

	def total_amex_fees
		@amex_mark_up = ( @statement.amex_vol * (@comparison.amex_bp_mark_up.to_f / 10000 )) + (@statement.amex_trans * @comparison.amex_per_item_fee)
		@total_amex_fees = (@comparison.amex_interchange + @amex_mark_up)
	end

	def total_debit_fees
		@total_debit_fees = (@comparison.debit_network_fees + (@statement.debit_trans * @comparison.pin_debit_per_item_fee) + @comparison.debit_bp_mark_up_fees)
	end

	def total_program_costs
		@total_cost = @comparison.vs_fees + @comparison.mc_fees + @comparison.ds_fees + @comparison.debit_network_fees + @comparison.amex_interchange + @comparison.total_vs_access_fees + @comparison.total_mc_access_fees + @comparison.total_ds_access_fees
	end

	def total_access_fees
		@total_access_fees = @comparison.total_vs_access_fees + @comparison.total_mc_access_fees + @comparison.total_ds_access_fees
	end

	def total_processing_fees
		@total_processing_fees = ( @statement.vmd_trans * @comparison.per_item_fee ) + (@statement.vmd_vol * ( @comparison.bp_mark_up.to_f / 10000) ) + @comparison.debit_trans_fees + @comparison.debit_bp_mark_up_fees + @comparison.amex_trans_fees + @comparison.amex_mark_up_fees - @comparison.service_fees + @other_fees
	end

end
