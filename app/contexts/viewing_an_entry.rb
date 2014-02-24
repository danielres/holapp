# class ViewingAnEntry

#   def initialize(viewer, view_context, entry)
#     @viewer = viewer
#     @entry = entry
#     @view_context = view_context
#     @viewer.extend Viewer
#     @entry.extend Taggable
#   end

#   def view
#     @viewer.can_view?(@entry) ? h.render(@entry) : ''
#   end

#   private

#     def h
#       @view_context
#     end

#     module Viewer
#       def can_view? viewable
#         Ability.new(self).can? :read, viewable
#       end
#     end

#     module Taggable
#       def self.extended(base)
#         base.class.class_eval do
#           acts_as_taggable_on
#         end
#       end
#     end

# end
