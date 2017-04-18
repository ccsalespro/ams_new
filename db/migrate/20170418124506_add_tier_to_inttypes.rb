class AddTierToInttypes < ActiveRecord::Migration
  def change
    add_column :inttypes, :tier, :string
  end
end
