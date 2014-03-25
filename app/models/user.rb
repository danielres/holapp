class User < ActiveRecord::Base

  attr_accessor :name

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false }

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :projects, through: :memberships

  def initialize(options={})
    super
    set_first_and_last_name(options[:name])
  end

  def to_partial_path
    'people/person'
  end

  def name
    self.display_name.presence || first_name
  end


  private

    def set_first_and_last_name(name)
      return unless name
      self.first_name = name.split(' ').first
      self.last_name  = name.split(' ')[1..-1].join(' ')
    end

end
