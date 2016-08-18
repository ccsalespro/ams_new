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
  	unless current_user.subscribed?
  		redirect_to root_url, notice: "Please Subscribe"
    end
  end

   def require_training_subscribed
    unless current_user.training_subscribed?
      redirect_to root_url, notice: "Please Subscribe"
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
  end

end
