class AdminMailer < ApplicationMailer
	default to: "support@instantquotetool.com"


	def mandrill_client
		@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
	end

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

	def new_program(program, user)
		template_name = "new-program"
		template_content = []
		message = {
			to: [{email: "support@instantquotetool.com", name: "Support"}],
			subject: "New Program: #{program.name}",
			merge_vars: [
				{rcpt: "support@instantquotetool.com",
				 vars: [
				 	{name: "PROGRAM_NAME", content: program.name},
				 	{name: "PROGRAM_MIN_VOL", content: program.min_volume},
				 	{name: "PROGRAM_MAX_VOL", content: program.max_volume},
				 	{name: "PROGRAM_MIN_BP", content: program.min_bp_mark_up},
				 	{name: "PROGRAM_MIN_PER_ITEM", content: program.min_per_item_fee},
				 	{name: "PROGRAM_UP_FRONT", content: program.up_front_bonus},
				 	{name: "PROGRAM_RESIDUAL_PERCENTAGE", content: program.residual_split},
				 	{name: "USER_NAME", content: "#{user.first_name + " " + user.last_name}"},
				 	{name: "USER_PHONE", content: user.phone_number},
				 	{name: "USER_EMAIL", content: user.email}
				 ]
				}
			]
		}
		mandrill_client.messages.send_template template_name, template_content, message
	end
end
