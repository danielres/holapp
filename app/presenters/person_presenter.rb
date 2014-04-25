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
         motivations_list: motivations_list_html,
        motivations_adder: motivations_adder_html,
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
      AddingAMembership.new(@viewer, @person, nil).gather_user_input(@view_context)
    end

    def skills_list_html
      ViewingATaggableTaggings.new(@viewer, @person).expose_list(:skills, @view_context)
    end

    def skills_adder_html
      AddingTaggings.new(@viewer, @person, nil, :skills).gather_user_input(@view_context)
    end

    def motivations_list_html
      ViewingATaggableTaggings.new(@viewer, @person).expose_list(:motivations, @view_context)
    end

    def motivations_adder_html
      AddingTaggings.new(@viewer, @person, nil, :motivations).gather_user_input(@view_context)
    end

end
