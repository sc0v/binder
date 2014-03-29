class CheckoutsController < ApplicationController
  # permissions error - when enabled, this tries to find a Checkout with the current related model id on creation
  # load_and_authorize_resource

  # GET /checkouts
  # GET /checkouts.json
  def index
    @checkouts = Checkout.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkouts }
    end
  end

  #declare error classes
  class CheckoutError < ArgumentError
  end
  
  # GET /checkouts/new
  # GET /checkouts/new.json
  def new
    @checkout = Checkout.new
    @tool = Tool.find_by_id(params[:tool_id])

    raise CheckoutError, I18n.t("errors.messages.tool_does_not_exist") unless !@tool.blank?
    raise CheckoutError, I18n.t("errors.messages.tool_already_checked_out") unless not @tool.is_checked_out?

    @checkout.tool = @tool

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkout }
    end
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new

    unless params[:tool_id].blank?
      @tool = Tool.find(params[:tool_id])
    else
      @tool = Tool.find_by_barcode(params[:tool_barcode])
    end
    
    # Fancy Tool finding/creation for Hardhats Page
    unless (params[:form].blank? or params[:tool_barcode].to_i > 2500 or params[:tool_barcode].to_i < 1)
      if @tool.blank?
        @tool = Tool.create({ barcode: params[:tool_barcode], name: "Org Hardhat", description: "White" }) 
      elsif !@tool.is_hardhat?
        raise CheckoutError, I18n.t("errors.messages.tool_is_not_hardhat")
      end
    else
      raise CheckoutError, I18n.t("errors.messages.tool_does_not_exist") unless !@tool.blank?
    end

    raise CheckoutError, I18n.t("errors.messages.tool_already_checked_out") unless not @tool.is_checked_out?
    
    @participant = Participant.find(params[:participant_id]) unless params[:participant_id].blank?
    
    @organization = Organization.find(params[:organization_id]) unless params[:organization_id].blank?
    raise CheckoutError, I18n.t("errors.messages.organization_does_not_exist") unless !@organization.nil?
    
    Membership.create({ participant: @participant, organization: @organization }) if params[:add]

    @checkout.checked_out_at = Time.now
    @checkout.tool = @tool
    @checkout.participant = @participant
    @checkout.organization = @organization unless @organization.blank?

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to @checkout.tool, notice: 'Checkout was successfully created.' }
        format.json { render json: @checkout.tool, status: :created, location: @checkout.tool }
      else
        format.html { render action: "new" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.json
  def update
    @checkout = Checkout.find(params[:id])
    
    raise CheckoutError, I18n.t("errors.messages.tool_already_checked_in") unless @checkout.tool.is_checked_out?
    @checkout.checked_in_at = Time.now

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to params[:url], notice: 'Checkout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def choose_organization
    @tool = Tool.find(params[:tool_id])
    @participant = Participant.find(params[:checkout][:participant_id])
    
    respond_to do |format|
      format.html { render "choose_organization", :tool => @tool, :participant => @participant }
      format.json { render json: @checkouts }
    end
  end
end

