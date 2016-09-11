class AddIndexToProspectsUserId < ActiveRecord::Migration
  def change
  	add_index(:prospects, [:user_id, :created_at])
  end
end
