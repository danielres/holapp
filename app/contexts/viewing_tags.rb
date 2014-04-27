class ViewingTags

  def initialize(viewer)
    @viewer = viewer
    @viewer.extend Viewer
  end

  def expose_list(view_context)
    raise ActionForbiddenError unless @viewer.can_view_tags?
    TagsPresenter.new(@viewer.available_tags, view_context).to_html
  end

  private

    module Viewer
      def can_view_tags?
        Ability.new(self).can? :read, Tag
      end
      def available_tags
        Tag.accessible_by(Ability.new(self), :read).to_a
      end
    end

end

