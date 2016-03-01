class CheckoutsController < ApplicationController
  # declare error classes
  class CheckoutError < ArgumentError
  end

  # GET /checkouts
  # GET /checkouts.json
  def index
    @tool = Tool.find(params[:tool_id])
    @checkouts = @tool.checkouts
  end
  
  # GET /checkouts/new
  # GET /checkouts/new.json
  def new
    @checkout = Checkout.new
    @tool = Tool.find_by_id(params[:tool_id])
    @checkout.tool = @tool
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new({
        participant_id: params[:participant_id],
        organization_id: params[:organization_id],
        tool_id: params[:tool_id],
        checked_out_at: Time.now
    })

    if params[:add].to_i == 1
      Membership.create({participant_id: params[:participant_id], organization_id: params[:organization_id]})
    end

    if can?(:create, Checkout) && @checkout.save
      redirect_to tool_path(@checkout.tool), notice: 'Checkout was successfully created.'
    else
      render action: "new", flash: @checkout.errors.full_messages
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.json
  def update
    @checkout = Checkout.find(params[:id])
    
    raise CheckoutError, I18n.t("errors.messages.tool_already_checked_in") unless @checkout.tool.is_checked_out?
    @checkout.checked_in_at = Time.now

    if can?(:update, Checkout) && @checkout.save
      redirect_to URI.parse(params[:url]).path, notice: "Checkout was successfully updated. #{view_context.link_to("[ Undo ]", uncheckin_checkout_path(:id => @checkout.id), method: :post)}."
    else
      redirect_to :back, flash: @checkout.errors.full_messages
    end
  end
  
  def choose_organization
    @tool = Tool.find(params[:tool_id])
    @participant = Participant.find_by_card(params['card-number-input'])
    if @tool.blank?
      redirect_to :back, notice: "Missing tool to checkout"
    elsif @participant.blank?
      redirect_to :back, notice: "Missing participant to checkout the tool to"
    end
  end

  def uncheckin
    checkout = Checkout.find(params[:id])
    checkout.checked_in_at = nil
    if can?(:update, Checkout) && checkout.save
      redirect_to tool_path(checkout.tool), notice: "Checkout was successfully undone"
    else
      redirect_to tool_path(checkout.tool), notice: "Error, could not un-checkin the tool"
    end
  end


  def checkin
    @tool = Tool.find_by_barcode(params[:barcode])
    @checkout = @tool.checkouts.current.first unless @tool.checkouts.blank? or @tool.checkouts.current.blank?

    raise CheckoutError, I18n.t("errors.messages.tool_already_checked_in") if @checkout.blank?
    unless params[:checkout][:organization_id].blank?
      @organization = Organization.find params[:checkout][:organization_id]
    end
      
    if can?(:update, Checkout) && (@organization.blank? || @checkout.organization == @organization)
      @checkout.checked_in_at = Time.now
      @checkout.save
      respond_to do |format|
        format.js { }
      end
    end
  end
end

