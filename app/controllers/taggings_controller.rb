class TaggingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    taggable_id   = params[:tagging][:taggable_id]
    taggable_type = params[:tagging][:taggable_type]
    tag_list      = params[:tagging][:tag_list]
    tag_field     = params[:tagging][:tag_field]
    tagger        = current_user
    taggable      = taggable_type.constantize.find(taggable_id)
    create_taggings = CreatingTaggings.new(tagger, taggable, tag_list, tag_field)
    create_taggings.command(self)
    create_taggings.tag
  end

  def failure
    redirect_to :back, alert: 'Could not apply tags'
  end

  def success
    redirect_to :back, notice: 'Tags applied successfully'
  end

end
