class Team < ActiveRecord::Base
	has_many :team_users, dependent: :destroy
	has_many :users, through: :team_users
	belongs_to :team_type
end
