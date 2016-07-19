class Prospect < ActiveRecord::Base
	has_many :statements
	has_many :intcalcitems
	belongs_to :user
	belongs_to :description
	has_many :notes
	belongs_to :stage
	has_many :tasks
	has_one :calendar
	validates :stage, :presence => true
end
