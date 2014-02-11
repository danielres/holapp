class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    render text: ::ViewingProjects.new(current_user).view
  end

end
