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


# require_relative "../helpers/google_calender_module_helper.rb"

class TasksController < ApplicationController
  load_and_authorize_resource
  # require_relative "../helpers/google_calender_module_helper.rb"
  

  before_action :set_event_list
  
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

  # def complete
  #   @task.is_completed = true
    # @task.save
    # redirect_to :back, notice: 'The task was successfully completed'
  # end

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
    task.color_id = "2"
    @calendar.update_event(GoogleCalendarHelper::CALENDAR_ID, task.id, task)
    redirect_to :back, notice: 'The task was successfully completed'
  end


  def uncomplete
    id = params[:task_id]
    task = @calendar.get_event(GoogleCalendarHelper::CALENDAR_ID, id)
    task.color_id = "1"
    @calendar.update_event(GoogleCalendarHelper::CALENDAR_ID, task.id, task)
    redirect_to :back, notice: 'The task was successfully uncompleted'
  end



  private

  def set_event_list
    # Initialize the API via our helper
    @calendar_helper = GoogleCalendarHelper.new
    @calendar = @calendar_helper.calendar

    # List all calendars that the service account has access to
    page_token = nil
    begin
      result = @calendar.list_calendar_lists(page_token: page_token)
      if result.items.empty?
      puts "No access to any calendar!"
      else
      result.items.each do |c|
        puts "CAL: #{c.summary}"
      end
      if result.next_page_token != page_token
        page_token = result.next_page_token
      else
        page_token = nil
      end
      end
    end while !page_token.nil?

    response = @calendar.list_events(GoogleCalendarHelper::CALENDAR_ID,
                                  max_results: 10,
                                  single_events: true,
                                  order_by: 'startTime',
                                  time_min: Time.now.iso8601)

    @event_list = response
  end




  def task_params
    params.require(:task).permit(:name, :due_at, :completed_by_id, :is_completed, :description)
  end
end

