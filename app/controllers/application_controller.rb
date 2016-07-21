class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_admin
  	unless current_user.admin?
  		redirect_to root_url, alert: "Unauthorized access!"
  	end
  end
  def require_subscribed
  	unless current_user.subscribed?
  		redirect_to root_url, alert: "Please Subscribe"
    end
  end
end
