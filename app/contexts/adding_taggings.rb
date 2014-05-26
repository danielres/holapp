class AddingTaggings

  def initialize(tagger, taggable, tag_list, tag_field)
    @tagger = tagger
    @taggable = taggable
    @tag_list = tag_list
    @tag_field = tag_field
    @tagger.extend Tagger
    @taggable.extend Taggable
    @tagger.instance_variable_set(:@taggable, @taggable)
    @taggable.instance_variable_set(:@tag_field, @tag_field)
  end

  def execute
    @tagger.add_tags( @taggable, @tag_list, @tag_field,
                      failure: ->{ @controller.try(:failure) },
                      success: ->{ @controller.try(:success) }, )
  end

  def gather_user_input(view_context)
    return unless @tagger.can_add_tags?(@taggable)
    view_context.render partial: 'contexts/creating_taggings/form',
                         locals: { taggable: @taggable, tag_field: @tag_field }
  end

  def command(controller)
    @controller = controller
  end

  private

    module Tagger
      def add_tags(taggable, tag_list, tag_field, callbacks = {})
        raise ActionForbiddenError unless can_add_tags?(taggable)
        success?(taggable, tag_list) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(taggable, tag_list)
        taggable.add_tags(tag_list)
      end
      def can_add_tags?(taggable)
        Ability.new(self).can? :manage, taggable
      end
    end

    module Taggable
      def add_tags(tag_list)
        tag_list.split(',').each{ |tag_name|
          tag_name.strip!
          tag = Tag.where( "lower(name) = ?", tag_name.downcase).first
          tag ||= Tag.create(name: tag_name)
          tagging = Tagging.where(tag: tag, taggable: self, context: @tag_field).first_or_initialize
          unless tagging.persisted?
            tagging.save
          end
        }
      end
    end

end
