class AddEmailToTeamUsers < ActiveRecord::Migration
  def change
    add_column :team_users, :email, :string
  end
end
