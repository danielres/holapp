class TagsPresenter < Erector::Widget

  needs :tags, :view_context

  include Support::PresenterHelpers

  def content
    panel do
      table the('tags-list') do
        caption 'Tags'
        @tags.each do |t|
          tr do
            td.name        link_to t.name, t
            td.description t.description
          end
        end
      end
    end
  end

end
