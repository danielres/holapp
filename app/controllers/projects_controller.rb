class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def show
    project = Project.find(params[:id])
    render inline: ProjectPresenter.new(viewer: current_user, project: project, view_context: view_context).to_html, layout: true
  end


  def create
    project = Project.new(project_params)
    AddingAProject
      .new(current_user, project)
      .call(
        success: ->{ redirect_to :back, notice: %Q[project "#{project.name}" has been added successfully] },
        failure: ->{ redirect_to :back, alert: render_to_string(partial: 'shared/errors', locals: { object: project }).html_safe },
      )
  end

  def update
    project = Project.find(params[:id])
    UpdatingAResource
      .new(current_user, project)
      .with(project_params)
      .call(
        success: ->{ respond_to { |format| format.json { respond_with_bip(project) } } },
        failure: ->{ respond_to { |format| format.json { respond_with_bip(project) } } },
      )
  end

  def destroy
    resource = Project.find(params[:id])
    DestroyingAResource
      .new(current_user, resource)
      .call(
        success: ->{ respond_to { |format| format.html { redirect_to root_path } } },
        failure: ->{ respond_to { |format| format.html { redirect_to :back } } },
      )
  end


  private

    def project_params
      params.require(:project).permit(:name, :description, :starts_at, :ends_at)
    end


end
