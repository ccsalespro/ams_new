class Prospect < ActiveRecord::Base
	has_many :statements
	belongs_to :user
end
