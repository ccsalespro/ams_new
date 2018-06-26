class Program < ActiveRecord::Base
  belongs_to :pricing_structure
  belongs_to :Processor
  has_many :programusers, dependent: :destroy
  has_many :users, through: :programusers
  has_many :comparisons, dependent: :destroy
  has_many :custom_fields
  belongs_to :system

  after_create :add_users

  def add_users
    User.all.each do |user|
      Programuser.create! user: user, program: self
    end
  end


  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Program.create! row.to_hash
		end
	end

end
