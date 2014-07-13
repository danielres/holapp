class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  def show
    membership = Membership.find(params[:id])
    redirect_to membership.person
  end

  def create
    person     = User.find params[:membership][:user_id]
    project    = Project.find params[:membership][:project_id]
    membership =  Membership.new(person: person, project: project)
    AddingAResource
      .new(current_user, membership)
      .call(
        success: ->{ redirect_to :back, notice: "#{ person } has been successfully added as a member of #{ project }" },
        failure: ->{ redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: membership }).html_safe },
        )
  end

  def update
    membership = Membership.find(params[:id])
    UpdatingAResource
      .new(current_user, membership)
      .with(membership_params)
      .call(
        success: ->{ respond_to { |format| format.json { respond_with_bip(membership) } } },
        failure: ->{ respond_to { |format| format.json { head :ok } } },
      )
  end

  def destroy
    resource = Membership.find(params[:id])
    DestroyingAResource
      .new(current_user, resource)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to :back } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back } } },
      )
  end


  private

    def membership_params
      params.require(:membership).permit(:user_id, :project_id, :description)
    end

end
