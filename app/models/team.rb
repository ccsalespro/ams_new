class Team < ActiveRecord::Base
	has_many :team_users, dependent: :destroy
	has_many :users, through: :team_users
	has_many :chats, dependent: :destroy
	belongs_to :team_type
end
