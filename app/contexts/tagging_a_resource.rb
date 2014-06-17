class TaggingAResource

  def initialize(tagger, tag, tag_field, resource)
    @tagger    = tagger
    @tag       = tag
    @tag_field = tag_field
    @resource  = resource
    @tagger.extend Tagger
    @resource.extend Taggable
  end

  def command(controller)
    @controller = controller
  end

  def execute
    @tagger.add_tag_to_resource( @tag, @tag_field, @resource,
                      failure: ->{ @controller.try(:failure) },
                      success: ->{ @controller.try(:success) }, )
  end

  def gather_user_input(view_context, options={})
    return unless @tagger.can_add_tag_to_resource?(@tag, @tag_field, @resource)
    view_context.render partial: 'contexts/tagging_a_resource/form',
                         locals: {
                          resource: @resource,
                          tag: @tag,
                          tag_field: @tag_field,
                          text: options[:text],
                        }
  end


  private

    module Tagger
      def add_tag_to_resource(tag, tag_field, resource, callbacks = {})
        raise ActionForbiddenError unless can_add_tag_to_resource?(tag, tag_field, resource)
        success?(tag, tag_field, resource) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(tag, tag_field, resource)
        resource.add_tag(tag, tag_field)
      end
      def can_add_tag_to_resource?(tag, tag_field, resource)
        Ability.new(self).can? :manage, resource
      end
    end

    module Taggable
      def add_tag(tag, tag_field)
        tagging = Tagging.where(tag: tag, taggable: self, context: tag_field).first_or_initialize
        unless tagging.persisted?
          tagging.save!
        end
      end
    end

end
