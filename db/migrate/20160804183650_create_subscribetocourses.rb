class CreateSubscribetocourses < ActiveRecord::Migration
  def change
    create_table :subscribetocourses do |t|

      t.timestamps null: false
    end
  end
end
