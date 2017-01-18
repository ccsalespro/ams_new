class CreateCcFields < ActiveRecord::Migration
  def change
    create_table :cc_fields do |t|
      t.references :comparison, index: true, foreign_key: true
      t.references :custom_field_type, index: true, foreign_key: true
      t.string :name
      t.decimal :amount
      t.decimal :cost

      t.timestamps null: false
    end
  end
end
