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
        redirect_to new_subscription_path
      elsif user.stripe_subscription_id != nil && user.stripe_subscription_active == false
          redirect_to edit_user_registration_path, notice: "Failed Transaction - Please Update Card" 
      end
  end

   def require_training_subscribed
    require_subscribed
    if current_user.subscribed == true 
      current_user.training_subscribed = true 
    else
      current_user.training_subscribed = false
    end
    current_user.save 
  end

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  helper_method :current_user_subscribed?

  def require_team_edit(team)
    @team = team
    @team_user = TeamUser.where(user_id: current_user.id).where(team_id: @team.id).first

    case @team.team_type.description
      when "Processor"
        unless @team_user.team_user_role.name == "Employee"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "ISO"
        unless @team_user.team_user_role.name == "Owner"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "Affiliate"
        unless @team_user.team_user_role.name == "Reseller"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "Recruiter"
        unless @team_user.team_user_role.name == "Recruiter"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "Admin"
        unless @team_user.team_user_role.name == "Admin"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
    end 
  end
  helper_method :require_team_edit

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :phone_number
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :phone_number
    devise_parameter_sanitizer.for(:account_update) << :avatar
  end

end
