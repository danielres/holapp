class ViewingATaggableTaggings

  def initialize(viewer, taggable)
    @viewer = viewer
    @taggable = taggable
    @viewer.extend Viewer
    @taggable.extend Taggable
    setup_taggings_associations
  end

  def expose_list(tag_field, view_context)
    return unless @viewer.can_view_taggings?(@taggable)
    taggings = @viewer.available_taggings(@taggable,tag_field)
    TaggingsPresenter.new(taggings, tag_field, view_context).to_html(viewed_from: :taggable)
  end


  private

    def setup_taggings_associations
      Tagging.class_eval do
          belongs_to :tag
          belongs_to :taggable, polymorphic: true
        end
    end

    module Viewer
      def can_view_taggings? taggable
        Ability.new(self).can? :read, taggable
      end
      def available_taggings(taggable, tag_field)
        Tagging.where(taggable_id: taggable.id, taggable_type: taggable.class.name, context: tag_field)
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
