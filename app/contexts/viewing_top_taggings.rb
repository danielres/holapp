class ViewingTopTaggings

  def initialize(viewer)
    @viewer = viewer
    @viewer.extend Viewer
  end

  def expose_lists(view_context)
    [
      expose_list(:skills     , view_context),
      expose_list(:motivations, view_context),
    ].map{|t| "<div class='panel'>#{ t }</div>"}.join.html_safe
  end

  private

    def expose_list(tag_field, view_context)
      tag_field = tag_field.to_s
      output = []
      output << "<div data-purpose='top-#{ tag_field }'>"
      output << "<h2>Top #{ tag_field }<h2>"
      @viewer.available_taggings(tag_field)
        .group_by(&:taggable_type)
        .each do |taggable_type, taggings|

          output << "<h3>#{ taggable_type.pluralize }</h3>"
          output << "<table>"

          taggings.select{ |t| t.context == tag_field }
                  .select{ |t| t.quantifier > 3 }
                  .group_by(&:tag)
                  .each do |tag, taggings|
                    output << "<tr>"
                    output << "<td>#{ tag.name }</td>"
                    output << "<td>"
                    output << taggings.sort{|a,b| b.quantifier <=> a.quantifier }.map{ |t|
                      taggable = taggable_type.constantize.find(t.taggable_id)
                      "#{ view_context.link_to(taggable.name, taggable) } <small>(#{ t.quantifier })</small>"
                    }.join(', ')
                    output << "</td>"
                    output << "</tr>"
                  end

          output << "</table>"

      end
      output << "</div>"
      output.join.html_safe
    end


    module Viewer
      def can_view_taggings?
        Ability.new(self).can? :read, Tagging
      end
      def available_taggings(tag_field)
        Tagging
          .accessible_by(Ability.new(self), :read)
          .where(context: tag_field)
          .where("quantifier > ?", 3)
      end
    end

end

