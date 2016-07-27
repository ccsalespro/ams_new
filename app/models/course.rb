class Course < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  belongs_to :user
end
