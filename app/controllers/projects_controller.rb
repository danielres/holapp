class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def show
    project = Project.find(params[:id])
    render inline: ProjectPresenter.new(viewer: current_user, project: project, view_context: view_context).to_html, layout: true
  end


  def create
    adding_a_project = AddingAProject.new(current_user)
    adding_a_project.command(self)
    adding_a_project.execute(project_params)
  end
  def create_failure(project)
    redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: project }).html_safe
  end
  def create_success(project)
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
      format.json { respond_with_bip(project) }
    end
  end

  def destroy
    project = Project.find(params[:id])
    destroying_a_project = DestroyingAProject.new(current_user, project)
    destroying_a_project.command(self)
    destroying_a_project.execute
  end
  def destroy_failure(project)
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  def destroy_success(project)
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end




  private

    def project_params
      params.require(:project).permit(:name, :description, :starts_at, :ends_at)
    end


end
