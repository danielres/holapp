class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render layout: true,
             text: ViewingTags.new(current_user).view_context(view_context).call
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
    DestroyingAResource
      .new(current_user, tag)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to tags_path } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back     } } },
      )
  end

  def merge_tags
    master_tag = Tag.find(params[:tag][:id])
    slave_tag = Tag.find(params[:slave_tag])
    MergingTags
      .new(current_user, master_tag, slave_tag)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to :back } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back } } },
      )
  end

  private

    def tag_params
      params.require(:tag).permit(:description, :name)
    end


end
