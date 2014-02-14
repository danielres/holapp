class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @global_view = ::HavingAGlobalView.new(current_user, view_context).view
  end

end
