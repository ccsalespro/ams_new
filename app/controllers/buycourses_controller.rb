class BuycoursesController < ApplicationController
    before_filter :authenticate_user!


  # GET /buycourses/new
  def new
  end

  def update
    token = params[:stripeToken]
    customer = Stripe::Customer.create(
      card: token,
      plan: 22,
      email: current_user.email
      )
    current_user.training_subscribed = true
    current_user.stripeid = customer.id
    current_user.save

    redirect_to prospects_path
  end
    
end
