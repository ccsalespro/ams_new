class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_signup, only: [:new]
  def show
  end

  def new
    if current_user.subscribed == true
      redirect_to prospects_path
    end
  end

  def create
    customer =  if current_user.stripeid?
                  Stripe::Customer.retrieve(current_user.stripeid)
                else
                  Stripe::Customer.create(email: current_user.email)
                end
        
    subscription = customer.subscriptions.create(
        source: params[:stripeToken],
        plan: "1030"
      )

    current_user.update(
        stripeid: customer.id,
        stripe_subscription_id: subscription.id,
        subscribed: true,
        training_subscribed: true,
      )

    redirect_to root_path
  end

  def update
    customer = Stripe::Customer.retrieve(current_user.stripeid)
    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.source = params[:stripeToken]
    subscription.save

    redirect_to edit_user_registration_path, notice: "Your Payment Information Updated Successfully"


  end
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripeid)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(
      stripe_subscription_id: nil,
      subscribed: false,
      training_subscribed: false
    )

    redirect_to root_path, notice: "Your subscription has been canceled."
  end

  private
  def redirect_to_signup
    if !user_signed_in?
      session["user_return_to"] = new_subscription_path
      redirect_to new_user_registration_path
    end
  end
end