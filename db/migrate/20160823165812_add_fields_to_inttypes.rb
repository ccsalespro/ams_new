class AddFieldsToInttypes < ActiveRecord::Migration
  def change
    add_column :inttypes, :credit, :boolean
    add_column :inttypes, :debit, :boolean
    add_column :inttypes, :prepaid, :boolean
    add_column :inttypes, :regulated, :boolean
    add_column :inttypes, :TE, :boolean
  end
end
