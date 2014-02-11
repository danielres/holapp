class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @global_view = ::HavingAGlobalView.new(current_user).view
  end

end
