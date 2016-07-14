class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :prospect
  default_scope -> { order(created_at: :desc) }
end
