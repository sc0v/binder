class ToolWaitlistsController < ApplicationController
  # Can't use load_and_authorize_resource until it's fixed in the
  # checkout controller as well.
  # load_and_authorize_resource

  # GET /tool_waitlists/new
  def new
    @tool_waitlist = ToolWaitlist.new
    @tool_type = ToolType.find_by_id(params[:tool_type_id])
    @tool_waitlist.tool_type = @tool
  end

  # POST /tool_waitlists
  # POST /tool_waitlists.json
  def create
    @tool_waitlist = ToolWaitlist.new({
        participant_id: params[:participant_id],
        organization_id: params[:organization_id],
        tool_type_id: params[:tool_type_id],
        contact_method: params[:contact_method],
        wait_start_time: DateTime.now
    })

    if params[:add].to_i == 1
      Membership.create({participant_id: params[:participant_id], organization_id: params[:organization_id]})
    end

    @tool_type = ToolType.find(params[:tool_type_id])
    if can?(:create, ToolWaitlist) && @tool_waitlist.save
      redirect_to tools_path(type_filter: @tool_type.id), notice: 'Waitlist entry was successfully created.'
    else
      flash[:notice] = @tool_waitlist.errors.full_messages.join(" ")
      render action: "new"
    end
  end

  def choose_organization
    @tool_type = ToolType.find(params[:tool_type_id])
    @participant = Participant.find_by_card(params['card-number-input'])
    @contact_method = params[:contact_method]
    if @tool_type.blank?
      redirect_to :back, notice: "Missing tool type"
    elsif @participant.blank?
      redirect_to :back, notice: "Missing participant to add to the waitlist"
    elsif @contact_method.blank?
      redirect_to :back, notice: "Missing contact method"
    end
  end

  # DELETE /tool_waitlists/1
  # DELETE /tool_waitlists/1.json
  def destroy
    @tool_waitlist = ToolWaitlist.find(params[:tool_waitlist_id])
    if can?(:create, ToolWaitlist) # Creators can destroy any
      @tool_waitlist.active = false
      @tool_waitlist.save
    end
    redirect_to :back, notice: "Waitlist entry successfully removed"
  end
end
