class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: %i[ show edit update destroy ]
  def index
    @project = Project.all 
  end
  def show
    @project = set_project
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end
def edit
  @project = set_project
end
def update
  @project = set_project
  if @project.update(project_params)
    redirect_to project_path(@project), notice: "Project updated"
  else
    redirect_back fallback_location: project_path(@project), alert: @project.full_messages.to_sentence
  end
end
  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: "Project created"
    else
      render :new, status: :unprocessable_entity
    end
  end

 def change_status
  status = params[:status]
  @project= set_project
  @project.update(status: status)
  redirect_to  project_path(@project), notice: "estado actualizado con exito"
 rescue => e
    flash.now[:alert] = e.message
    render :show,  status: :unprocessable_entity
 end

 
 def destroy
     @project.destroy
     redirect_to projects_path
 end
  private

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date, :status)
  end

  def update_status(target)
    project = set_project
    if project.update(status: target)
      redirect_to project_path(project), notice: "Project updated"
    else
      redirect_back fallback_location: project_path(project), alert: project.errors.full_messages.to_sentence
    end
  end
  def set_project
   @project = current_user.projects.find(params[:id])
  end

end
