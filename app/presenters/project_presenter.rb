class ProjectPresenter

  def initialize(viewer, project, view_context)
    @viewer = viewer
    @project = project
    @view_context = view_context
  end

  def to_html
    h.render(partial: 'presenters/project_presenter/project', locals: {
                   project: @project,
              memberships: memberships_html,
      new_membership_form: new_membership_form_html,
    })
  end

  private

    def h
      @view_context
    end

    def memberships_html
      h.render( partial: 'presenters/project_presenter/memberships', locals: { memberships: @project.memberships })
    end

    def new_membership_form_html
      AddingAPersonToAProject.new(@viewer, nil, @project, @view_context).expose_form
    end

end
