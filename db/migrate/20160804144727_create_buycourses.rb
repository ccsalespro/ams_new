class CreateBuycourses < ActiveRecord::Migration
  def change
    create_table :buycourses do |t|

      t.timestamps null: false
    end
  end
end
