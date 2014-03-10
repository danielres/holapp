class TagPresenter

  def initialize(viewer, tag, view_context)
    @viewer = viewer
    @tag = tag
    @view_context = view_context
  end

  def to_html
    h.render(partial: 'presenters/tag_presenter/tag', locals: {tag: @tag, })
  end

  private

    def h
      @view_context
    end

end
