# frozen_string_literal: true

class MembershipsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: %i[new create update]

  def index
    @memberships = Membership.all
  end

  def show
    @membership = Membership.find(params[:id])
  end

  VALID_STEPS = %w[csv_upload repair].freeze

  def new
    @organization = Organization.find(params.require(:organization_id))
    @membership = Membership.new
    @membership.organization = @organization
    @step = VALID_STEPS.include?(params[:step]) ? params[:step] : 'csv_upload'
    @members = repair_stage_members if @step == 'repair'
  end

  def upload_csv
    @organization = Organization.find(params[:organization])
    csv_file = params[:csv_file]
    return redirect_csv_error(t('.csv_not_uploaded')) if csv_file.blank?

    parse = helpers.parse_membership_csv(csv_file, @organization)
    return redirect_csv_error(parse[:error]) if parse[:error].present?

    redirect_to new_organization_membership_path(@organization, step: 'repair')
  end

  # Insert a participant to the current membership CSV. Creates a new participant
  # and membership if either doesn't exist; sets standing if params[:standing] present.
  def insert
    @organization = Organization.find(params[:organization])
    participant = find_or_create_insert_participant
    update_participant_standing(participant) if params[:standing].present?
    upsert_insert_membership(participant)
    return if params[:ignore_redirect]

    redirect_to new_organization_membership_path(@organization, step: 'repair')
  end

  def remove
    @organization = Organization.find(params[:organization])
    remove_membership(Membership.find(params[:old_membership]))
    return if params[:ignore_redirect]

    redirect_to new_organization_membership_path(@organization, step: 'repair')
  end

  # Replace one staged membership with another, respecting any other memberships
  def replace
    params[:ignore_redirect] = true
    remove
    params[:ignore_redirect] = false
    params[:standing] = params[:fix_standing]
    insert
  end

  # Cancel all staged memberships, deleting any that were added by the CSV
  def cancel
    @organization = Organization.find(params[:organization])
    Membership
      .where(organization: @organization, is_in_csv: true)
      .find_each { |m| remove_membership(m) }
    redirect_to organization_path(@organization), notice: t('.notice')
  end

  # Commit all staged memberships
  def commit
    @organization = Organization.find(params[:organization])
    Membership
      .where(organization: @organization, is_in_csv: true)
      .find_each { |m| m.update!({ is_in_csv: false, is_added_by_csv: false }) }
    redirect_to organization_path(@organization), notice: t('.notice')
  end

  def edit
    @participant = Participant.find(params[:participant_id])
  end

  def create
    @membership =
      Membership.new(
        params.expect(membership: %i[participant_id is_booth_chair])
      )
    @organization = Organization.find(params.require(:organization_id))
    @membership.organization = @organization
    authorize! :create, @membership
    if @membership.save
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end
    redirect_to @organization
  end

  def update
    @participant = Participant.find(params[:participant_id])
    @membership = Membership.find(params[:id])
    authorize! :update, @membership
    @membership.update(update_params)
    respond_with @membership, location: -> { @participant }
  end

  def destroy
    @membership = Membership.find(params[:id])
    @organization = @membership.organization
    @membership.destroy
    redirect_to @organization
  end

  private

  def repair_stage_members
    Membership
      .where(organization: @organization, is_in_csv: true)
      .sort_by do |m|
        m.participant_name == 'N/A' ? '' : m.participant_eppn.downcase
      end
  end

  def find_or_create_insert_participant
    eppn = "#{params[:new_participant]}@andrew.cmu.edu"
    Participant.find_by(eppn:) || Participant.create!(eppn:)
  end

  def update_participant_standing(participant)
    participant.update!(alumni: params[:standing] == 'alumni')
  end

  def insert_standing_flags(existing)
    booth_chair = existing&.is_booth_chair || false
    red_hardhat = existing&.is_red_hardhat || false
    if params[:standing] == 'booth_chair_red_hardhat'
      [true, true]
    elsif params[:standing] == 'booth_chair_white_hardhat'
      [true, red_hardhat]
    else
      [booth_chair, red_hardhat]
    end
  end

  def upsert_insert_membership(participant)
    existing = Membership.find_by(participant:, organization: @organization)
    booth_chair, red_hardhat = insert_standing_flags(existing)
    flags = {
      is_in_csv: true,
      is_booth_chair: booth_chair,
      is_red_hardhat: red_hardhat
    }
    if existing
      existing.update!(**flags)
    else
      Membership.create!(
        participant:,
        organization: @organization,
        is_added_by_csv: true,
        **flags
      )
    end
  end

  def remove_membership(membership)
    if membership.is_added_by_csv
      destroy_csv_membership(membership)
    else
      membership.update!(is_in_csv: false)
    end
  end

  def destroy_csv_membership(membership)
    participant = membership.participant
    membership.destroy!
    participant.destroy! if Membership.where(participant:).blank?
  end

  def update_params
    params.expect(membership: %i[is_booth_chair title booth_chair_order])
  end

  def redirect_csv_error(message)
    redirect_to new_organization_membership_path(@organization), alert: message
  end
end
