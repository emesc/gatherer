class ProjectsController < ApplicationController

  def project_data
    render json
  end

  def new
    @project = Project.new
  end
end
