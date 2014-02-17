class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    render layout: true,
             text: ::HavingAGlobalView.new(current_user, view_context).view
  end

end
