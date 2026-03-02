# frozen_string_literal: true

class EventsController < ApplicationController
  load_and_authorize_resource
  before_action :set_event, only: %i[show edit update destroy approve]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @scc_members = Participant.all.scc
  end

  # PUT
  def approve
    @event.is_done = !@event.is_done
    @event.save
    redirect_to :back,
                notice:
                  "The note was #{@event.is_done ? 'acknowledged' : 'unacknowledged'}"
  end

  # GET /events/1/edit
  def edit
    @scc_members = Participant.all.scc
    @event.updated_at = DateTime.now
    @event.save
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.created_at = DateTime.now
    @event.updated_at = DateTime.now
    @event.is_done = false
    respond_to do |format|
      if @event.save
        format.html do
          redirect_to @event, notice: t('.notice')
        end
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @eventors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html do
          redirect_to @event, notice: t('.notice')
        end
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json do
          render json: @event.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html do
        redirect_to events_url, notice: t('.notice')
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.expect(
      event: %i[
        is_done
        title
        created_at
        description
        updated_at
        display
        event_type_id
        participant_id
      ]
    )
  end
end
