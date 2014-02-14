class ProjectsPresenter
  def initialize(project_or_projects, view_context)
    @projects = Array(project_or_projects)
    @view_context = view_context
  end
  def as_html
    "<section>Projects <ul>#{ list_items }</ul> </section>"
  end
  private
    def list_items
      @projects.map{ |p| "<li>#{p.name}</li>" }.join
    end
end
