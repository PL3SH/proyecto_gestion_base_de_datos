class Tasks::EmployersController < ApplicationController
  def index
    @task = Task.find(params[:task_id])
    @employers = @task.employers
  end
end
