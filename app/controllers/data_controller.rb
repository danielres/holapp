class DataController < ApplicationController



  def complex
    @items = ::News::Fetcher.new(current_user, params[:filter]).call
  end


end
