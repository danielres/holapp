class ProjectsPresenter
  def initialize(project_or_projects, view_context)
    @projects = Array(project_or_projects)
    @view_context = view_context
  end

  def as_html
    h.render partial: 'presenters/projects_presenter',
              locals: { projects: @projects }
  end

  private

    def h
      @view_context
    end

end
