class ChangeBpMarkUpOnStatements < ActiveRecord::Migration
  def self.up
    change_table :comparisons do |t|
      t.change :bp_mark_up, :decimal
    end
  end
  def self.down
    change_table :comparisons do |t|
      t.change :bp_mark_up, :integer
    end
  end
end
