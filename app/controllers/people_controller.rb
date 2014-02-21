class PeopleController < ApplicationController
  before_filter :authenticate_user!

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

  private

    def user_params
      params.require(:user).permit(:name)
    end

end
