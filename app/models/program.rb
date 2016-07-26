class Program < ActiveRecord::Base
  belongs_to :Processor
  has_many :programusers, dependent: :destroy
  has_many :users, through: :programusers
  belongs_to :structure
  belongs_to :system
  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Program.create! row.to_hash
		end	
	end

end
