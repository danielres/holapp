class TagsPresenter < Erector::Widget

  needs :tags, :view_context

  include Support::PresenterHelpers

  def content
    h2 'Tags'
    row do
      col(6) do
        yes_poles.each do |pole|
          panel do
            tags_table pole.children, link_to(pole.name, pole)
          end
        end
      end
      col(6) do
        panel do
          tags_table free_tags, 'Orphan tags'
        end
      end
    end
  end

  private

    def all_tags
      @tags.sort{ |a,b| b.taggings.count <=> a.taggings.count }
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
            td.description t.description
          end
        end
      end

    end

end
