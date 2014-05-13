class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :taggings, dependent: :destroy
  has_many :taggings_as_taggable, as: :taggable, class_name: 'Tagging', foreign_key: 'taggable_id', dependent: :destroy
end
