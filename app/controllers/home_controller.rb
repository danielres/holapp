class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    render text: GlobalViewPresenter.new(
                          viewer: current_user,
                    view_context: view_context,
                  ).to_html,
                  layout: true
  end

end

