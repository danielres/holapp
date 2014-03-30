class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    render layout: true,
             text: HomePresenter.new(current_user, view_context).to_html
  end

end

