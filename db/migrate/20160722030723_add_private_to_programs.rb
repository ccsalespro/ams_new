class AddPrivateToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :private, :boolean
  end
end
