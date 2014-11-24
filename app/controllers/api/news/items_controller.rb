class Api::News::ItemsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :json

    def index
      @items = ::News::Fetcher
                  .new(current_user, params[:filter])
                  .call
    end

    def create
      item        = ::News::Item.new(resource_params)
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
        ::News::Item.find(params[:id])
      end

      def resource_params
        params
          .permit(
            :summary,
            :body,
            :language,
          )
      end

end
