class RegistrationsController < Devise::RegistrationsController
before_action :require_admin, only: [:index, :destroy]
	def after_sign_up_path_for(resources)
		'/subscribers/new'
	end



end
