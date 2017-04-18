class UpdateAlgorithm
  # Accept the statement object
  def initialize(statement, prospect)
    @statement = statement
    @prospect = prospect
  end

  def calculate
    # Set Up American Express if AMEX Volume is higher than 0
    @american_express = AmericanExpress.new(@statement, @prospect)
    @american_express.update

    # Set Up Pin Debit if Pin Debit Volume is higher than 0
    @pin_debit = PinDebit.new(@statement)
    @pin_debit.update

    #Check if this is an old statement and set the current interchange field
    if @statement.c_vmd_interchange == nil
      @statement.c_vmd_interchange = @statement.vmd_interchange
    end
    #Check to see if the Interchange was adjusted on the form.
    #If it wasn't adjusted, continue with the standard process.
    if @statement.form_vmd_interchange.round(2) == @statement.vmd_interchange.round(2)

      # Set Up Visa, Mastercard Discover if Volume is higher than 0
      @vmd = VisaMastercardDiscover.new(@statement, @prospect)
      @vmd.update

      # Set the total cost pass through for VMD, AMEX and Pin Debit.
      @statement.interchange = @statement.vmd_interchange + @statement.amex_interchange + @statement.debit_network_fees

    #If the interchange was adjusted, change assumptions before running.
    else
      @interchange_change = @statement.vmd_interchange - @statement.form_vmd_interchange
      if @interchange_change > 0
        if @statement.avg_ticket > 4.99
          @rewards_diff = @statement.rewards_er - @statement.basic_er
          @statement.rewards_percent = ( (@statement.rewards_volume + (@interchange_change / @rewards_diff)) / @statement.vmd_vol ) * 100
          @statement.basic_percent = 100 - @statement.rewards_percent - @statement.downgrade_percentage - @statement.btob_percentage
          @algorithm = CardTypeAlgorithm.new(@statement)
          @algorithm.calculate 
        elsif @statement.avg_ticket < 5
          @check_card_diff = @statement.regulated_er - @statement.unregulated_er
          @statement.check_card_percentage = ( (@statement.check_card_vol + (@interchange_change / @check_card_diff)) / @statement.vmd_vol ) * 100
          @statement.unreg_debit_percentage = 100 - @statement.check_card_percentage - @statement.credit_percent
          @algorithm = CheckCardAlgorithm.new(@statement)
          @algorithm.calculate 
        end
      else


      end
    end
    
      # Make sure total fees save as zero and not nil if they don't exist.
      if @statement.total_fees == nil
          @statement.total_fees = 0
      end

    # Set the total number of batches to 30 by default.
    @statement.batches = 30
  end
end