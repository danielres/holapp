class PeoplePresenter
  def initialize(person_or_people, view_context)
    @people = Array(person_or_people)
    @view_context = view_context
  end
  def as_html
    "<section>People <ul>#{ list_items }</ul> </section>"
  end
  private
    def list_items
      @people.map{ |p| "<li>#{p.name}</li>" }.join
    end
end
