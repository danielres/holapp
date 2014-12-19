class Api::News::ItemsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :json

    def index
      @items = ::News::Fetcher
                  .new(current_user, params[:filter])
                  .call
    end

    def create
      AddingAResource
        .new(current_user, new_resource)
        .call(
          success: ->{ respond_with(new_resource.tap(&:save)) },
          failure: ->{ },
        )
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
          .require(:item)
          .permit(
            :summary,
            :body,
            :language,
          )
      end

    def new_resource
      resource = ::News::Item.new(resource_params)
      resource.author = current_user
      resource
    end


end
