class HavingAGlobalView
  def initialize(user)
    @user = user
  end
  def view(view_context)
    GlobalViewPresenter.new(@user, view_context).as_html
  end

end

