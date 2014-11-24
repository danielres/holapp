module News
  class ItemsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :json, :html

    def show
      render inline: ItemPresenter
                      .new(viewer: current_user, item: resource, view_context: view_context)
                      .to_html,
                      layout: true
    end

    def index
      respond_to do |format|
        format.html
        format.json do
          @items = Fetcher.new(current_user, params[:filter]).call
        end
      end
    end

    def create
      item = Item.new(resource_params)
      item.author = current_user
      item.save!
      respond_with item
    end

    def destroy
      respond_to do |format|
        format.html do
          redirect_to news_path if resource.destroy
        end
        format.json do
          respond_with resource.destroy
        end
      end
    end

    def update
      respond_with resource.update(resource_params)
    end

    private

      def interesting?(news_item)
        ( current_user.taggings.map(&:tag) & news_item.taggings.map(&:tag) ).any?
      end

      def resource
        Item.find(params[:id])
      end

      def resource_params
        params
          .permit(
            :summary,
            :body,
            :language
          )
      end

  end
end
