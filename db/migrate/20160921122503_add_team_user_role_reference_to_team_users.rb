class AddTeamUserRoleReferenceToTeamUsers < ActiveRecord::Migration
  def change
    add_reference :team_users, :team_user_role, index: true, foreign_key: true
  end
end
