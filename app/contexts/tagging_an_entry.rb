class TaggingAnEntry

  def initialize(tagger, taggable, tags, tag_field)
    @tagger = tagger
    @taggable = taggable
    @tags = tags
    @tag_field = tag_field
    @tagger.extend Tagger
    @taggable.extend Taggable
    @taggable.instance_variable_set(:@tag_field, @tag_field)
  end

  def tag
    if @tagger.can_tag?(@taggable)
      @taggable.add_tags @tags
    end
  end

  def expose_form(view_context)
    return unless @tagger.can_tag?(@taggable)
    view_context.render(partial: 'contexts/tagging_an_entry/form')
  end

  def expose_list(view_context)
    return unless @tagger.can_read_taggings?(@taggable)
    view_context.render(partial: 'contexts/tagging_an_entry/list', locals: { taggings: @taggable.taggings })
  end


  private

    module Tagger
      def can_tag? taggable
        Ability.new(self).can? :manage, taggable
      end
      def can_read_taggings? taggable
        Ability.new(self).can? :read, taggable
      end
    end

    module Taggable
      def self.extended(object)
        object.class.class_eval do
          acts_as_taggable_on
        end
      end
      def add_tags tags
        set_tag_list_on(@tag_field, tags)
        save!
      end
      def tag_list_on *args
        super
      end
    end

end
