class ProjectsController < ApplicationController
def index
  @project = Project.all
end
  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end
def update
  @project = Project.find(params[:id])
  if @project.update(project_params)
    redirect_to project_path(@project), notice: "Project updated"
  else
    redirect_back fallback_location: project_path(@project), alert: @project.full_messages.to_sentence
  end
end
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: "Project created"
    else
      render :new, status: :unprocessable_entity
    end
  end

 def change_status
  status = params[:status]
  @project= Project.find(params[:id])
  @project.update(status: status)
  redirect_to  project_path(@project), notice: "estado actualizado con exito"
 rescue => e
    flash.now[:alert] = e.message
    render :show,  status: :unprocessable_entity
 end

  private

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date, :status)
  end

  def update_status(target)
    project = Project.find(params[:id])
    if project.update(status: target)
      redirect_to project_path(project), notice: "Project updated"
    else
      redirect_back fallback_location: project_path(project), alert: project.errors.full_messages.to_sentence
    end
  end
end
