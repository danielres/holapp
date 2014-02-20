class HomePresenter
  def initialize(viewer, view_context)
    @view_context = view_context
    @viewer = viewer
  end
  def to_html
    ::HavingAGlobalView.new(@viewer, @view_context).view
  end
end
