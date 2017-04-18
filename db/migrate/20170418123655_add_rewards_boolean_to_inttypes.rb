class AddRewardsBooleanToInttypes < ActiveRecord::Migration
  def change
    add_column :inttypes, :rewards, :boolean
  end
end
