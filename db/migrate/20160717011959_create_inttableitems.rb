class CreateInttableitems < ActiveRecord::Migration
  def change
    create_table :inttableitems do |t|
      t.references :inttype, index: true, foreign_key: true
      t.references :statement, index: true, foreign_key: true
      t.integer :transactions
      t.decimal :volume

      t.timestamps null: false
    end
  end
end
