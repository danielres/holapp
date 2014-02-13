class TaggingAnEntry

  def initialize(tagger, taggable, tags, tag_field)
    @tagger = tagger
    @taggable = taggable
    @tags = tags
    @tag_field = tag_field
    @tagger.extend Tagger
    @taggable.extend Taggable(tag_field)
  end

  def tag
    if @tagger.can_tag?(@taggable)
      @taggable.add_tags @tags
    end
  end

  private

    module Tagger
      def can_tag? taggable
        Ability.new(self).can? :manage, taggable
      end
    end

    def Taggable tag_field
      Module.new do |tag_field|
        @tag_field = tag_field
        def self.extended(object)
          object.class.class_eval do
            acts_as_taggable_on @tag_field
          end
        end
        def add_tags tags
          set_tag_list_on(@tag_field, tags)
        end
        def tags
          tag_list_on(@tag_field)
        end
      end
    end

end
