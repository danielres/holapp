class TagPresenter

  def initialize(viewer, tag, view_context)
    @viewer = viewer
    @tag = tag
    @view_context = view_context
  end

  def to_html
    h.render(partial: 'presenters/tag_presenter/tag',
      locals: {
        tag: @tag,
        taggables: taggables,
        })
  end

  private

    def taggables
      ViewingATagTaggings.new(@viewer, @tag).expose_taggings_by_taggable_types(@view_context)
    end

    def h
      @view_context
    end

end
