class ProjectsPresenter < Erector::Widget

  needs :projects, :view_context

  include Support::PresenterHelpers

  def content
    table the('projects-list') do
      caption 'Projects'

      @projects.each do |p|
        tr do
          td.name do
            text link_to p.name, p
          end
          td.description do
            text p.description
          end
        end
      end

    end
  end

end
