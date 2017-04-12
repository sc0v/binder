# ## Schema Information
#
# Table name: `shifts`
#
# ### Columns
#
# Name                                   | Type               | Attributes
# -------------------------------------- | ------------------ | ---------------------------
# **`created_at`**                       | `datetime`         |
# **`description`**                      | `string(255)`      |
# **`ends_at`**                          | `datetime`         |
# **`id`**                               | `integer`          | `not null, primary key`
# **`organization_id`**                  | `integer`          |
# **`required_number_of_participants`**  | `integer`          |
# **`shift_type_id`**                    | `integer`          |
# **`starts_at`**                        | `datetime`         |
# **`updated_at`**                       | `datetime`         |
#
# ### Indexes
#
# * `index_shifts_on_organization_id`:
#     * **`organization_id`**
#

class ShiftsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  
  # GET /shifts
  # GET /shifts.json
  # Regular index is watch shifts by default
  def index
    if (current_user.has_role? :admin)
      @shifts = Shift.all
    elsif (current_user.participant.is_scc?)
      @shifts = Shift.all
    else
      @orgs = current_user.participant.memberships.map {|mem| mem.organization.id}
      unless @orgs.nil?
        @shifts = Shift.for_organizations(@orgs)
      end
    end

    if (params[:type].blank?)
      @title = "Shifts"
      @shifts = @shifts
    elsif (params[:type] == "watch")
      @title = "Watch Shifts"
      @shifts = @shifts.watch_shifts
    elsif (params[:type] == "security")
      @title = "Security Shifts"
      @shifts = @shifts.sec_shifts
    elsif (params[:type] == "coordinator")
      @title = "Coordinator Shifts"
      @shifts = @shifts.coord_shifts
    end

    @shifts = @shifts.paginate(:page => params[:page]).per_page(20)
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
  def edit
  end

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

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:starts_at, :ends_at, :shift_type_id, :organization_id, :required_number_of_participants, :description)
  end
  
end
