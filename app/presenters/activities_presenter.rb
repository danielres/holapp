class ActivitiesPresenter < Erector::Widget

  needs :collection, :view_context

  include Support::PresenterHelpers

  def content
      row do
        col(8){ panel{ activities_table(@collection, 'Activities') } }
      end
  end


  private

    def activities_table collection, caption_text
      table('data-purpose' => 'activities-list') do
        caption caption_text
        collection.each do |a|
          tr do
            td.time @view_context.time_ago_in_words(a.created_at) + " ago"
            td.name link_to(a.user, a.user)
            activity_details(a)
          end
        end
      end
    end

    def activity_details(a)
      object_name = a.details['object_name']
      object_type = a.details['object_type'].to_s.downcase
      case a.action
      when 'deleted'
        td "deleted"
        td object_type
        td object_name
      when 'updated'
        td 'updated'
        td "#{ a.details.keys.join(', ')}"
        td.object do
          text link_to(a.object, a.object) if a.object
        end
      when 'added'
        td "added"
        td object_type
        td.object do
          text link_to(a.object, a.object) if a.object
        end
        td
      when 'added_taggings'
        td "tagged on #{ a.details['tag_field'] }"
        td.object do
          text link_to(a.object, a.object) if a.object
        end
        td "#{ a.details['tag_list'].split(',').map{|t| @view_context.link_to_if(Tag.find_by_name(t), t, Tag.find_by_name(t) )}.join(', ') }".html_safe
      when 'merged_tags'
        td "merged tag"
        td a.details['slave_name']
        td.object do
          text @view_context.link_to_if(a.object, a.details['object_name'], a.object)
        end
      else
        td.action a.action.humanize.downcase
      end

    end

end
