class Lesson < ActiveRecord::Base
  belongs_to :chapter

	def completed?
		!completed_at.blank?
	end

end
