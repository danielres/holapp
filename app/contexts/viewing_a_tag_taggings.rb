class ViewingATagTaggings

  def initialize(viewer, tag)
    @viewer = viewer
    @tag = tag
    @viewer.extend Viewer
  end

  def expose_taggings_by_taggable_types(view_context)
    raise ActionForbiddenError unless @viewer.can_view_taggables? @tag
    TagTaggingsPresenter.new(taggings: @tag.taggings, view_context: view_context).to_html #todo: pass the tag, not the taggings
  end

  private

    module Viewer
      def can_view_taggables? tag
        Ability.new(self).can? :read, tag
      end
    end

end
