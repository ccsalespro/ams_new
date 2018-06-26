class Processor < ActiveRecord::Base
	has_many :programs, dependent: :destroy
	has_many :processorusers, dependent: :destroy
	has_many :users, through: :processorusers

  after_create :add_users

  def add_users
    User.all.each do |user|
      Processoruser.create! user: user, processor: self
    end
  end
end
