class TasksController < ApplicationController
 
  def index
    @tasks = Task.all
  end

  def show
    @task = set_task
  end

   def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to projects_tasks_path(@project), notice: "Task created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @task = set_task
    @project =  Project.find(params[:project_id])
  end
  
  def destroy
    @project = Project.find(params[:project_id])
    @task.destroy
    redirect_to projects_tasks_path(@project)
  end
  
  def update
    @task = set_task
    @project = Project.find(params[:project_id])
    if @task.update(task_params)
      redirect_to project_task_path(@task), notice: "task updated"
    else
      redirect_back fallback_location: project_tasks_path(@task), alert: @task.full_messages.to_sentence
    end
  end
  
  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: "Task deleted"
  end
  
  def change_priority
    priority = params[:priority]
    @project = Project.find(params[:project_id])
    @task = set_task
    @task.update(priority: priority)
    redirect_to  project_task_path(@project,@task), notice: "Priority actualizado con exito"
   rescue => e
      flash.now[:alert] = e.message
      render :show,  status: :unprocessable_entity 
  end
  
  def change_status
    priority = params[:status]
    @project = Project.find(params[:project_id])
    @task = set_task
    @task.update(status: status)
    redirect_to  project_task_path(@project,@task), notice: "Status actualizado con exito"
   rescue => e
      flash.now[:alert] = e.message
      render :show,  status: :unprocessable_entity 
  end
  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :priority,:status)
  end
  
  def set_task
    Task.find(params[:id])
  end

  
end
