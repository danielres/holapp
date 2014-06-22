class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def show
    person = User.find(params[:id])
    render inline: PersonPresenter.new(viewer: current_user, person: person, view_context: view_context).to_html, layout: true
  end


  def create
    person = User.new(user_params)
    AddingAPerson
      .new(current_user, person)
      .call(
        success: ->{ redirect_to :back, notice: %Q[Person "#{person.name}" has been added successfully] },
        failure: ->{ redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: person }).html_safe },
      )
  end

  def update
    person = User.find(params[:id])
    UpdatingAResource
      .new(current_user, person)
      .with(user_params)
      .call(
        success: ->{ respond_to { |format| format.json { respond_with_bip(person) } } },
        failure: ->{ respond_to { |format| format.json { respond_with_bip(person) } } },
      )
  end

  def destroy
    resource = User.find(params[:id])
    DestroyingAResource
      .new(current_user, resource)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to root_path } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back } } },
      )
  end


  private

    def user_params
      params
        .require(:user)
        .permit(
          :description,
          :email,
          :name,
          :first_name,
          :last_name,
          :display_name,
          :trigram,
          :mobile,
          :cv_url,
        )
    end

end
