class TagTaggingsPresenter < Erector::Widget

  needs :taggings, :view_context

  include Support::PresenterHelpers

  def content
    @taggings.group_by(&:taggable_type).map do |type, taggings|
      title = domain_language(type).pluralize
      section the( "#{ title.downcase }-taggings" ) do
        h1 title
        taggings.group_by(&:context).map do |tag_field, taggings|
          panel do
            text TagFieldWithTaggingsPresenter
                   .new( tag_field: tag_field,
                          taggings: taggings,
                       viewed_from: :tag,
                      view_context: @view_context )
                   .to_html
          end
        end
      end
    end
  end

end
