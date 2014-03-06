class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def show
    person = User.find(params[:id])
    render inline: PersonPresenter.new(current_user, person, view_context).to_html, layout: true
  end

  def create
    adding_a_person = AddingAPerson.new(current_user, self)
    adding_a_person.command(self)
    adding_a_person.add(user_params)
  end

  def failure(person)
    redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: person }).html_safe
  end

  def success(person)
    redirect_to :back, notice: %Q[Person "#{person.name}" has been added successfully]
  end

  def update
    person = User.find(params[:id])
    respond_to do |format|
      if person.update_attributes(user_params)
        format.json { head :ok }
      else
        format.json { respond_with_bip(person) }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :description)
    end

end
