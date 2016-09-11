class InternalContact < ActiveRecord::Base
	default_scope -> { order(created_at: :desc) }

	after_create :message_alert

	def message_alert
		AdminMailer.message_alert(self).deliver
	end
end
