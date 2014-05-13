class ViewingATaggableTaggings

  def initialize(viewer, taggable)
    @viewer = viewer
    @taggable = taggable
    @viewer.extend Viewer
  end

  def expose_list(tag_field, view_context)
    raise ActionForbiddenError unless @viewer.can_view_taggings?(@taggable)
    taggings = @viewer.available_taggings(@taggable,tag_field)
    TagFieldWithTaggingsPresenter.new(tag_field: tag_field, taggings: taggings, viewed_from: :taggable, view_context: view_context).to_html
  end


  private

    module Viewer
      def can_view_taggings? taggable
        Ability.new(self).can? :read, taggable
      end
      def available_taggings(taggable, tag_field)
        taggings = Tagging.where(taggable_id: taggable.id, taggable_type: taggable.class.name, context: tag_field)
        nonull   = taggings.where("quantifier is not null").order(quantifier: :desc)
        yesnull  = taggings.where("quantifier is null")
        nonull + yesnull
      end
    end

end
