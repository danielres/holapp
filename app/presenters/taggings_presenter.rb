class TaggingsPresenter
  def initialize(tagging_or_taggings, tag_field, view_context)
    @taggings = Array(tagging_or_taggings)
    @view_context = view_context
    @tag_field = tag_field
  end

  def to_html(options={})
    @viewed_from = options[:viewed_from]
    @view_context.render(
      partial: 'presenters/shared/table',
      locals: { purpose: "#{ @tag_field }-list",
                 header: @tag_field.capitalize,
                  items: taggings_html,
              }
    )
  end


  private

    def taggings_html
      @view_context.render(
        collection: @taggings,
           partial: 'presenters/taggings_presenter/tagging',
            locals: {
              quantifier_values: quantifier_values,
              viewed_from: @viewed_from,
            },
      )
    end

    def quantifier_values
      [ [ 0, '—'], [1, '▮▯▯▯▯'], [2, '▮▮▯▯▯'], [3, '▮▮▮▯▯'], [4, '▮▮▮▮▯'], [5, '▮▮▮▮▮'] ]
    end

end
