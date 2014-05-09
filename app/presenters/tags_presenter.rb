class TagsPresenter < Erector::Widget

  needs :tags, :view_context

  include Support::PresenterHelpers

  def content
    panel do
      table the('tags-list') do
        caption 'Tags'
        @tags.each do |t|
          tr do
            td.name do
              text @view_context.link_to t.name, t
            end
            td.description do
              text t.description
            end
          end
        end
      end
    end
  end

end
