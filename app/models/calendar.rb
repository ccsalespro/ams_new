class Calendar < ActiveRecord::Base
  belongs_to :user
  belongs_to :prospect
  def completed?
    !completed_at.blank?
  end
end
