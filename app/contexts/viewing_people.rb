class ViewingPeople

  def initialize(viewer)
    @viewer = viewer
    @viewer.extend Viewer
  end

  def expose_list(view_context)
    PeoplePresenter.new(@viewer.available_people, view_context).to_html
  end

  private

    module Viewer
      def available_people
        User.accessible_by(Ability.new(self), :read)
      end
    end

end

