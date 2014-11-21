class News::Item < ActiveRecord::Base

  before_save :preprocess_contents

  LANGUAGES = %w(fr nl en)
  validates_presence_of  :summary
  validates_presence_of  :language
  validates_inclusion_of :language, in: LANGUAGES

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :taggings, as: :taggable, dependent: :destroy

  def name       ; summary end
  def to_s       ; name  end


  private

    def preprocess_contents
      md_links(summary)
      md_links(body, link_text)
    end

    def md_links s, link_text = nil
      url = /( |^)http:\/\/([^\s]*\.[^\s]*)( |$)/
      while s =~ url
        name = $2
        s.sub! /( |^)http:\/\/#{name}( |$)/, " [#{ link_text || name }](http://#{ name }) "
      end
      s
    end

    def link_text
      case language
      when 'fr' then 'Lire la suite'
      when 'nl' then 'Lees verder'
      else 'Read more'
      end
    end

end
