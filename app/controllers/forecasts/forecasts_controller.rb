module Forecasts

  class ForecastsController < ApplicationController

    before_filter :authenticate_user!

    def index
      start_date = Date.parse params[:start_date] || DateTime.now.to_s
      @forecast  = Forecast.new(starting_from_month: start_date )
      @people    = User.listable
    end

  end
end
