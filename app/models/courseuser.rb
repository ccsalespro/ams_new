class Courseuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  default_scope -> { order(user_id: :asc) }
	default_scope -> { order(course_id: :asc) }
	
end