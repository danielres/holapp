class TagsController < ApplicationController
  before_filter :authenticate_user!

  def show
    tag = Tag.find(params[:id])
    render inline: TagPresenter.new(current_user, tag, view_context).to_html, layout: true
  end

  def update
    tag = Tag.find(params[:id])
    respond_to do |format|
      if tag.update_attributes(tag_params)
        format.json { head :ok }
      else
        format.json { respond_with_bip(tag) }
      end
    end
  end

  private

    def tag_params
      params.require(:tag).permit(:description)
    end


end
