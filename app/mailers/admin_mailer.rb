class AdminMailer < ApplicationMailer
	default to: "support@instantquotetool.com"

	def new_user(user)
		@user = user
		mail(subject: "New User: #{user.email}")
	end

	def cancelled_user(user)
		@user = user
		mail(subject: "Cancelled User: #{@user.email}")
	end

	def message_alert(message)
		@message = message
		mail(subject: "New Support Question")
	end
end
