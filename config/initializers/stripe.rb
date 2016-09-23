Stripe.api_key = STRIPE_SECRET

class RecordCharges
	def call(event)
		charge = event.data.object

		user = User.find_by(stripeid: charge.customer)
		user.charges.create(
			stripeid: charge.id,
			amount: charge.amount,
			card_last4: charge.source.last4,
			card_exp_month: charge.source.exp_month,
			card_exp_year: charge.source.exp_year,
			card_type: charge.source.brand
		)		
	end
end

StripeEvent.configure do |events|
  events.subscribe 'charge.failed', RecordCharges.new
  events.subscribe 'charge.succeeded', RecordCharges.new
end