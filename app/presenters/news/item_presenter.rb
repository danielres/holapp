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
    end

    private

      def renderer
        @renderer ||= MarkdownRenderer.new
      end

  end

end

