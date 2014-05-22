class TagPresenter < Erector::Widget

  needs :viewer, :tag, :view_context

  include Support::PresenterHelpers

  def content
    row do

      col(12) do
        h1 @tag.name
        actions_menu do
          ul do
            li delete_resource_link(@tag)
          end
        end
      end

      col(8) do
        panel do
          table.details do
            tr do
              th 'Name'
              td best_in_place @tag, :name,  path: "/tags/#{ @tag.id }", nil: '…'
            end
            tr do
              th 'Description'
              td best_in_place @tag, :description, type: :textarea, path: "/tags/#{ @tag.id }", nil: '…'
            end
          end
        end
      end

      col(4) do
        text TagTreesPresenter.new(tag: @tag, view_context: @view_context).to_html
      end

      col(12) do
        text ViewingATagTaggings.new(@viewer, @tag).expose_taggings_by_taggable_types(@view_context)
        panel do
          text ViewingATaggableTaggings.new(@viewer, @tag).expose_list(:tag_parents, @view_context)
          text AddingTaggings.new(@viewer, @tag, nil, :tag_parents).gather_user_input(@view_context)
        end
      end

    end
  end

end
