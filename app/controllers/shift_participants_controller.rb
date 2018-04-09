# ## Schema Information
#
# Table name: `shift_participants`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`clocked_in_at`**   | `datetime`         |
# **`created_at`**      | `datetime`         |
# **`id`**              | `integer`          | `not null, primary key`
# **`participant_id`**  | `integer`          |
# **`shift_id`**        | `integer`          |
# **`updated_at`**      | `datetime`         |
#
# ### Indexes
#
# * `index_shift_participants_on_participant_id`:
#     * **`participant_id`**
# * `index_shift_participants_on_shift_id`:
#     * **`shift_id`**
#

class ShiftParticipantsController < ApplicationController
  # DELETE /shift_participants/1
  # DELETE /shift_participants/1.json
  def destroy
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift = @shift_participant.shift
    @shift_participant.destroy
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  # GET
  def new
    @shift_participant = ShiftParticipant.new
    shift = Shift.find(params[:shift_id])
    @shift_participant.shift = shift
  end

  # UPDATE
  def update
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift_participant.clocked_in_at = Time.now
    @shift_participant.save
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  # POST
  def create
    clock_in_now = params[:shift_participant][:clock_in_now]
    @shift_participant = ShiftParticipant.new(params.require(:shift_participant).permit(:shift_id, :participant_id))
    
    if clock_in_now
      @shift_participant.clocked_in_at = Time.now
    end
    @shift_participant.save
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end
end
