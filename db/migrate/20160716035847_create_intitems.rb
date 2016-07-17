class CreateIntitems < ActiveRecord::Migration
  def change
    create_table :intitems do |t|
      t.references :merchant, index: true, foreign_key: true
      t.references :inttype, index: true, foreign_key: true
      t.integer :month
      t.string :card_type
      t.integer :transactions
      t.decimal :volume

      t.timestamps null: false
    end
  end
end
