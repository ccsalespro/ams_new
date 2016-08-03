class Program < ActiveRecord::Base
  belongs_to :Processor
  has_many :programusers, dependent: :destroy
  has_many :users, through: :programusers
  belongs_to :system
  has_many :comparisons


  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Program.create! row.to_hash
		end	
	end

end
