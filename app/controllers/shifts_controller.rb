# frozen_string_literal: true

class ShiftsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create]
  before_action :set_shift, only: %i[show edit update destroy]

  # GET /shifts
  # GET /shifts.json
  # Regular index is watch shifts by default
  def index
    s = shifts
    @title, s = filtered_shifts(s)
    @shifts_upcoming = s.where('ends_at > ?', Time.zone.now)
    @shifts_past = s.where(ends_at: ..Time.zone.now)
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  # GET /shifts/new.json
  VALID_STEPS = %w[csv_upload repair].freeze
  def new
    @shift = Shift.new
    @step = VALID_STEPS.include?(params[:step]) ? params[:step] : 'csv_upload'
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      create_shift_participants
      flash[:notice] = t('.notice')
      redirect_to shifts_path
    else
      flash[:error] = t('.error')
    end
    # respond_with(@shift)
  end

  # PUT /shifts/1
  # PUT /shifts/1.json
  def update
    @shift.update(shift_params)
    redirect_to shifts_path
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    flash[:notice] = t('.notice')
    redirect_to shifts_path
  end

  private

  def upload_csv
    csv_file = params[:csv_file]
    return redirect_csv_error(t('.csv_not_uploaded')) if csv_file.blank?

    parse = helpers.parse_shift_csv(csv_file)
    return redirect_csv_error(parse[:error]) if parse[:error].present?

    redirect_to new_shift_path(step: 'repair')
  end

  def filtered_shifts(base)
    case params[:type]
    when 'watch'
      ['Watch Shifts', base.watch_shifts]
    when 'security'
      ['Security Shifts', base.sec_shifts]
    when 'coordinator'
      ['Coordinator Shifts', base.coord_shifts]
    else
      ['All Shifts', base]
    end
  end

  def shifts
    return Shift.all if Current.user.admin? || Current.user.scc?

    @orgs = Current.user.memberships.map { |mem| mem.organization.id }
    Shift.for_organizations(@orgs)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.expect(
      shift: %i[
        starts_at
        ends_at
        shift_type_id
        organization_id
        description
        capacity
        andrewids
      ]
    )
  end

  def create_shift_participants
    return if @shift.andrewids.blank?

    @shift.andrewids.split(';').each do |andrewid|
      andrewid = andrewid.strip
      participant = Participant.find_by(eppn: "#{andrewid}@andrew.cmu.edu")
      unless participant
        Rails.logger.debug { "Participant (#{andrewid}) does not exist" }
        next
      end
      ShiftParticipant.create(shift: @shift, participant:)
    end
  end
end
