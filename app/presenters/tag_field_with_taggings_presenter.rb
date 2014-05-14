class TagFieldWithTaggingsPresenter < Erector::Widget

  needs :taggings, :tag_field, :viewed_from, :view_context

  include Support::PresenterHelpers

  def content(options={})
    table the("#{ @tag_field }-list") do
      caption caption_text
      taggings.each do |tagging|
        tr do
          if show_quantifier?(tagging)
            td.quantifier do
              text best_in_place tagging, :quantifier, collection: quantifier_values, type: :select
            end
          end
          unless @viewed_from == :tag
            td.name do
              text link_to(tagging.tag.name, tagging.tag)
            end
          end
          unless @viewed_from == :taggable
            td.name do
              text  link_to(tagging.taggable.name, tagging.taggable)
            end
          end
          td.description do
            text best_in_place tagging, :description, type: :textarea, nil: '…'
          end
          td.actions do
            li do
              text link_to 'delete', tagging, method: :delete, data: { purpose: 'delete-action', confirm: 'Are you sure ?' }
            end
          end
        end
      end

    end

  end

  private

    def show_quantifier?(tagging)
      true unless tagging.taggable_type == 'Tag'
    end

    def caption_text
      case @viewed_from
      when :tag      then @tag_field.to_s.gsub('parents', 'children')
      when :taggable then @tag_field.to_s
      end.humanize
    end

    def taggings
      @taggings.sort{ |a,b| b.quantifier.to_i <=> a.quantifier.to_i }
    end

    def quantifier_values
      [ [ 0, '—'], [1, '▮▯▯▯▯'], [2, '▮▮▯▯▯'], [3, '▮▮▮▯▯'], [4, '▮▮▮▮▯'], [5, '▮▮▮▮▮'] ]
    end

end
