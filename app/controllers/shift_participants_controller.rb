class ShiftParticipantsController < ApplicationController
  # permissions error - when enabled, this tries to find a ShiftParticipant with the current related model id on creation

  # GET /shift_participants
  # GET /shift_participants.json
  def index
    @shift_participants = ShiftParticipant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shift_participants }
    end
  end

  # GET /shift_participants/1
  # GET /shift_participants/1.json
  def show
    @shift_participant = ShiftParticipant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shift_participant }
    end
  end

  # GET /shift_participants/new
  # GET /shift_participants/new.json
  def new
    @shift_participant = ShiftParticipant.new(params[:shift])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shift_participant }
    end
  end

  # GET /shift_participants/1/edit
  def edit
    @shift_participant = ShiftParticipant.find(params[:id])
  end

  # POST /shift_participants
  # POST /shift_participants.json
  def create
    @shift_participant = ShiftParticipant.new(params[:shift_participant])

    respond_to do |format|
      if @shift_participant.save
        format.html { redirect_to @shift_participant, notice: 'Shift participant was successfully created.' }
        format.json { render json: @shift_participant, status: :created, location: @shift_participant }
      else
        format.html { render action: "new" }
        format.json { render json: @shift_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shift_participants/1
  # PUT /shift_participants/1.json
  def update
    @shift_participant = ShiftParticipant.find(params[:id])

    respond_to do |format|
      if @shift_participant.update_attributes(params[:shift_participant])
        format.html { redirect_to @shift_participant, notice: 'Shift participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shift_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shift_participants/1
  # DELETE /shift_participants/1.json
  def destroy
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift_participant.destroy

    respond_to do |format|
      format.html { redirect_to shift_participants_url }
      format.json { head :no_content }
    end
  end

  # GET
  def new_shift_clock_in
    @shift_participant = ShiftParticipant.new
    @shift = Shift.find(params[:id])
    @shift_participant.shift = @shift

    respond_to do |format|
      format.html # new_shift_clock_in.html.erb
      format.json { render json: @shift_participants }
    end
  end

  # GET
  def new_shift_clock_out
    @shift_participant = ShiftParticipant.find(params[:id])

    @shift = @shift_participant.shift
    @participant = @shift_participant.participant

    respond_to do |format|
      format.html # new_shift_clock_out.html.erb
      format.json { render json: @shift_participants }
    end
  end

  class ShiftDoesNotExist < Exception
  end

  class ParticipantDoesNotExist < Exception
  end

  class ParticipantDoesNotMatch < Exception
  end

  # POST
  def create_shift_clock_in
    @shift_participant = ShiftParticipant.new
    @shift_participant.clocked_in_at = Time.now
    @shift = Shift.find_by_id(params[:shift_participant][:shift_id])
    raise ShiftDoesNotExist unless !@shift.nil?

    #do app logic validation here where the participant id field can map to different organizations.
        #this could be cool for having a student id number represent an organization and instead of participant_id we will change it to an organization_id
        @participant = Participant.find_by_card(params[:shift_participant][:card_number].to_s) #this creates a CMU directory request to get the andrew id associated with the card number. Then finds the local DB mapping to get the participant id.
        raise ParticipantDoesNotExist unless !@participant.nil?

      @shift_participant.shift_id = @shift.id
      @shift_participant.participant_id = @participant.id

      respond_to do |format|
        if @shift_participant.save
          format.html { redirect_to @shift, notice: "#{@participant.name} was successfully checked in." }
          format.json { render json: @shift, status: :created, location: @shift }
        else
          format.html { render action: "new" }
          format.json { render json: @shift_participant.errors, status: :unprocessable_entity }
        end
      end
    end

    # POST
    def create_shift_clock_out
      @shift_participant = ShiftParticipant.find(params[:shift_participant][:id])
      @shift_participant.clocked_out_at = Time.now

      #do app logic validation here where the participant id field can map to different organizations.
          #this could be cool for having a student id number represent an organization and instead of participant_id we will change it to an organization_id
          @participant = Participant.find_by_card(params[:shift_participant][:card_number].to_s) #this creates a CMU directory request to get the andrew id associated with the card number. Then finds the local DB mapping to get the participant id.
          raise ParticipantDoesNotExist unless !@participant.nil?

        raise ParticipantDoesNotMatch unless (@participant.name == Participant.find_by_id(@shift_participant.participant).name)

        respond_to do |format|
          if @shift_participant.save!
            format.html { redirect_to @shift_participant.shift, notice: "#{@participant.name} was successfully checked out." }
            format.json { render json: @shift_participant.shift, status: :created, location: @shift }
          else
            format.html { render action: "new" }
            format.json { render json: @shift_participant.errors, status: :unprocessable_entity }
          end
        end
      end
    end