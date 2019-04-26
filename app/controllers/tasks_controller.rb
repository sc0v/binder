# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`completed_by_id`**  | `integer`          |
# **`created_at`**       | `datetime`         |
# **`description`**      | `text(65535)`      |
# **`due_at`**           | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`is_completed`**     | `boolean`          |
# **`name`**             | `string(255)`      |
# **`updated_at`**       | `datetime`         |
#

class TasksController < ApplicationController
  load_and_authorize_resource
  
  # GET /tasks
  # GET /tasks.json
  def index
    if(params[:task_filter].blank?)
      @tasks = Task.active
    elsif(params[:task_filter] == "completed_tasks")
      @tasks = Task.active.is_complete
    elsif(params[:task_filter] == "incomplete_tasks")
      @tasks = Task.active.is_incomplete
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  def complete
    @task.is_completed = true
    @task.save
    redirect_to :back, notice: 'The task was successfully completed'
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.save
    respond_with(@task)
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
    respond_with(@task)
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_with(@task)
  end

  private

  def task_params
    params.require(:task).permit(:name, :due_at, :completed_by_id, :is_completed, :description)
  end
end

