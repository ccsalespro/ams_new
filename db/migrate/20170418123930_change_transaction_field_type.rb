class ChangeTransactionFieldType < ActiveRecord::Migration
  def self.up
    change_table :inttableitems do |t|
      t.change :transactions, :decimal
    end
  end
  def self.down
    change_table :inttableitems do |t|
      t.change :transactions, :integer
    end
  end
end
