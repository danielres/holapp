class ViewingProjects

  def initialize(viewer)
    @viewer = viewer
    @viewer.extend Viewer
  end

  def expose_list(view_context)
    ProjectsPresenter.new(@viewer.available_projects, view_context).to_html
  end

  private

    module Viewer
      def available_projects
        Project.accessible_by(Ability.new(self), :read)
      end
    end

end

