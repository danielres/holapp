module News
  class ItemsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :json, :html

    def index
      respond_to do |format|
        format.html
        format.json do
          if params[:filter] == 'interesting'
            @items = Item.all.select{ |i| interesting?(i) }
          else
            @items = Item.all
          end
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
      respond_with resource.destroy
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
