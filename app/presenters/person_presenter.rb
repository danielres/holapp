class PersonPresenter

  def initialize(viewer, person, view_context)
    @viewer = viewer
    @person = person
    @view_context = view_context
  end

  def to_html
    h.render(partial: 'presenters/person_presenter/person', locals: {
                   person: @person,
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
      h.render( partial: 'presenters/person_presenter/memberships', locals: { memberships: @person.memberships })
    end

    def new_membership_form_html
      AddingAPersonToAProject.new(@viewer, @person, nil).expose_form(@view_context)
    end

    def skills_list_html
      ViewingTaggings.new(@viewer, @person).expose_list(@view_context)
    end

    def skills_adder_html
      CreatingTaggings.new(@viewer, @person, nil, :skills).expose_form(@view_context)
    end

end
