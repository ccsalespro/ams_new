class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.decimal :amount
      t.decimal :cost
      t.references :program, index: true, foreign_key: true
      t.references :custom_field_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
