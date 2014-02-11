class ViewingPeople

  def initialize(user)
    @viewer = user
    @viewer.extend Viewer
  end

  def view
    render(@viewer.people)
  end

  private

    module Viewer
      def people
        User.accessible_by(Ability.new(self), :read)
      end
    end

    def render(person_or_people)
      PeoplePresenter.new(person_or_people).as_html
    end

    class PeoplePresenter
      def initialize(person_or_people)
        @people = Array(person_or_people)
      end
      def as_html
        "<section>People <ul>#{ list_items }</ul> </section>"
      end
      private
        def list_items
          @people.map{ |p| "<li>#{p.name}</li>" }.join
        end
    end

end
