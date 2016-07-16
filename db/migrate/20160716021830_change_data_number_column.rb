class ChangeDataNumberColumn < ActiveRecord::Migration
  def change
  	rename_column :merchants, :data_number, :mid
  	add_column :merchants, :month, :integer
  end
end
