class UserConfigsController < ApplicationController
  def index
    render locals: {
      panels:
      [
        News::UserConfig.first_or_create(user: current_user),
      ]
    }
  end
end
