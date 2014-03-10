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
      AddingAPersonToAProject.new(@viewer, nil, @project).expose_form(@view_context)
    end

    def skills_list_html
      ViewingTaggings.new(@viewer, @project).expose_list(:skills, @view_context)
    end

    def skills_adder_html
      CreatingTaggings.new(@viewer, @project, nil, :skills).expose_form(@view_context)
    end


end
