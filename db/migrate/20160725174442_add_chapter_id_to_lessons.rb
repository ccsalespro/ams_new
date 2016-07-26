class AddChapterIdToLessons < ActiveRecord::Migration
  def change
    add_reference :lessons, :chapter, index: true, foreign_key: true
  end
end
