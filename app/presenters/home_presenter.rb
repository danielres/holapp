class HomePresenter
  def initialize(viewer, view_context)
    @view_context = view_context
    @viewer = viewer
  end
  def to_html
    html = []
    html << HavingAGlobalView.new(@viewer, @view_context).view
    html << AddingAPerson.new(@viewer, @view_context).expose_form
    html << AddingAProject.new(@viewer, @view_context).expose_form
    html.join
  end

  private

    def h
      @view_context
    end

end
