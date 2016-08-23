class Statement < ActiveRecord::Base
  belongs_to :prospect
  has_many :inttableitems, dependent: :destroy
  has_many :inttypes, through: :inttableitems
  has_many :intcalcitems, dependent: :destroy
  has_many :comparisons, dependent: :destroy
  validates_presence_of :total_vol
  default_scope -> { order(created_at: :desc) }
end
