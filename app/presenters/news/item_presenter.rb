module News
  class ItemPresenter < Erector::Widget

    needs :viewer, :item, :view_context

    include ::Support::PresenterHelpers

    def content
      row do
        col(6) do
          panel do
            dl do
              dt renderer.call(@item.summary)
              dd renderer.call(@item.body)
            end
          end
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


  end

end

