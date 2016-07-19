class Task < ActiveRecord::Base
	belongs_to :user
	belongs_to :prospect
	default_scope -> { order(created_at: :desc) }

	def completed?
		!completed_at.blank?
	end

end
