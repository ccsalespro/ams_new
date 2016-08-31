class AdminMailer < ApplicationMailer
	default to: "benshirey89@gmail.com"

	def new_user(user)
		@user = user
		mail(subject: "New User: #{user.email}")
	end

	def cancelled_user(user)
		@user = user
		mail(subject: "Cancelled User: #{@user.email}")
	end
end
