class AddCompletedAtToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :completed_at, :datetime
  end
end
