class Lesson < ActiveRecord::Base
  belongs_to :chapter
  has_many :lessonusers, dependent: :destroy

	def completed?
		!completed_at.blank?
	end

end
