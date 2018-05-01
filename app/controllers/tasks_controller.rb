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
  
# AS OF 2018, TASKS ARE UTILIZING THE GOOGLE CALENDAR API
# A Task model was used when tasks were manually inserted into the DB
# If google calendar fails, please find an older commit to
# reimplement the Task model, controller, and routes.

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

