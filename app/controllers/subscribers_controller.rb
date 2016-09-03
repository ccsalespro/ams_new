class SubscribersController < ApplicationController

	before_filter :authenticate_user!
	
	def new
	end

	def update
		token = params[:stripeToken]
		customer = Stripe::Customer.create(
			card: token,
			plan: 1030,
			email: current_user.email
			)
		current_user.subscribed = true
		current_user.training_subscribed = true
		current_user.paid = true
		current_user.stripeid = customer.id
		current_user.save

		redirect_to prospects_path
	end
end
