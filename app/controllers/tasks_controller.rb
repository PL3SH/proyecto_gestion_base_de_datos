class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :change_priority, :change_status]
  before_action :set_project, only: [:new, :show, :edit, :update, :destroy, :change_priority, :change_status]
 
  def index
    @tasks = Task.all
  end

  def show
    @task
  end

   def new
    @task = @project.tasks.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_tasks_path(@project), notice: "Task created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @project
  end
  
  def destroy
    @task.destroy
    redirect_to projects_tasks_path(@project), notice: "Tarea eliminada correctamente"
  end
  
  def update

    if @task.update(task_params)
      redirect_to project_task_path(@task), notice: "task updated"
    else
      redirect_back fallback_location: project_tasks_path(@task), alert: @task.full_messages.to_sentence
    end
  end
  
  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project)
  end
  
  def change_priority
    priority = params[:priority]
    @task.update(priority: priority)
    redirect_to  project_task_path(@project,@task), notice: "Priority actualizado con exito"
   rescue => e
      flash.now[:alert] = e.message
      render :show,  status: :unprocessable_entity 
  end
  
  def change_status
    status = params[:status]
    @task.update(status: status)
    redirect_to  project_task_path(@project,@task), notice: "Status actualizado con exito"
  rescue => e
     flash.now[:alert] = e.message
     render :show,  status: :unprocessable_entity 
  end
  
  
  
  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :priority, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  def set_project
    @project = Project.find(params[:project_id])
  end
  
end
