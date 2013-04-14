class ParticipantsController < ApplicationController

  def lookup
    # Process request if barcode is present
    if params[:participant] and params[:participant][:card_number]
      participant = Participant.find_by_card params[:participant][:card_number]
      
      if participant.nil? # participant does not exist

        # Find the andrew id associated with the card or it's an error
        andrewid = CarnegieMellonIDCard.search "#{params[:participant][:card_number]}"
        unless andrewid.nil?
          params[:participant][:andrewid] = andrewid
          redirect_to new_participant_url params[:participant]
        else
          flash[:error] = "Invalid card" 
        end

      else
        redirect_to participant_url participant
      end
    end # if params[:participant] and params[:participant][:card_number]
  end

  def index
    @participant_list = Participant.all
  end

  def show
    @participant = Participant.find params[:id]
    @memberships = @participant.memberships.all
  end

  def new
    # Perform a card number lookup and then populate
    # the new participant's detail
    
    if params[:andrewid].nil? or params[:andrewid] == ''
      render 'lookup'
    else
      if params[:participant] # participant populated from previous new
        params[:participant][] << params[:andrewid]
        @participant = Participant.new params[:participant]
      else # participant only has card number from lookup
        @participant = Participant.new andrewid: params[:andrewid]
      end
      render 'new'
    end
  end

  def create
    participant = Participant.new( params[:participant] )
    participant.save!
    flash[:success] = "Successfully created participant #{participant.name}"

    # Use a form parameter to determine whether to 
    # add multiple participants sequentially, or go
    # to a pre-specified return url after adding
    # participant memberships
    unless params[:return_url].nil?
      session[:return_url] = params[:return_url]
    end
    
    redirect_to new_participant_membership_url participant

  rescue
    flash[:error] = "Error creating participant"
    redirect_to new_participant_url
    # TODO: direct to participant page if participant already exists
  end
  
end
