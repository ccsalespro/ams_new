class Downgrade < Assumption
	def calculate
      # Start by setting the volume for downgrades to zero.
      @downgrade_volume = 0
      @downgrade_costs = 0
      @vs_volume = 0
      @mc_volume = 0
      @ds_volume = 0

      # Iterate through all interchange types and find the downgrades.
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.downgrade == true 

          # Once an downgrade interchange type is found, add that to the total downgrade volume.
          @downgrade_volume += item.volume
          @downgrade_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end

      # Set the total downgrade volume.
      @statement.downgrade_vol = @downgrade_volume

      # Set the percentage of total visa, mastercard, discover volume that is currently downgraded.
      @statement.downgrade_percentage = ( ( @downgrade_volume / @statement.vmd_vol ) * 100 )
      @statement.downgrade_percentage = @statement.downgrade_percentage
      @statement.downgrade_er = @downgrade_costs / @downgrade_volume
      
      if @downgrade_volume.nonzero?
        @statement.vs_downgrade_percentage = @vs_volume / @downgrade_volume
        @statement.mc_downgrade_percentage = @mc_volume / @downgrade_volume
        @statement.ds_downgrade_percentage = @ds_volume / @downgrade_volume
      else
        @statement.vs_downgrade_percentage = 0
        @statement.mc_downgrade_percentage = 0
        @statement.ds_downgrade_percentage = 0
      end

      @statement.vs_downgrade_volume = @vs_volume
      @statement.mc_downgrade_volume = @mc_volume
      @statement.ds_downgrade_volume = @ds_volume
	end

  def update
    # Set the total assumption volume based on the form.
    @statement.downgrade_vol = ( @statement.vmd_vol * ( @statement.form_percentage / 100) )
    
    # Set the dollar change in assumption volume based on the assumption volume before the form was updated.
    @change = @statement.downgrade_vol - @statement.form_volume

    # Set the dollar change in the non-assumption volume.
    @non_downgrade_change = (@statement.vmd_vol - @statement.downgrade_vol) - (@statement.vmd_vol - @statement.form_volume)
    
    # Set the percentage increase or decrease in assumption volume.        
    @downgrade_percentage_change = ( @change / @statement.form_volume )

    # Set the percentage increase or decrease in non-assumption volume.
    @non_downgrade_percentage_change = ( @non_downgrade_change / (@statement.vmd_vol - @statement.form_volume))
    
    # Loop through the existing interchange table items and find the associated interchange type.
    @inttableitems.each do |item|
      @inttype = Inttype.find_by_id(item.inttype_id)

      # If the inttype associate with the interchange table item is the same as the assumption.
      if @inttype.downgrade == true

        # Change the assumption volume based on the assumption change percentage.
        item.volume += ( item.volume * @downgrade_percentage_change )

        # Set the assumption transactions based on the new volume and original average ticket.
        item.transactions = item.volume / item.avg_ticket
        item.costs = ((item.volume * @inttype.percent ) + (item.transactions * @inttype.per_item))
      
      # If the inttype associated with the interchange table item is not the same as the assumption.
      else

         # Adjust the volume based on the percentage change in non-assumption volume.
         item.volume += ( item.volume * @non_downgrade_percentage_change )
         
         # Set the interchange table transacgions based on the new volume and original average ticket.
         item.transactions = item.volume / item.avg_ticket

         # Set the total interchange cost for this adjusted interchange table item.
         item.costs = ((item.volume * @inttype.percent) + (item.transactions * @inttype.per_item))
      end
    end

    return @inttableitems

  end
end