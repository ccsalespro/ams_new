class CreateProcessorusers < ActiveRecord::Migration
  def change
    create_table :processorusers do |t|
      t.references :processor, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :agentnumber

      t.timestamps null: false
    end
  end
end
