class ViewingProjects

  def initialize(user)
    @viewer = user
    @viewer.extend Viewer
  end

  def view
    render(@viewer.projects)
  end

  private

    module Viewer
      def projects
        Project.all
      end
    end

    def render(project_or_projects)
      ProjectsPresenter.new(project_or_projects).as_html
    end

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

end
