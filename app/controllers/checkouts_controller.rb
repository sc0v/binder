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

    raise CheckoutError, I18n.t("errors.messages.tool_does_not_exist") unless !@tool.blank?

    raise CheckoutError, I18n.t("errors.messages.tool_already_checked_out") unless not @tool.is_checked_out?

    unless params[:checkout].blank?
      @participant = Participant.find_by_card(params[:checkout][:card_number].to_s) #this creates a CMU directory request to get the andrew id associated with the card number. Then finds the local DB mapping to get the participant id.

      @participant = Participant.find_by_andrewid(params[:checkout][:card_number].downcase) unless !@participant.nil?

      raise CheckoutError, I18n.t("errors.messages.participant_does_not_exist") unless !@participant.nil?
    else
      @participant = Participant.find(params[:participant_id]) unless params[:participant_id].blank?
      
      @organization = Organization.find(params[:organization_id])
      raise CheckoutError, I18n.t("errors.messages.organization_does_not_exist") unless !@organization.nil?
    end


    if @organization.blank? and @participant.organizations.size != 1
      respond_to do |format|
        format.html { render "choose_organization", :tool => @tool, :participant => @participant }
        format.json { render json: @checkouts }
      end
    else
      @checkout.checked_out_at = Time.now
      @checkout.tool = @tool
      @checkout.participant = @participant
      if @organization.blank?
        @checkout.organization = @participant.organizations.first unless @participant.organizations.blank?
      else
        @checkout.organization = @organization unless @organization.blank?
      end

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
end

