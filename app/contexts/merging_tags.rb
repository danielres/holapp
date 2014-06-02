class MergingTags
  def initialize merger, master_tag, slave_tag
    @merger     = merger
    @master_tag = master_tag
    @slave_tag  = slave_tag
    @merger.extend Merger
    @master_tag.extend MasterTag
  end

  def execute
    @merger.merge_tags(@master_tag, @slave_tag,
                      failure: ->{ @controller.try(:merge_tags_failure, @master_tag, @slave_tag) },
                      success: ->{ @controller.try(:merge_tags_success, @master_tag, @slave_tag) }, )
  end

  def command(controller)
    @controller = controller
  end

  def gather_user_input(view_context)
    return unless @merger.can_merge_tags?(@master_tag, @slave_tag)
    view_context.render( render_form_attributes )
  end


  private

    def context_name
      'merging_tags'
    end

    def render_form_attributes
      mergable_tags = ( Tag.all - [@master_tag] ).sort_by(&:name)
      { partial: "contexts/#{ context_name }/form", locals: {mergable_tags: mergable_tags } }
    end

    module Merger
      def merge_tags(master_tag, slave_tag, callbacks = {})
        raise ActionForbiddenError unless can_merge_tags?(master_tag, slave_tag)
        success?(master_tag, slave_tag) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(master_tag, slave_tag)
        master_tag.absorb(slave_tag)
      end
      def can_merge_tags?(master_tag, slave_tag)
        Ability.new(self).can?(:manage, master_tag) && Ability.new(self).can?(:manage, slave_tag)
      end
    end

    module MasterTag
      def absorb(slave_tag)
        transfer_taggings_as_tag(slave_tag)
        transfer_taggings_as_taggable(slave_tag)
        merge_tags_descriptions(slave_tag)
        slave_tag.destroy!
      end
      private
        def transfer_taggings_as_tag(slave_tag)
          taggings = Tagging.where( tag: slave_tag )
          taggings.each do |t|
            t.tag = self
            t.save!
          end
        end
        def transfer_taggings_as_taggable(slave_tag)
          taggings = Tagging.where( taggable: slave_tag )
          taggings.each do |t|
            t.taggable = self
            t.save!
          end
        end
        def merge_tags_descriptions(slave_tag)
          merged_description = [ self.description, slave_tag.description ].join("\n----\n")
          self.update_attributes(description: merged_description)
        end
    end


end
