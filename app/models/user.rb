class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :invitable, :database_authenticatable, :registerable,
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
  has_many :tickets, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  after_create :add_programs, :subscribe

  def add_programs
    @programs = Program.all
    @programs.each do |program|
      @programuser = Programuser.new
      @programuser.user_id = self.id
      @programuser.program_id = program.id
      @programuser.save!
    end

    @processors = Processor.all
    @processors.each do |processor|
      @processoruser = Processoruser.new
      @processoruser.user_id = self.id
      @processoruser.processor_id = processor.id
      @processoruser.save!
    end
  end

  def subscribe
    self.training_subscribed = true
    self.save
  end

  def staff?
    self.admin
  end

  # String to represent a user (e-mail, name, etc.)
  def to_s
    email
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end


