class PeoplePresenter

  def initialize(person_or_people, view_context)
    @people = Array(person_or_people)
    @view_context = view_context
  end

  def to_html
    h.render partial: 'presenters/people_presenter',
              locals: { people: @people }
  end

  private

    def h
      @view_context
    end

end
