class Algorithm
  # Accept the statement object
  def initialize(statement, prospect)
    @statement = statement
    @prospect = prospect
  end

  def calculate
    # Set Up American Express if AMEX Volume is higher than 0
    @american_express = AmericanExpress.new(@statement, @prospect)
    @american_express.calculate

    # Set Up Pin Debit if Pin Debit Volume is higher than 0
    @pin_debit = PinDebit.new(@statement)
    @pin_debit.calculate

    # Set average ticket for VMD, AMEX and Pin Debit
    # Set the default number of batches to 30

    @average_ticket = AverageTicket.new(@statement)
    @average_ticket.calculate

    # Set Up Visa, Mastercard Discover if Volume is higher than 0
    @vmd = VisaMastercardDiscover.new(@statement, @prospect)
    @inttableitems = @vmd.calculate

    @set_default_values = SetDefaultValues.new(@statement)
    @set_default_values.calculate 

    return @inttableitems
  end
end
	