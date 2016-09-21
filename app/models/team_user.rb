class TeamUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  belongs_to :team_user_role
end
