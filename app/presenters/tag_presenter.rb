class TagPresenter < Erector::Widget

  needs :viewer, :tag, :view_context

  include Support::PresenterHelpers

  def content
    row do

      col(8) do
        h1 @tag.name
      end

      col(4) do
        panel do
          ul.menu do
            Tagging::PEOPLE_TAG_FIELDS.each do |tag_field|
              li TaggingAResource
                  .new(@viewer, @tag, tag_field, @viewer)
                  .gather_user_input(
                    @view_context,
                    text: "Add to my #{ tag_field }"
                  )
            end
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
              td do
                random_val = (rand * 1000).to_i
                best_in_place_activator(random_val, :description)
                text best_in_place @tag, :description,
                        path: "/tags/#{ @tag.id }",
                        type: :textarea,
                         nil: '…',
                display_with: ->(txt){ render_description(txt) },
                   activator: "##{ random_val }"
              end
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

      col(6) do
        h3 'Dangerous actions'

        row do

          col(6) do
            panel do
              text MergingTags.new(@viewer, @tag, nil).gather_user_input(@view_context)
            end
          end

          col(6) do
            panel do
              actions_menu do
                ul do
                  li delete_resource_link(@tag)
                end
              end
            end
          end

        end
      end

    end
  end

end
