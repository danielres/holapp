class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :taggings, dependent: :destroy
  has_many :taggings_as_taggable, as: :taggable, class_name: 'Tagging', foreign_key: 'taggable_id', dependent: :destroy

  def pole?
    children.any? && parents.none?
  end

  def children
    taggings
      .where(taggable_type: 'Tag')
      .map(&:taggable)
  end

  def parents
    taggings_as_taggable
      .map(&:tag)
  end

  def ancestors
    result = parents
    parents.each { |p| result.concat(p.ancestors) }
    result
  end

  def to_s
    name
  end

end
