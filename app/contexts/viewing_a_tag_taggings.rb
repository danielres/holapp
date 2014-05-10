class ViewingATagTaggings

  def initialize(viewer, tag)
    @viewer = viewer
    @tag = tag
    @viewer.extend Viewer
  end

  def expose_taggings_by_taggable_types(view_context)
    raise ActionForbiddenError unless @viewer.can_view_taggables? @tag
    output = []
    taggings.group_by(&:taggable_type).map do |type, taggings|
      title = type.pluralize
      title = 'People' if title == 'Users'
      output << "<section data-purpose='#{ title.downcase }-taggings'>"
      output << "<h1>#{ title }</h1>"
      taggings.group_by(&:context).map do |tag_field, taggings|
        output << "<div class='panel'>"
        output << TaggingsPresenter.new(taggings: taggings, tag_field: tag_field, view_context: view_context).to_html(viewed_from: :tag)
        output << "</div>"
      end
      output << "</section>"
    end
    "<section>#{ output.join }</section>".html_safe
  end

  private

    def taggings
      @tag.taggings
    end

    module Viewer
      def can_view_taggables? tag
        Ability.new(self).can? :read, tag
      end
    end

end
