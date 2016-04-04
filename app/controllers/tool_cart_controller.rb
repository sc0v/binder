class ToolCartController < ApplicationController
  before_action :check_permissions

  def add_tool
    @tool = Tool.find_by_barcode(params[:barcode])
    session[:tool_cart] = session[:tool_cart] || []

    unless @tool.present?
      return render action: 'tool_cart_error',
                    locals: {message: 'Could not load that tool. Try scanning it again or add the tool to the system.'}
    end

    if session[:tool_cart].include?(@tool.barcode)
      return render action: 'tool_cart_error',
                    locals: {message: "Tool ##{@tool.barcode} is already in the cart"}
    end

    session[:tool_cart].append(@tool.barcode)
    render action: 'add_tool'
  end

  def remove_tool
    session[:tool_cart] = session[:tool_cart] || []

    unless session[:tool_cart].include?(params[:barcode].to_i)
      return render action: 'tool_cart_error',
                    locals: {message: "Tool is not in the cart"}
    end

    session[:tool_cart].delete(params[:barcode].to_i)
    render action: 'remove_tool', locals: {barcode: params[:barcode], list_empty: session[:tool_cart].empty?}
  end

  def checkout
    session[:tool_cart] = session[:tool_cart] || []
    if session[:tool_cart].empty?
      return render action: 'tool_cart_error',
                    locals: {message: "Scan tools to checkout first"}
    end

    if params[:participant_id].empty? || params[:organization_id].empty?
      return render action: 'tool_cart_error',
                    locals: {message: "Enter a valid participant and org. (Try pressing enter inside the input box)"}
    end
    participant = Participant.find(params[:participant_id])
    organization = Organization.find(params[:organization_id])

    # Validations
    unless participant.present?
      return render action: 'tool_cart_error',
                    locals: {message: "Invalid participant"}
    end

    unless organization.present?
      return render action: 'tool_cart_error',
                    locals: {message: "Invalid organization"}
    end

    # Add membership
    if params[:add_membership]
      Membership.create({participant_id: params[:participant_id], organization_id: params[:organization_id]})
    end

    # Create checkouts
    session[:tool_cart].each do |barcode|
      tool = Tool.find_by_barcode(barcode)
      next if tool.blank?

      # Checkin tool if it is already checked out
      if tool.is_checked_out?
        old_checkout = tool.checkouts.current.first
        old_checkout.checked_in_at = Time.now
        old_checkout.save
      end

      checkout = Checkout.new
      checkout.checked_out_at = Time.now
      checkout.tool = tool
      checkout.participant = participant
      checkout.organization = organization

      if checkout.save
        checkout.tool.tool_type.tool_waitlists.each do |waitlist|
          if waitlist.organization == checkout.organization
            # Automatically remove the person from the waitlist
            waitlist.active = false
            waitlist.save
            break
          end
        end
      end
    end

    @num_tools = session[:tool_cart].size
    @person_name = participant.andrewid
    @org_name = organization.short_name

    session[:tool_cart] = []
  end

  def checkin
    session[:tool_cart] = session[:tool_cart] || []
    if session[:tool_cart].empty?
      return render action: 'tool_cart_error',
                    locals: {message: "Scan tools to checkin first"}
    end


    session[:tool_cart].each do |barcode|
      tool = Tool.find_by_barcode(barcode)
      next if tool.blank?

      # Checkin tool if it is already checked out
      if tool.is_checked_out?
        old_checkout = tool.checkouts.current.first
        old_checkout.checked_in_at = Time.now
        old_checkout.save
      end
    end

    @num_tools = session[:tool_cart].size
    session[:tool_cart] = []
  end

  def swap
    session[:tool_cart] = session[:tool_cart] || []
    if session[:tool_cart].size != 2
      return render action: 'tool_cart_error',
                    locals: {message: "You must scan exactly 1 checked in tool and 1 checked out tool to use swap."}
    end

    first_tool = Tool.find_by_barcode(session[:tool_cart][0])
    second_tool = Tool.find_by_barcode(session[:tool_cart][1])

    if first_tool.is_checked_out? && !second_tool.is_checked_out?
      checkedin_tool = second_tool
      checkedout_tool = first_tool
    elsif second_tool.is_checked_out? && !first_tool.is_checked_out?
      checkedin_tool = first_tool
      checkedout_tool = second_tool
    else
      return render action: 'tool_cart_error',
                    locals: {message: "You must scan exactly 1 checked in tool and 1 checked out tool to use swap."}
    end

    @old_tool_name = checkedout_tool.name
    @new_tool_name = checkedin_tool.name
    @person_name = checkedout_tool.current_participant.name
    @org_name = checkedout_tool.current_organization.short_name

    # Checkout new tool
    checkout = Checkout.new
    checkout.checked_out_at = Time.now
    checkout.tool = checkedin_tool
    checkout.participant = checkedout_tool.current_participant
    checkout.organization = checkedout_tool.current_organization

    if checkout.save
      checkout.tool.tool_type.tool_waitlists.each do |waitlist|
        if waitlist.organization == checkout.organization
          # Automatically remove the person from the waitlist
          waitlist.active = false
          waitlist.save
          break
        end
      end
    end

    # Checkin old tool
    old_checkout = checkedout_tool.checkouts.current.first
    old_checkout.checked_in_at = Time.now
    old_checkout.save

    session[:tool_cart] = []
  end

  private
  def check_permissions
    unless can?(:create, Checkout)
      redirect_to root_url, alert: 'You do not have permission to use the tool cart'
    end
  end

end