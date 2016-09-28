class AddStripeSubscriptionActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_subscription_active, :boolean
  end
end
