class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    render text: ::HavingAGlobalView.new(current_user).view
  end

end
