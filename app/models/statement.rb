class Statement < ActiveRecord::Base
  belongs_to :prospect
  has_many :inttableitems, dependent: :destroy
  has_many :inttypes, through: :inttableitems
  has_many :intcalcitems, dependent: :destroy
  has_many :comparisons, dependent: :destroy
  validates :total_vol, presence: true, numericality: true
  validates :amex_vol, allow_nil: true, numericality: true
  validates :debit_vol, allow_nil: true, numericality: true
  validates :total_fees, allow_nil: true, numericality: true
  validates :avg_ticket, presence: true, numericality: true
  default_scope -> { order(created_at: :desc) }

  def self.import(file)
    CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
      Statement.create! row.to_hash
    end 
  end
end
