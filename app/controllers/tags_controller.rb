class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render layout: true,
             text: ViewingTags.new(current_user).expose_list(view_context)
  end

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

  def autocomplete
    string = params[:q]
    tags = Tag.where("name LIKE ?", "%#{ string }%").select("name")
    respond_to do |format|
      format.json { render inline: tags.to_json }
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    destroying_a_tag = DestroyingATag.new(current_user, tag)
    destroying_a_tag.command(self)
    destroying_a_tag.execute
  end
  def destroy_failure(tag)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  def destroy_success(tag)
    respond_to do |format|
      format.html { redirect_to tags_path }
    end
  end


  private

    def tag_params
      params.require(:tag).permit(:description)
    end


end
