module News
  class ItemsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :json, :html

    def index
      respond_to do |format|
        format.html
        format.json { render json: News::Item.all }
      end
    end

    def create
      respond_with Item.create(resource_params)
    end

    def destroy
      respond_with resource.destroy
    end

    private

      def resource
        Item.find(params[:id])
      end

      def resource_params
        params
          .require(:item)
          .permit(
            :summary,
            :body
          )
      end

  end
end
