class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render layout: true,
             text: ViewingTags.new(current_user).expose_list(view_context)
  end

  def show
    tag = Tag.find(params[:id])
    render inline:  TagPresenter.new(
                            viewer: current_user,
                               tag: tag,
                      view_context: view_context,
                    ).to_html, layout: true
  end

  def update
    tag = Tag.find(params[:id])
    respond_to do |format|
      if tag.update_attributes(tag_params)
        format.json { respond_with_bip(tag) }
      else
        format.json { respond_with_bip(tag) }
      end
    end
  end

  def autocomplete
    string = params[:q].downcase
    tags = Tag.where("lower(name)  LIKE ?", "%#{ string }%").select("name")
    respond_to do |format|
      format.json do
        datums = tags.map{|t| to_datum(t) }.join(', ')
        render text: "[#{ datums }]"
      end
    end
  end

  def to_datum tag
    %Q| { "val":"#{ tag.name }" } |
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

  def merge_tags
    master_tag = Tag.find(params[:tag][:id])
    slave_tag = Tag.find(params[:slave_tag])
    merging_tags = MergingTags.new(current_user, master_tag, slave_tag)
    merging_tags.command(self)
    merging_tags.execute
  end
  def merge_tags_success(master_tag, slave_tag)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  def merge_tags_failure(master_tag, slave_tag)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private

    def tag_params
      params.require(:tag).permit(:description, :name)
    end


end
