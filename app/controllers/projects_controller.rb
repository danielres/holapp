class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def show
    project = Project.find(params[:id])
    render inline: ProjectPresenter.new(current_user, project, view_context).to_html, layout: true
  end

end
