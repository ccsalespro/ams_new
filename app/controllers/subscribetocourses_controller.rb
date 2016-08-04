class SubscribetocoursesController < ApplicationController
  before_action :set_subscribetocourse, only: [:show, :edit, :update, :destroy]

  def new
  end

  def create
    token = params[:stripeToken]
      Stripe.api_key = "sk_test_ZnRymlshHgxHQZch8e8tW2KC"
      customer = Stripe::Customer.create(
        card: token,
        plan: 22,
        email: current_user.email
        )
      current_user.training_subscribed = true
      current_user.stripeid = customer.id
      current_user.save

      redirect_to courses_path

      @courseuser = Courseuser.new
      @courseuser.user_id = current_user.id
      @courseuser.save

      @chapteruser = Chapteruser.new
      @chapteruser.user_id = current_user.id
      @chapteruser.save

      @lessonuser = Lessonuser.new
      @lessonuser.user_id = current_user.id
      @lessonuser.save
  end
end
