class News::Item < ActiveRecord::Base
  LANGUAGES = %w(en fr)
  validates_presence_of  :summary
  validates_presence_of  :language
  validates_inclusion_of :language, in: LANGUAGES
end
