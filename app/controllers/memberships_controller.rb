class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    person = User.find params[:membership][:user_id]
    project = Project.find params[:membership][:project_id]
    adding_a_person_to_a_project = AddingAPersonToAProject.new(current_user, person, project, self)
    adding_a_person_to_a_project.command(self)
    adding_a_person_to_a_project.add
  end

  def failure(membership)
    redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: membership }).html_safe
  end

  def success(membership)
    redirect_to :back, notice: %Q[#{membership.user} has been successfully added as a member of #{membership.project}]
  end

  private

    def user_params
      params.require(:membership).permit(:user_id, :project_id)
    end

end
