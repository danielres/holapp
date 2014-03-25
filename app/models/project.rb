class Project < ActiveRecord::Base

  self.inheritance_column = "disabled"

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :memberships
  has_many :members, through: :memberships, source: :user

end
