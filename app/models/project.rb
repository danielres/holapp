class Project < ActiveRecord::Base

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :memberships
  has_many :members, through: :memberships, source: :user
end
