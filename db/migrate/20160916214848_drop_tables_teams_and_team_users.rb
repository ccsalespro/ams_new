class DropTablesTeamsAndTeamUsers < ActiveRecord::Migration
  def change
  	drop_table :teams 
  	drop_table :team_users
  end
end
