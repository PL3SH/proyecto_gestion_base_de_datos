class Tasks::AssignmentsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    employer_id = params.require(:employer_id)

    unless Employer.exists?(employer_id)
      redirect_back fallback_location: task_path(task), alert: "Employer not found"
      return
    end

    if task.employer_ids.include?(employer_id.to_i)
      redirect_back fallback_location: task_path(task), alert: "Already assigned"
      return
    end

    task.employer_tasks.create!(employer_id: employer_id)
    redirect_to task_path(task), notice: "Employer assigned"
  end

  def destroy
    task = Task.find(params[:task_id])
    employer_id = params[:employer_id]
    join = task.employer_tasks.find_by(employer_id: employer_id)
    unless join
      redirect_back fallback_location: task_path(task), alert: "Assignment not found"
      return
    end

    join.destroy
    redirect_to task_path(task), notice: "Employer unassigned"
  end
end
