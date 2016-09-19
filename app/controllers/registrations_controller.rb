class RegistrationsController < Devise::RegistrationsController
before_action :require_admin, only: [:index]
	def after_sign_up_path_for(resources)
		'/prospects'
	end



end
