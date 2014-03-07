class ViewingTaggings

  def initialize(viewer, taggable)
    @viewer = viewer
    @taggable = taggable
    @viewer.extend Viewer
    @taggable.extend Taggable
  end

  def expose_list(view_context)
    return unless @viewer.can_view_taggings?(@taggable)
    view_context.render(partial: 'contexts/viewing_taggings/list', locals: { taggings: @taggable.taggings })
  end


  private

    module Viewer
      def can_view_taggings? taggable
        Ability.new(self).can? :read, taggable
      end
    end

    module Taggable
      def self.extended(object)
        object.class.class_eval do
          acts_as_taggable_on
        end
      end
    end

end
