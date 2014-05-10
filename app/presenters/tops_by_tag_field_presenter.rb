class TopsByTagFieldPresenter < Erector::Widget

  include Support::PresenterHelpers

  needs :tag_field, :min_level, :view_context

  def content
    div the("top-#{ @tag_field }") do
      h2 "Top #{ @tag_field }"
      taggings_collection
        .group_by(&:taggable_type)
        .each do |taggable_type, taggings|
          taggings_table(taggable_type, taggings)
        end
    end
  end


  private

    def taggings_collection
      Tagging
        .where(context: @tag_field)
        .where("quantifier >= ?", @min_level)
    end

    def taggings_table(taggable_type, taggings)
      table do
        caption domain_language(taggable_type).pluralize
        taggings
          .group_by(&:tag)
          .sort{ |a,b| b[1].count <=> a[1].count }
          .each do |tag, taggings|
            tr do
              td.name link_to(tag.name, tag)
              td do
                taggings_taggables(taggings)
              end
            end
          end
      end
    end

    def taggings_taggables(taggings)
      taggings
        .sort{ |a,b| b.quantifier <=> a.quantifier }
        .each do |t|
          text link_to(t.taggable.name, t.taggable)
          small " (#{t.quantifier}) "
        end
    end

end
