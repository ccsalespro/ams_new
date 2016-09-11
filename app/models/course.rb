class Course < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
   has_many :courseusers, dependent: :destroy
  has_many :users, through: :courseusers
  has_many :lessons
  belongs_to :user
end
