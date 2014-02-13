class TaggingAnEntry

  def initialize(tagger, taggable, tags, tag_field)
    @tagger = tagger
    @taggable = taggable
    @tags = tags
    @tag_field = tag_field
    @tagger.extend Tagger
    @taggable.class.send :prepend, Taggable
  end

  def tag
    if @tagger.can_tag?(@taggable)
      @taggable.tag_on(@tags, @tag_field)
    end
  end

  private

    module Tagger
      def can_tag? taggable
        Ability.new(self).can? :manage, taggable
      end
    end

    module Taggable
      def initialize
        # super
        @tags ||= {}
      end
      def tag_on new_tags, tag_field
        new_tags = Array(new_tags)
        @tags[tag_field] ||= []
        @tags[tag_field] += new_tags
      end
      def tags
        @tags
      end
    end
end
