class VmdPercent < Assumption
	def calculate
	@statement.vs_percent = ( ( @statement.vs_volume / @statement.vmd_vol) * 100 )
    @statement.vs_percent = @statement.vs_percent

    @statement.mc_percent = ( ( @statement.mc_volume / @statement.vmd_vol) * 100 )
    @statement.mc_percent = @statement.mc_percent

    @statement.ds_percent = ( ( @statement.ds_volume / @statement.vmd_vol) * 100 )
    @statement.ds_percent = @statement.ds_percent
	end
end