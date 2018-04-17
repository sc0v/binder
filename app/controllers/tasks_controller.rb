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

  # before_action :set_event_list
  
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

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to calendars_url
  end

  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
  end

  def index
    # client = Signet::OAuth2::Client.new(client_options)
    # client.update!(session[:authorization])

    # service = Google::Apis::CalendarV3::CalendarService.new
    # service.authorization = client

    # @event_list = service.list_events('sccakim1@gmail.com')
    # rescue Google::Apis::AuthorizationError
    #   response = client.refresh!

    #   session[:authorization] = session[:authorization].merge(response)

    #   retry
  end

  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end

  def task_params
    params.require(:task).permit(:name, :due_at, :completed_by_id, :is_completed, :description)
  end
end

