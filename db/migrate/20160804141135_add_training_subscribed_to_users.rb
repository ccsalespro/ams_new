class AddTrainingSubscribedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :training_subscribed, :boolean, default: false
  end
end
