class ViewingProjects

  def initialize(viewer)
    @viewer = viewer
    @viewer.extend Viewer
  end

  def expose_list(view_context)
    raise ActionForbiddenError unless @viewer.can_view_projects?
    ProjectsPresenter.new(
          projects: @viewer.available_projects,
      view_context: view_context
    ).to_html
  end

  private

    module Viewer
      def can_view_projects?
        Ability.new(self).can? :read, Project
      end
      def available_projects
        Project.accessible_by(Ability.new(self), :read)
      end
    end

end

