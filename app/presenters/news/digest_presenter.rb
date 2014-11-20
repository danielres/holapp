module News

  class DigestPresenter < Erector::Widget

    needs :collection, :view_context

    include Support::PresenterHelpers

    def content
      panel do
        table do
          @collection.each do |i|
            tr do
              td renderer.call i.summary
              td renderer.call i.body
              td i.taggings
                    .map(&:tag)
                    .map{|i| link_to i, i }
                    .join(', ').html_safe
              td link_to(i.author, i.author)
            end
          end
        end
      end
    end

    def renderer
      @renderer ||= MarkdownRenderer.new
    end

  end

end
