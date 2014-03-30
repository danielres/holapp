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
    create_taggings.execute
  end
  def failure
    redirect_to :back, alert: 'Could not apply tags'
  end
  def success
    redirect_to :back, notice: 'Tags applied successfully'
  end


  def update
    tagging = Tagging.find(params[:id])
    updating_a_tagging = UpdatingATagging.new(current_user, tagging)
    updating_a_tagging.command(self)
    updating_a_tagging.execute(tagging_params)
  end
  def update_failure(tagging)
    respond_to do |format|
      format.json { respond_with_bip(tagging) }
    end
  end
  def update_success(tagging)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

    def tagging_params
      params.require(:tagging).permit(:description, :quantifier)
    end


end
