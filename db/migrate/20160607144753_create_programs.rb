class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.decimal :per_item_cost
      t.decimal :min_per_item_fee
      t.belongs_to :processor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
