class TasksController < ApplicationController
  # Minimal show for HTML redirects
  def show
    @task = Task.find(params[:id])
  end

   def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "Task created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def start    ; update_status(:in_progress) ; end
  def pause    ; update_status(:paused)      ; end
  def review   ; update_status(:under_review); end
  def cancel   ; update_status(:cancelled)   ; end
  def complete ; update_status(:completed)   ; end

  def prioritize_normal     ; update_priority(:normal)     ; end
  def prioritize_irrelevant ; update_priority(:irrelevant) ; end
  def prioritize_important  ; update_priority(:important)  ; end
  def prioritize_critical   ; update_priority(:critical)   ; end

  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :priority)
  end

  def update_status(target)
    task = Task.find(params[:id])
    if task.update(status: target)
      redirect_to task_path(task), notice: "Task updated"
    else
      redirect_back fallback_location: task_path(task), alert: task.errors.full_messages.to_sentence
    end
  end

  def update_priority(target)
    task = Task.find(params[:id])
    if task.update(priority: target)
      redirect_to task_path(task), notice: "Priority updated"
    else
      redirect_back fallback_location: task_path(task), alert: task.errors.full_messages.to_sentence
    end
  end
end
