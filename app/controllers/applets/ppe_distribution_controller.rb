# frozen_string_literal: true
class Applets::PPEDistributionController < ApplicationController
  def index
    case params[:step]
    when '1'
      params[:step] = '2' if load_step_one # participant look up
    when '2'
      params[:step] = '3' if load_step_two # wristband
    when '3'
      step_three if load_step_three # hardhat checkout
    else
      params[:step] = '1'
    end
  end

  private

  def load_step_one
    return if params[:participant_search].blank?
    @participant =
      Participant.find_or_create_by_search(params[:participant_search])
    if @participant.blank?
      flash.now[:alert] = 'No participant found with that information.'
      return false
    elsif !@participant.signed_waiver?
      flash.now[:alert] = "#{@participant.name} did not sign the waiver yet."
      return false
    elsif @participant.organizations.blank?
      flash.now[:alert] = "#{@participant.name} has no organization memberships."
      return false
    elsif Tool.hardhats.joins(:checkouts).where(checkouts: {participant_id: @participant.id, checked_in_at: nil}).exists?
      flash.now[:alert] = "#{@participant.name} already has tools checked out."
      return false
    end
    true
  end

  def load_step_two
    @participant = Participant.find(params[:participant_id])
    return false if @participant.blank?
    true
  end

  def load_step_three
    @participant = Participant.find(params[:participant_id])
    return false if @participant.blank?
    if params[:hardhat_search].blank?
        flash.now[:alert] = 'No hardhat found with that information.'
        return false
    end
    if params[:organization_id].blank?
      flash.now[:alert] = 'No organization selected.'
      return false
    end
    @organization = Organization.find(params[:organization_id])
    return false if @organization.blank?
    hh_type = case @participant.hardhat_color
               when :blue
                 ToolType.find_by(name: 'SCC Hardhat')
               when :red
                 ToolType.find_by(name: 'Booth Chair Hardhat')
               when :white
                 ToolType.find_by(name: 'Org Hardhat')
               end
    # Check if a hardhat exists with the given barcode
    @hardhat = Tool.find_by(barcode: params[:hardhat_search])

    # If it exists, check if it's the correct type
    if @hardhat.present?
      if @hardhat.tool_type != hh_type
        flash.now[:alert] = 'Hardhat is not the correct type.'
        return false
      end
    end

    #  If hardhat doesn't exist create one
    if @hardhat.blank?
      @hardhat = Tool.create!(tool_type: hh_type, barcode: params[:hardhat_search])
    end

    return false if @hardhat.blank?
    true
  end

  def step_three
    @checkout = Checkout.create(tool: @hardhat, participant: @participant, organization: @organization, checked_out_at: Time.now)
    if !@checkout.save
      flash.now[:alert] = "Checkout failed (#{@checkout.errors.full_messages.join(', ')})"
      return false
    end
    flash.now[:notice] = "Hardhat #{@hardhat.barcode} checked out to #{@participant.name} of #{@organization.name}. Review below or start over."
  end
end
