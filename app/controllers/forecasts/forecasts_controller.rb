module Forecasts

  class ForecastsController < ApplicationController

    before_filter :authenticate_user!

    def index
      start_date = Date.new(params[:start_year].to_i, params[:start_month].to_i)
      @forecast  = Forecast.new(
                      starting_from_month: start_date,
                                   months: params[:months_duration].to_i,
                              periodicity: params[:periodicity]
                   )
      @people    = User.listable
    end

  end
end
