class Lessonuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  def completed?
		!completed_at.blank?
	end

end