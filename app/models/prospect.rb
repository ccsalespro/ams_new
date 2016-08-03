class Prospect < ActiveRecord::Base
	has_many :statements, dependent: :destroy
	has_many :intcalcitems
	belongs_to :user
	belongs_to :description
	has_many :notes, dependent: :destroy
	belongs_to :stage
	has_many :tasks, dependent: :destroy
	has_one :calendar
	validates :stage, :presence => true
	default_scope -> { order(created_at: :desc) }
end
