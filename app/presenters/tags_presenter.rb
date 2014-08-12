class TagsPresenter < Erector::Widget

  needs :collection, :view_context, :viewer

  include Support::PresenterHelpers

  def content
    h2 'Tags'
    row do
      col(9) do
        row do
          yes_poles.each do |pole|
            col(4) do
              panel do
                text  TagTreesPresenter
                        .new(tag: pole, view_context: @view_context, viewer_taggings: @viewer.taggings )
                        .to_html
              end
            end
          end
        end
      end
      col(3) do
        panel do
          tags_table free_tags, 'Orphan tags'
        end
      end
    end
  end

  private

    def all_tags
      @collection.sort{ |a,b| a.name <=> b.name }
    end

    def yes_poles
      all_tags.select{ |t| t.pole? }
    end

    def free_tags
      all_tags.reject{ |t| t.parents.any? } - yes_poles
    end

    def tags_table tags, caption_text
      table the('tags-list') do
        caption caption_text
        tags
          .each do |t|
          tr do
            td.name        link_to t.name, t
            td.description render_excerpt(t.description)
          end
        end
      end

    end

end
