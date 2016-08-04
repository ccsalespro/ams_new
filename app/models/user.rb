class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :prospects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :programusers, dependent: :destroy
  has_many :programs, through: :programusers
  has_many :processorusers, dependent: :destroy
  has_many :processors, through: :processorusers
  has_many :courseusers, dependent: :destroy
  has_many :chapterusers, dependent: :destroy
  has_many :lessonusers, dependent: :destroy
  belongs_to :subscribetocourses
end


