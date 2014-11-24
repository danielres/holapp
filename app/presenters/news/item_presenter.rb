module News
  class ItemPresenter < Erector::Widget

    needs :viewer, :item, :view_context

    include ::Support::PresenterHelpers

    def content
      row do
        col(12) do
          panel{ item_details_html }
        end
      end
      row do
        col(6){ panel{ taggings_on_html(:themes) } }
      end
      row do
        col(6){ panel{ dangerous_actions_menu_html    } }
      end

    end

    private

      def renderer
        @renderer ||= MarkdownRenderer.new
      end


      def taggings_on_html(tag_field)
        text ViewingATaggableTaggings
              .new(@viewer, @item, tag_field)
              .view_context(@view_context)
              .call
        text AddingTaggings
              .new(@viewer, @item, nil, tag_field)
              .view_context(@view_context)
              .get_user_input
      end

      def dangerous_actions_menu_html
        h3 'Dangerous actions'
        actions_menu do
          li delete_resource_link(@item)
        end
      end

    def item_details_html
      table.details do
        tr do
          th 'Summary'
          td do
            random_val = (rand * 1000).to_i
            best_in_place_activator(random_val, :body)
            text best_in_place @item, :body,
                    type: :textarea,
                    path: "/news/#{@item.to_param}",
                     nil: '…',
            display_with: ->(txt){ render_description(txt) },
               activator: "##{ random_val }"
          end
        end
        tr do
          th 'Body'
          td do
            random_val = (rand * 1000).to_i
            best_in_place_activator(random_val, :summary)
            text best_in_place @item, :summary,
                    type: :textarea,
                    path: "/news/#{@item.to_param}",
                     nil: '…',
            display_with: ->(txt){ render_description(txt) },
               activator: "##{ random_val }"
          end
        end
      end
    end



  end

end

