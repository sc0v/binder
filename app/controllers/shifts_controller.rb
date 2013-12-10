class ShiftsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  
  # GET /shifts
  # GET /shifts.json
  # Regular index is watch shifts by default
  def index
    @title = "Watch Shifts"
    @shifts = Shift.watch_shifts.paginate(:page => params[:page]).per_page(10)
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end
  
  # GET /shifts/sec_shifts
  # GET /sec_shifts.json
  def sec_shifts
    @title = "Security Shifts"
    @shifts = Shift.sec_shifts.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @tools }
    end
  end
  
  # GET /shifts/coord_shifts
  # GET /coord_shifts.json
  def coord_shifts
    @title = "Coordinator Shifts"
    @shifts = Shift.coord_shifts.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @tools }
    end
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    @shift = Shift.find(params[:id])
    @shift_participants = ShiftParticipant.find_all_by_shift_id(@shift.id)
    @shift_participants_count = @shift_participants.size

    @number_spots_left = @shift.required_number_of_participants - @shift_participants_count

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shift }
    end
  end

  # GET /shifts/new
  # GET /shifts/new.json
  def new
    @shift = Shift.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shift }
    end
  end

  # GET /shifts/1/edit
  def edit
    @shift = Shift.find(params[:id])
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(params[:shift])

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render json: @shift, status: :created, location: @shift }
      else
        format.html { render action: "new" }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shifts/1
  # PUT /shifts/1.json
  def update
    @shift = Shift.find(params[:id])

    respond_to do |format|
      if @shift.update_attributes(params[:shift])
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to shifts_url }
      format.json { head :no_content }
    end
  end
end
