class Prospect < ActiveRecord::Base
	has_many :statements
	belongs_to :user
	belongs_to :description
	has_many :notes
	belongs_to :stage
	validates :stage, :presence => true
end