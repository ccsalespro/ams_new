class Program < ActiveRecord::Base
  belongs_to :Processor
  has_many :programusers, dependent: :destroy
  has_many :users, through: :programusers
  belongs_to :structure
  belongs_to :system
  validates_presence_of :name
  validates_presence_of :min_volume
  validates_presence_of :max_volume
  validates_presence_of :up_front_bonus
  validates_presence_of :residual_split
  validates_presence_of :min_bp_mark_up
  validates_presence_of :min_per_item_fee
  validates_presence_of :cost_structure
  validates_presence_of :terminal_type
  validates_presence_of :terminal_ownership_type
  validates_presence_of :min_per_batch_fee
  validates_presence_of :per_batch_cost
  validates_presence_of :per_item_cost
  validates_presence_of :bin_sponsorship
  validates_presence_of :visa_access_per_item
  validates_presence_of :visa_access_percentage
  validates_presence_of :mc_access_per_item
  validates_presence_of :mc_access_percentage
  validates_presence_of :disc_access_per_item
  validates_presence_of :disc_access_percentage
  validates_presence_of :min_monthly_fees
  validates_presence_of :monthly_fee_costs
  validates_presence_of :monthly_pci_fee
  validates_presence_of :monthly_pci_cost
  validates_presence_of :annual_pci_fee
  validates_presence_of :annual_pci_cost
  validates_presence_of :min_pin_debit_per_item_fee
  validates_presence_of :pin_debit_per_item_cost
  validates_presence_of :monthly_debit_fee_cost
  validates_presence_of :min_monthly_debit_fee
  validates_presence_of :next_day_funding_monthly_fee
  validates_presence_of :next_day_funding_monthly_cost
  validates_presence_of :amex_per_item_cost
  validates_presence_of :min_amex_per_item_fee
  validates_presence_of :amex_bp_cost
  validates_presence_of :min_amex_bp_fee
  validates_presence_of :application_fee_cost
  validates_presence_of :min_application_fee


  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Program.create! row.to_hash
		end	
	end

end
