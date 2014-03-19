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
      purpose = type.pluralize
      purpose = 'People' if purpose == 'Users'
      purpose = "#{purpose.downcase.pluralize}-list"
      view_context.render partial: 'contexts/viewing_taggables/by_type', locals: { type: type, title: title,  taggings: taggings, purpose: purpose }
    end.join.html_safe
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
