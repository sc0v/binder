# frozen_string_literal: true

class ShiftsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create]
  before_action :set_shift, only: %i[show edit update destroy]

  # GET /shifts
  # GET /shifts.json
  # Regular index is watch shifts by default
  def index
    s = shifts

    @title = case params[:type]
             when 'watch'
               s = shifts.watch_shifts
               'Watch Shifts'
             when 'security'
               s = shifts.sec_shifts
               'Security Shifts'
             when 'coordinator'
               s = shifts.coord_shifts
               'Coordinator Shifts'
             else
               'All Shifts'
             end

    @shifts_upcoming = s.where('ends_at > ?', Time.zone.now)
    @shifts_past = s.where('ends_at <= ?', Time.zone.now)
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    @number_spots_left = @shift.required_number_of_participants - @shift.shift_participants.count
  end

  # GET /shifts/new
  # GET /shifts/new.json
  def new
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit; end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(shift_params)
    @shift.save
    respond_with(@shift)
  end

  # PUT /shifts/1
  # PUT /shifts/1.json
  def update
    @shift.update(shift_params)
    respond_with(@shift)
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_with(@shift)
  end

  private

  def shifts
    return Shift.all if Current.user.admin? || Current.user.scc?

    @orgs = Current.user.memberships.map { |mem| mem.organization.id }
    Shift.for_organizations(@orgs)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:starts_at, :ends_at, :shift_type_id, :organization_id,
                                  :required_number_of_participants, :description)
  end
end
