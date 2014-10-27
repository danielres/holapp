module News
  class ItemsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :json, :html

    def index
      @items = Item.all
      respond_to do |format|
        format.html
        format.json
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
