class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def show
    project = Project.find(params[:id])
    render layout: true,
             text: ::ViewingAnEntry.new(current_user, view_context, project).view
  end

end
