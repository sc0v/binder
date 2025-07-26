class Dashboards::CoordinatorController < ApplicationController
  # Confirm user can create a checkout
  before_action :confirm_user_can_create_checkout
  before_action :load_session
  after_action :save_session

  def confirm_user_can_create_checkout
    unless can? :create, Checkout
      flash[:error] = "You do not have permission to create a checkout."
      redirect_to root_path
    end
  end

  def load_session
    @current_dashboard_session = session[:current_dashboard_session] || {}
  end

  def save_session
    session[:current_dashboard_session] = @current_dashboard_session
  end

  def index
    @selected_user = Participant.find_by(id: @current_dashboard_session["selected_user_id"])
    @selected_tool = Tool.find_by(id: @current_dashboard_session["selected_tool_id"])
    # Match order of @current_dashboard_session["cart"]
    items = Tool.find(@current_dashboard_session["cart"] || [])
    @cart = @current_dashboard_session["cart"].map { |id| items.find { |tool| tool.id == id } }.compact
    @cart_fully_checked_in = @cart.all? { |tool| !tool.is_checked_out? }
    @history = @current_dashboard_session["history"] || []

    session[:step] = nil

    if @selected_user.present?
      puts @selected_user.name
    else
      puts "No User Selected"
    end
  end

  def search
    # Deal with search term. Possiblities are
    # 1. Text search (TODO)
    # 2. UP to 5 numbers (tool)
    # 3. > 5 numbers (user)
    # 4. one string of non-spaced characters (user eppn)

    search_query = params[:q].strip.downcase

    resulted = nil

    if search_query.present?
      if ["add", "+", "add_to_cart"].include?(search_query)
        perform_add_to_cart
        return redirect_to dashboards_coordinator_path
      elsif ["clear", "clear_cart"].include?(search_query)
        perform_clear_cart
        return redirect_to dashboards_coordinator_path
      elsif ["out", "checkout", "check_out"].include?(search_query)
        return redirect_to dashboards_coordinator_confirm_path("checkout")
      elsif ["in", "checkin", "check_in"].include?(search_query)
        return redirect_to dashboards_coordinator_confirm_path("checkin")
      elsif search_query.match?(/\A\s?\d{1,5}\s?\z/)
        tool = Tool.find_by(barcode: search_query.to_i)
        if tool.present?
          @current_dashboard_session["selected_tool_id"] = tool.id
          resulted = "Tool - #{tool.name}"
        else
          flash[:error] = "Tool not found."
        end
      elsif search_query.match?(/\A\s?\d{6,}\s?\z/)
        user = Participant.find_by_card(search_query, lookup_only: true)
        if user.present?
          @current_dashboard_session["selected_user_id"] = user.id
          resulted = "User - #{user.name}"
        else
          flash[:error] = "User not found."
        end
      elsif search_query.match?(/\A[a-zA-Z0-9]+\z/)
        user = Participant.find_by_andrewid(search_query)
        if user.present?
          @current_dashboard_session["selected_user_id"] = user.id
          resulted = "User - #{user.name}"
        else
          flash[:error] = "User not found."
        end
      else
        flash[:error] = "Invalid search term."
      end
    end

    @current_dashboard_session["history"] ||= []
    # Dont add to history if no result or if the previous search was the same
    @current_dashboard_session["history"].unshift([search_query, resulted]) if resulted.present? && (@current_dashboard_session["history"].empty? || @current_dashboard_session["history"][0][0] != search_query)
    @current_dashboard_session["history"].pop if @current_dashboard_session["history"].length > 10

    redirect_to dashboards_coordinator_path
  end

  def add_to_cart
    perform_add_to_cart
    redirect_to dashboards_coordinator_path
  end

  def remove_tool
    tool_id = params[:tool_id].to_i
    @current_dashboard_session["cart"] ||= []
    if tool_id.present? && @current_dashboard_session["cart"].include?(tool_id)
      @current_dashboard_session["cart"].delete(tool_id)
    else
      flash[:error] = "No tool selected to remove from cart."
    end
    puts @current_dashboard_session["cart"]
    redirect_to dashboards_coordinator_path
  end

  def clear_cart
    perform_clear_cart
    redirect_to dashboards_coordinator_path
  end

  def confirm
    @selected_user = Participant.find_by(id: @current_dashboard_session["selected_user_id"])
    @selected_tool = Tool.find_by(id: @current_dashboard_session["selected_tool_id"])
    # Match order of @current_dashboard_session["cart"]
    items = Tool.find(@current_dashboard_session["cart"] || [])
    @cart = @current_dashboard_session["cart"].map { |id| items.find { |tool| tool.id == id } }.compact

    @type = params[:type]

    if @cart.empty?
      flash[:error] = "No tools in cart."
      return redirect_to dashboards_coordinator_path
    end

    if @type == "checkout"
      unless is_cart_fully_checked_in?
        flash[:error] = "Some tools in the cart are already checked out."
        return redirect_to dashboards_coordinator_path
      end
      unless @selected_user.present?
        flash[:error] = "No user selected for checkout"
        return redirect_to dashboards_coordinator_path
      end
      if @selected_user.organizations.empty?
        flash[:error] = "Selected user has no memberships"
        return redirect_to dashboards_coordinator_path
      end
    end

    if !session[:step].present?
      if @type == "checkout"
        session[:step] = 1
        session[:receipt_text] = ""
      elsif @type == "checkin"
        session[:step] = 3
        session[:receipt_text] = ""
      end
    end
    @step = session[:step]
    @receipt_text = session[:receipt_text]
  end

  def confirm_post
    @type = params[:type]
    case session[:step]
      when 1
        process_confirm_one
      when 2
        process_confirm_two
      when 3
        process_confirm_three
      when 4
        if @type == "checkout"
          process_checkout
        elsif @type == "checkin"
          process_checkin
        end
      else
        redirect_to dashboards_coordinator_confirm_path
    end
  end

  private

  def perform_add_to_cart
    selected_tool_id = @current_dashboard_session["selected_tool_id"]
    if selected_tool_id.present?
      @current_dashboard_session["cart"] ||= []
      @current_dashboard_session["cart"] << selected_tool_id
      @current_dashboard_session["selected_tool_id"] = nil
      return true
    else
      flash[:error] = "No tool selected to add to cart."
      return false
    end
  end

  def perform_clear_cart
    @current_dashboard_session["cart"] = []
  end

  def is_cart_fully_checked_in?
    @current_dashboard_session["cart"].all? { |tool_id| !Tool.find(tool_id).is_checked_out? }
  end

  def process_confirm_one
    @selected_user = Participant.find_by(id: @current_dashboard_session["selected_user_id"])
    session[:receipt_text] += "--- Borrower ---\nName: #{@selected_user.name}\nAndrewId: #{@selected_user.eppn}"
    session[:step] = 2
    redirect_to dashboards_coordinator_confirm_path
  end

  def process_confirm_two
    unless params[:checkout]["organization_id"].present?
      flash[:error] = "No organization selected"
      return redirect_to dashboards_coordinator_confirm_path
    end

    organization = Organization.find_by(id: params[:checkout]["organization_id"])
    unless organization.present?
      flash[:error] = "Invalid organization"
      return redirect_to dashboards_coordinator_confirm_path
    end

    @current_dashboard_session["organization_id"] = organization.id

    session[:receipt_text] += "\n\n--- Organization ---\nName: #{organization.name}"
    session[:step] = 3
    redirect_to dashboards_coordinator_confirm_path
  end

  def process_confirm_three
    session[:receipt_text] += "\n\n" unless params[:type] == "checkin"
    session[:receipt_text] += "--- Tools ---\n"
    @current_dashboard_session["cart"].each do |tool_id|
      tool = Tool.find(tool_id)
      session[:receipt_text] += "#{tool.formatted_name}\n"
    end
    session[:step] = 4
    redirect_to dashboards_coordinator_confirm_path
  end

  def process_checkin
    failures = false
    @current_dashboard_session["cart"].each do |tool_id|
      @tool = Tool.find(tool_id)
      @checkout = @tool.checkouts.current.first unless @tool.checkouts.blank? || @tool.checkouts.current.blank?
      if @checkout
        @checkout.checked_in_at = Time.zone.now
        failures = failures || !@checkout.save
      end
    end
    if failures
      flash[:error] = "Failed to check in some tools. See updates in cart."
    else
      flash[:notice] = "Tools checked in"
      @current_dashboard_session["cart"] = []
    end
    redirect_to dashboards_coordinator_path
  end

  def process_checkout
    # Create actual checkout
    @organization = Organization.find(@current_dashboard_session["organization_id"])

    p = Participant.find(@current_dashboard_session["selected_user_id"])
    result = Checkout.transaction do
      @current_dashboard_session["cart"].each do |tool_id|
          t = Tool.find(tool_id)
          Checkout.create!(organization: @organization,
                            participant: p,
                            tool: t,
                            checked_out_at: Time.zone.now)
      end
    end

    if result.present?
      @current_dashboard_session["cart"] = []
      flash[:notice] = "Tools checked out to #{p.name}"
    else
      flash[:alert] = "Problem checking out tools. Confirm none have been checked out"
    end

    redirect_to dashboards_coordinator_path
  end
end
