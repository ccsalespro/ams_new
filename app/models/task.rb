class Task < ActiveRecord::Base
	belongs_to :user
	belongs_to :prospect

default_scope -> { order(completed: :asc) }
default_scope -> { order(finish_date: :asc) }

	def completed?
		!completed_at.blank?
	end

end
