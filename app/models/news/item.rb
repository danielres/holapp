class News::Item < ActiveRecord::Base
  LANGUAGES = %w(fr en)
  validates_presence_of  :summary
  validates_presence_of  :language
  validates_inclusion_of :language, in: LANGUAGES

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :taggings, as: :taggable, dependent: :destroy

  def name       ; summary end
  def to_s       ; name  end

end
