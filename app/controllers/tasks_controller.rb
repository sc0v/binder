# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`completed_by_id`**  | `integer`          |
# **`created_at`**       | `datetime`         |
# **`description`**      | `text`             |
# **`due_at`**           | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`is_completed`**     | `boolean`          |
# **`name`**             | `string`           |
# **`updated_at`**       | `datetime`         |
#


class TasksController < ApplicationController
  load_and_authorize_resource
  

  # GET /tasks
  # GET /tasks.json
  # def index
  #   if(params[:task_filter].blank?)
  #     @tasks = Task.all
  #   elsif(params[:task_filter] == "completed_tasks")
  #     @tasks = Task.is_complete
  #   elsif(params[:task_filter] == "incomplete_tasks")
  #     @tasks = Task.is_incomplete
  #   end
  # end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
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


  def index
  end


  def complete
    id = params[:task_id]
    task = @calendar.get_event(GoogleCalendarHelper::CALENDAR_ID, id)
    # a task with a color id of "2" is complete
    task.color_id = "2"
    @calendar.update_event(GoogleCalendarHelper::CALENDAR_ID, task.id, task)
    redirect_to :back, notice: 'The task was successfully completed'
  end


  def uncomplete
    id = params[:task_id]
    task = @calendar.get_event(GoogleCalendarHelper::CALENDAR_ID, id)
    # any task that does not have a color if of 2 is incomplete
    task.color_id = "1"
    @calendar.update_event(GoogleCalendarHelper::CALENDAR_ID, task.id, task)
    redirect_to :back, notice: 'The task was successfully uncompleted'
  end


  private

  def task_params
    params.require(:task).permit(:name, :due_at, :completed_by_id, :is_completed, :description)
  end
end

