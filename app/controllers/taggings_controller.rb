class TaggingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    taggable_id   = params[:tagging][:taggable_id]
    taggable_type = params[:tagging][:taggable_type]
    tag_list      = params[:tagging][:tag_list]
    tag_field     = params[:tagging][:tag_field]
    tagger        = current_user
    taggable      = taggable_type.constantize.find(taggable_id)
    AddingTaggings
      .new(tagger, taggable, tag_list, tag_field)
      .call(
        success: ->{ redirect_to :back, notice: 'Tags applied successfully' },
        failure: ->{ redirect_to :back, alert:  'Could not apply tags'      },
      )
  end


  def update
    tagging = Tagging.find(params[:id])
    UpdatingAResource
      .new(current_user, tagging)
      .with(tagging_params)
      .call(
        success: ->{ respond_to { |format| format.json { head :ok                  } } },
        failure: ->{ respond_to { |format| format.json { respond_with_bip(tagging) } } },
      )
  end

  def destroy
    resource = Tagging.find(params[:id])
    DestroyingAResource
      .new(current_user, resource)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to :back } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back } } },
      )
  end


  private

    def tagging_params
      params.require(:tagging).permit(:description, :quantifier)
    end


end
