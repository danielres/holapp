class HomePresenter
  def initialize(viewer, view_context)
    @viewer = viewer
    @view_context = view_context
  end
  def to_html
    @view_context.render partial: 'presenters/home_presenter',
                          locals: {
                                 global_view: HavingAGlobalView.new(@viewer).view(@view_context),
                             adding_a_person: AddingAPerson.new(@viewer).gather_user_input(@view_context),
                            adding_a_project: AddingAProject.new(@viewer).gather_user_input(@view_context),
                          }

  end

end
