class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_admin
  	unless current_user.admin?
  		redirect_to root_url, notice: "Unauthorized Access!"
  	end
  end
  def require_subscribed
    user = current_user
  	if user.subscribed == false
      redirect_to new_subscription_path, notice: "Please Subscribe"
    elsif user.trial_end_date < Time.now && user.stripe_subscription_id == nil
        user.subscribed = false
        user.save
        redirect_to new_subscription_path, notice: "Please Subscribe"
    else
      if current_user.stripe_subscription_active == false
        redirect_to edit_user_registration_path, notice: "Failed Transaction - Please Update Card" 
      end
    end
  end

   def require_training_subscribed
    user = current_user
    if user.training_subscribed == false
      redirect_to new_subscription_path, notice: "Please Subscribe"
    elsif user.trial_end_date < Time.now && user.stripe_subscription_id == nil
        user.training_subscribed = false
        user.save
        redirect_to new_subscription_path, notice: "Please Subscribe"
    else
      if current_user.stripe_subscription_active == false
        redirect_to edit_user_registration_path, notice: "Failed Transaction - Please Update Card" 
      end
    end
  end

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  helper_method :current_user_subscribed?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :phone_number
  end

end
