class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :taggings, dependent: :destroy
end
