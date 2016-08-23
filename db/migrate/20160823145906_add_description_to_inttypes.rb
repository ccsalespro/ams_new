class AddDescriptionToInttypes < ActiveRecord::Migration
  def change
    add_column :inttypes, :full_description, :text
  end
end
