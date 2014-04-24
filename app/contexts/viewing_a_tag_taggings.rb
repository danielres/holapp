class ViewingATagTaggings

  def initialize(viewer, tag)
    @viewer = viewer
    @tag = tag
    @viewer.extend Viewer
    @tag.extend Tag
    setup_taggings_associations
  end

  def expose_taggings_by_taggable_types(view_context)
    raise ActionForbiddenError unless @viewer.can_view_taggables? @tag
    output = []
    taggings.group_by(&:taggable_type).map do |type, taggings|
      title = type.pluralize
      title = 'People' if title == 'Users'
      output << "<section data-purpose='#{ title.downcase }-taggings'>"
      output << "<h1>#{ title }</h1>"
      output << "<div class='panel'>"
      taggings.group_by(&:context).map do |tag_field, taggings|
        output << TaggingsPresenter.new(taggings, tag_field, view_context).to_html(viewed_from: :tag)
      end
      output << "</div>"
      output << "</section>"
    end
    "<section>#{ output.join }</section>".html_safe
  end

  def setup_taggings_associations
    Tagging.class_eval do
        belongs_to :tag
        belongs_to :taggable, polymorphic: true
      end
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

    module Tag
      def self.extended(object)
        object.class.class_eval do
          has_many :taggings
        end
      end
    end

end
