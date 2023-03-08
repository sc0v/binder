# frozen_string_literal: true

class CheckoutsController < ApplicationController
  # permissions error - when enabled, this tries to find a Checkout with the current related model id on creation
  # load_and_authorize_resource

  # GET /checkouts
  # GET /checkouts.json
  def index
    @tool = Tool.find(params[:tool_id])
    @checkouts = @tool.checkouts
    authorize! :read, @checkouts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkouts }
    end
  end

  # declare error classes
  class CheckoutError < ArgumentError
  end

  # GET /checkouts/new
  # GET /checkouts/new.json
  def new
    @checkout = Checkout.new
    @tool = Tool.find_by(id: params[:tool_id])

    raise CheckoutError, I18n.t('errors.messages.tool_does_not_exist') if @tool.blank?
    raise CheckoutError, I18n.t('errors.messages.tool_already_checked_out') if @tool.is_checked_out?

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

    @tool = if params[:tool_id].blank?
              Tool.find_by(barcode: params[:tool_barcode])
            else
              Tool.find(params[:tool_id])
            end

    # Fancy Tool finding/creation for Hardhats Page
    if params[:form].blank? || (params[:tool_barcode].to_i > 2500) || (params[:tool_barcode].to_i < 1)
      raise CheckoutError, I18n.t('errors.messages.tool_does_not_exist') if @tool.blank?
    elsif @tool.blank?
      @tool = Tool.create({ barcode: params[:tool_barcode], name: 'Org Hardhat', description: 'White' })
    elsif !@tool.is_hardhat?
      raise CheckoutError, I18n.t('errors.messages.tool_is_not_hardhat')
    end

    raise CheckoutError, I18n.t('errors.messages.tool_already_checked_out') if @tool.is_checked_out?

    @participant = Participant.find(params[:participant_id]) if params[:participant_id].present?

    @organization = Organization.find(params[:organization_id]) if params[:organization_id].present?
    raise CheckoutError, I18n.t('errors.messages.organization_does_not_exist') if @organization.nil?

    Membership.create({ participant: @participant, organization: @organization }) if params[:add].to_i == 1

    @checkout.checked_out_at = Time.zone.now
    @checkout.tool = @tool
    @checkout.participant = @participant
    @checkout.organization = @organization if @organization.present?

    respond_to do |format|
      if @checkout.save
        format.html do
          redirect_to tool_path(@checkout.tool),
                      notice: "#{@checkout.tool.tool_type.name} was successfully checked out to #{@checkout.participant.name}"
        end
        format.json { render json: @checkout.tool, status: :created, location: @checkout.tool }
      else
        format.html { render action: 'new' }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.json
  def update
    @checkout = Checkout.find(params[:id])

    raise CheckoutError, I18n.t('errors.messages.tool_already_checked_in') unless @checkout.tool.is_checked_out?

    @checkout.checked_in_at = Time.zone.now

    respond_to do |format|
      if @checkout.save
        format.html do
          redirect_to URI.parse(params[:url]).path,
                      notice: "Checkout was successfully updated. #{view_context.link_to('[ Undo ]',
                                                                                         uncheckin_checkout_path(id: @checkout.id), method: :post)}."
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  def choose_organization
    @tool = Tool.find(params[:tool_id])
    raise CheckoutError, I18n.t('errors.messages.tool_does_not_exist') if @tool.nil?

    # @participant = Participant.find(params[:checkout][:participant_id])
    @participant = Participant.find_by(card: params['card-number-input'])

    respond_to do |format|
      format.html { render 'choose_organization', tool: @tool, participant: @participant }
      format.json { render json: @checkouts }
    end
  end

  def uncheckin
    checkout = Checkout.find(params[:id])
    checkout.checked_in_at = nil
    respond_to do |format|
      if checkout.save
        format.html { redirect_to tool_path(checkout.tool), notice: 'Checkout was successfully undone' }
      else
        format.html { redirect_to tool_path(checkout.tool), notice: 'Error' }
      end
    end
  end

  def checkin
    @tool = Tool.find_by(barcode: params[:barcode])
    @checkout = @tool.checkouts.current.first unless @tool.checkouts.blank? || @tool.checkouts.current.blank?
    raise CheckoutError, I18n.t('errors.messages.tool_already_checked_in') if @checkout.blank?

    if params[:checkout][:organization_id].present?
      @organization = Organization.find params[:checkout][:organization_id]
    end

    if @organization.blank? || @checkout.organization == @organization
      @checkout.checked_in_at = Time.zone.now
      @checkout.save
      respond_to do |format|
        format.js {}
      end
    end
  rescue StandardError
  end

  def checkin_bak
    @tool = Tool.find_by(barcode: params[:tool_barcode])
    raise CheckoutError, I18n.t('errors.messages.tool_does_not_exist') if @tool.nil?
    raise CheckoutError, I18n.t('errors.messages.tool_is_not_hardhat') unless @tool.is_hardhat?

    @checkout = @tool.checkouts.current.first unless @tool.checkouts.blank? || @tool.checkouts.current.blank?
    raise CheckoutError, I18n.t('errors.messages.tool_already_checked_in') if @checkout.blank?

    return if @checkout.nil?

    @checkout.checked_in_at = Time.zone.now

    respond_to do |format|
      if @checkout.present? && @checkout.save
        format.html { redirect_to tool_path(@checkout.tool), notice: 'Tool was successfully checked in.' }
        format.json { render json: @checkout.tool, status: :created, location: @checkout.tool }
      else
        format.html { render action: 'new' }
        format.json { render json: @checkout.blank? ? 'Error' : @checkout.errors, status: :unprocessable_entity }
      end
    end
  end
end
