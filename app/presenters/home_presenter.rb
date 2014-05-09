class HomePresenter
  def initialize(viewer, view_context)
    @viewer = viewer
    @view_context = view_context
  end
  def to_html
    @view_context.render partial: 'presenters/home_presenter',
                          locals: {
                                 global_view: GlobalViewPresenter.new(@viewer, @view_context).as_html
                          }

  end

end
