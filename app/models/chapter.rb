class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :lessons, dependent: :destroy
  has_many :chapterusers, dependent: :destroy
end
