class RemoveRoleFromTeamUsers < ActiveRecord::Migration
  def change
  	remove_column :team_users, :role
  end
end
