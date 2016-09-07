class CardsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_subscribed

	def update
		customer = Stripe::Customer.retrieve(current_user.stripeid)
		subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
		subscription.source = params[:stripeToken]
		subscription.save

		redirect_to edit_user_registration_path, notice: "Your Payment Information Updated Successfully"
	end
end