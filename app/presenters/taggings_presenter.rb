class TaggingsPresenter < Erector::Widget

  needs :taggings, :tag_field, :view_context

  include Support::PresenterHelpers

  def content(options={})
    @viewed_from = options[:viewed_from]
    table the("#{ @tag_field }-list") do
      caption @tag_field.capitalize
      @taggings.each do |tagging|
        tr do
          td.quantifier do
            text best_in_place tagging, :quantifier, collection: quantifier_values, type: :select
          end
          unless @viewed_from == :tag
            td.name do
              text @view_context.link_to(tagging.tag.name, tagging.tag)
            end
          end
          unless @viewed_from == :taggable
            td.name do
              text  @view_context.link_to(tagging.taggable.name, tagging.taggable)
            end
          end
          td.description do
            text best_in_place tagging, :description, type: :textarea, nil: '…'
          end
          td.actions do
            li do
              text @view_context.link_to 'delete', tagging, method: :delete, data: { purpose: 'delete-action', confirm: 'Are you sure ?' }
            end
          end
        end
      end

    end

  end

  private

    def quantifier_values
      [ [ 0, '—'], [1, '▮▯▯▯▯'], [2, '▮▮▯▯▯'], [3, '▮▮▮▯▯'], [4, '▮▮▮▮▯'], [5, '▮▮▮▮▮'] ]
    end

end
