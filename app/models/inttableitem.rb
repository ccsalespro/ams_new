class Inttableitem < ActiveRecord::Base
  default_scope -> { order(transactions: :desc)}
  belongs_to :inttype
  belongs_to :statement
end
