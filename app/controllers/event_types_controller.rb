class EventTypesController < ApplicationController
  load_and_authorize_resource
  before_action :set_event_type, only: [:show, :edit, :update, :destroy]

  # GET /event_types
  # GET /event_types.json
  def index
    @event_types = EventType.all
  end

  # GET /event_types/1
  # GET /event_types/1.json
  def show
  end

  # GET /event_types/new
  def new
    @event_type = EventType.new
  end

  # GET /event_types/1/edit
  def edit
  end

  # POST /event_types
  # POST /event_types.json
  def create
    @event_type = EventType.new(event_type_params)

    respond_to do |format|
      if @event_type.save
        format.html { redirect_to @event_type, notice: 'Event type was successfully created.' }
        format.json { render :show, status: :created, location: @event_type }
      else
        format.html { render :new }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_types/1
  # PATCH/PUT /event_types/1.json
  def update
    respond_to do |format|
      if @event_type.update(event_type_params)
        format.html { redirect_to @event_type, notice: 'Event type was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_type }
      else
        format.html { render :edit }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_types/1
  # DELETE /event_types/1.json
  def destroy
    @event_type.destroy
    respond_to do |format|
      format.html { redirect_to event_types_url, notice: 'Event type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_type
      @event_type = EventType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_type_params
      params.require(:event_type).permit(:display, :name)
    end
end
