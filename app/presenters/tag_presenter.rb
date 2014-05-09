class TagPresenter < Erector::Widget

  needs :viewer, :tag, :view_context

  include Support::PresenterHelpers

  def content
    col(12) do

      menu do
        ul the('actions-menu') do
          li delete_resource_link(@tag)
        end
      end

      h1 @tag.name

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

      text ViewingATagTaggings.new(@viewer, @tag).expose_taggings_by_taggable_types(@view_context)

    end
  end

end
