class HomePresenter
  def initialize(viewer, view_context)
    @viewer = viewer
    @view_context = view_context
  end
  def to_html
    html = []
    html << HavingAGlobalView.new(@viewer).view(@view_context)
    html << AddingAPerson.new(@viewer).expose_form(@view_context)
    html << AddingAProject.new(@viewer).expose_form(@view_context)
    html.join
  end

end
