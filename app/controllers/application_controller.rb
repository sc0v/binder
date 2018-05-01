require "application_responder"

class ApplicationController < ActionController::Base

  before_action :set_event_list

  self.responder = ApplicationResponder
  respond_to :html
  responders :flash, :http_cache

  protect_from_forgery :with => :exception
  before_filter :sidebar

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  #checkin error handling
  #just need to fix routing for this and user // participant creation flow/path
  rescue_from 'Participant::NotRegistered' do |exception|
    flash[:notice] = "The Student ID you swiped is not yet activated with a user account. Please register with andrew eMail"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/participants/new"
  end

  rescue_from 'CheckoutsController::CheckoutError' do |exception|
    flash.now[:error] = exception.message
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    respond_to do |format|
      format.html { redirect_to "/tools" }
      format.json { render :json => exception.message, :status => :unprocessable_entity }
    end
  end

  rescue_from 'RestClient::Forbidden' do |exception|
    flash[:error] = "Cannot connect to CMU Authentication"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/"
  end

  def participant_already_in_system(participant)
    flash[:notice] = "The participant is already in the system - Update organizations for #{participant.name}"
  end
  
  def sidebar
    @current_shifts_sidebar = Shift.current
    @upcoming_shifts_sidebar = Shift.upcoming
    @tasks_sidebar = Task.upcoming.is_incomplete
    @structural_queue_sidebar = OrganizationTimelineEntry.structural.current
    @electrical_queue_sidebar = OrganizationTimelineEntry.electrical.current
    @events_sidebar = Event.displayable
    @downtime_sidebar = OrganizationTimelineEntry.downtime.current
    session[:tool_cart] = session[:tool_cart] || []
    @tool_cart = session[:tool_cart].map{|barcode| Tool.find_by_barcode(barcode)}.reverse
  end

  def require_authenticated_user
    if current_user.nil?
      redirect_to main_app.user_omniauth_authorize_path(:shibboleth)
    end
  end

  def authorize_report_access
    unless can?(:create, :reports)
      redirect_to root_path, notice: "You are not authorized to see reports"
    end
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


    month = Time.now.month
    if month > 1 and month < 8
      min_year = Time.now.year - 1
      max_year = Time.now.year
    else
      min_year = Time.now.year
      max_year = Time.now.year + 1
    end
      
    # earliest date to get tasks from is august of the previous year
    min_date = Time.new(min_year, 8).iso8601
    # latest date to get tasks from is june of the current year
    max_date = Time.new(max_year, 6).iso8601

    response = @calendar.list_events(GoogleCalendarHelper::CALENDAR_ID,
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: min_date,
                                   time_max: max_date)


    # if the "all tasks" filter is selected
    if(params[:task_filter].blank?)
      @event_list = response.items
    # if the "completed tasks" filter is selected
    elsif(params[:task_filter] == "completed_tasks")
      # create an empty array and only put the complete tasks in 
      @event_list = Array.new
      unless response.items.empty?
        response.items.each do |task|
          # a task with color id of 2 is complete
          if task.color_id == "2"
            @event_list.push(task)
          end
        end
      end
    # if the "incomplete tasks" filter is selected
    elsif(params[:task_filter] == "incomplete_tasks")
      # create an empty array and only put the incomplete tasks in 
      @event_list = Array.new
      unless response.items.empty?
        response.items.each do |task|
          # any task that does not have a color if of 2 is incomplete
          if task.color_id != "2"
            @event_list.push(task)
          end
        end
      end
    end
  end
  
end
