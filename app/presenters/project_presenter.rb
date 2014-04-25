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
              skills_list: skills_list_html,
             skills_adder: skills_adder_html,

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
      AddingAMembership.new(@viewer, nil, @project).gather_user_input(@view_context)
    end

    def skills_list_html
      ViewingATaggableTaggings.new(@viewer, @project).expose_list(:skills, @view_context)
    end

    def skills_adder_html
      AddingTaggings.new(@viewer, @project, nil, :skills).gather_user_input(@view_context)
    end


end
