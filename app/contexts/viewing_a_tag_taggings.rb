class ViewingATagTaggings

  def initialize(viewer, tag)
    @viewer = viewer
    @tag = tag
    @viewer.extend Viewer
    @tag.extend Tag
  end

  def expose_taggings_by_taggable_types(view_context)
    raise 'Access forbidden' unless @viewer.can_view_taggables? @tag
    taggings.group_by(&:taggable_type).map do |type, taggings|
      title = type.pluralize
      title = 'People' if title == 'Users'
      output << "<section data-purpose='#{ title.downcase }-taggings'>"
      output << "<h1>#{ title }</h1>"
      taggings.group_by(&:context).map do |tag_field, taggings|
        output << TaggingsPresenter.new(taggings, tag_field, view_context).to_html
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

    module Tag
      def self.extended(object)
        object.class.class_eval do
          has_many :taggings
        end
      end
    end

end
