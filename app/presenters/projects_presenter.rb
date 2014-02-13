class ProjectsPresenter
  def initialize(project_or_projects)
    @projects = Array(project_or_projects)
  end
  def as_html
    "<section>Projects <ul>#{ list_items }</ul> </section>"
  end
  private
    def list_items
      @projects.map{ |p| "<li>#{p.name}</li>" }.join
    end
end