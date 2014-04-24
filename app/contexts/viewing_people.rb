class ViewingPeople

  def initialize(viewer)
    @viewer = viewer
    @viewer.extend Viewer
  end

  def expose_list(view_context)
    raise ActionForbiddenError unless @viewer.can_view_people?
    PeoplePresenter.new(@viewer.available_people, view_context).to_html
  end

  private

    module Viewer
      def can_view_people?
        Ability.new(self).can? :read, User
      end
      def available_people
        User.accessible_by(Ability.new(self), :read).to_a
      end
    end

end

