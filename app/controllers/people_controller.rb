class PeopleController < ApplicationController
  before_filter :authenticate_user!

  def show
    person = User.find(params[:id])
    render inline: PersonPresenter.new(viewer: current_user, person: person, view_context: view_context).to_html, layout: true
  end


  def create
    adding_a_person = AddingAPerson.new(current_user)
    adding_a_person.command(self)
    adding_a_person.execute(user_params)
  end
  def create_failure(person)
    redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: person }).html_safe
  end
  def create_success(person)
    redirect_to :back, notice: %Q[Person "#{person.name}" has been added successfully]
  end


  def update
    person = User.find(params[:id])
    updating_a_person = UpdatingAPerson.new(current_user, person)
    updating_a_person.command(self)
    updating_a_person.execute(user_params)
  end
  def update_failure(person)
    respond_to do |format|
      format.json { respond_with_bip(person) }
    end
  end
  def update_success(person)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def destroy
    person = User.find(params[:id])
    destroying_a_person = DestroyingAPerson.new(current_user, person)
    destroying_a_person.command(self)
    destroying_a_person.execute
  end
  def destroy_failure(person)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  def destroy_success(person)
    respond_to do |format|
      format.html { redirect_to root_path }
    end
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
        )
    end

end
