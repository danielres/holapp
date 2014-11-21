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
      self.summary = md_links(summary.to_s)
      self.body    = md_links(body.to_s, link_text)
    end

    def md_links s, link_text = nil
      Rinku.auto_link(s){ |url| link_text || url }
    end

    def link_text
      case language
      when 'fr' then 'Lire la suite'
      when 'nl' then 'Lees verder'
      else 'Read more'
      end
    end

end
