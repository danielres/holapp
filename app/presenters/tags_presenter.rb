class TagsPresenter
  def initialize(user, tag_or_tags, view_context)
    @tags = Array(tag_or_tags)
    @view_context = view_context
  end

  def to_html
    h.render partial: 'presenters/tags_presenter',
              locals: { tags: @tags }
  end

  private

    def h
      @view_context
    end

end
