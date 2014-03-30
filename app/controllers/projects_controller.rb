class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def show
    project = Project.find(params[:id])
    render inline: ProjectPresenter.new(current_user, project, view_context).to_html, layout: true
  end


  def create
    adding_a_project = AddingAProject.new(current_user)
    adding_a_project.command(self)
    adding_a_project.execute(project_params)
  end
  def failure(project)
    redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: project }).html_safe
  end
  def success(project)
    redirect_to :back, notice: %Q[project "#{project.name}" has been added successfully]
  end


  def update
    project = Project.find(params[:id])
    updating_a_project = UpdatingAProject.new(current_user, project)
    updating_a_project.command(self)
    updating_a_project.execute(project_params)
  end
  def update_failure(project)
    respond_to do |format|
      format.json { respond_with_bip(project) }
    end
  end
  def update_success(project)
    respond_to do |format|
      format.json { head :ok }
    end
  end



  private

    def project_params
      params.require(:project).permit(:name, :description)
    end


end
