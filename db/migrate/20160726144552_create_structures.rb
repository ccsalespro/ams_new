class CreateStructures < ActiveRecord::Migration
  def change
    create_table :structures do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
