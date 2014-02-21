class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def create
    adding_a_person = AddingAPerson.new(current_user, self, user_params)
    adding_a_person.add
    redirect_to :back
  end

  private

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
