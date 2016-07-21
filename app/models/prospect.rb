class Prospect < ActiveRecord::Base
	has_many :statements
	has_many :intcalcitems
	belongs_to :user
	belongs_to :description
	has_many :notes, dependent: :destroy
	belongs_to :stage
	has_many :tasks, dependent: :destroy
	has_one :calendar, dependent: :destroy
	validates :stage, :presence => true
end
