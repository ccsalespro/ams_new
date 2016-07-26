class Statement < ActiveRecord::Base
  belongs_to :prospect
  has_many :inttableitems, dependent: :destroy
  has_many :inttypes, through: :inttableitems
  has_many :intcalcitems
  validates_presence_of :total_vol
end
