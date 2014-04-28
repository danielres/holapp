class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    person = User.find params[:membership][:user_id]
    project = Project.find params[:membership][:project_id]
    adding_a_membership = AddingAMembership.new(current_user, person, project)
    adding_a_membership.command(self)
    adding_a_membership.execute
  end
  def create_failure(membership)
    redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: membership }).html_safe
  end
  def create_success(membership)
    redirect_to :back, notice: %Q[#{membership.user} has been successfully added as a member of #{membership.project}]
  end


  def update
    membership = Membership.find(params[:id])
    updating_a_membership = UpdatingAMembership.new(current_user, membership)
    updating_a_membership.command(self)
    updating_a_membership.execute(membership_params)
  end
  def update_failure(membership)
    respond_to do |format|
      format.json { respond_with_bip(membership) }
    end
  end
  def update_success(membership)
    respond_to do |format|
      format.json { head :ok }
    end
  end


  def destroy
    membership = Membership.find(params[:id])
    destroying_a_membership = DestroyingAMembership.new(current_user, membership)
    destroying_a_membership.command(self)
    destroying_a_membership.execute
  end
  def destroy_failure(membership)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  def destroy_success(membership)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end


  private

    def membership_params
      params.require(:membership).permit(:user_id, :project_id, :description)
    end

end
