class Ticket < ActiveRecord::Base

belongs_to :user

default_scope -> { order(important: :desc) }
default_scope -> { order(created_at: :desc) }

end