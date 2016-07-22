class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :prospects
  has_many :tasks
  has_many :programusers
  has_many :programs, through: :programusers
  has_many :processorusers
  has_many :processors, through: :processorusers
end


