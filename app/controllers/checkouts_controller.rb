class CheckoutsController < ApplicationController
  # permissions error - when enabled, this tries to find a Checkout with the current related model id on creation
  # load_and_authorize_resource

  # GET /checkouts
  # GET /checkouts.json
  def index
    @checkouts = Checkout.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkouts }
    end
  end

  # GET
  def new_tool_checkout
    @checkout = Checkout.new
    @checkout.tool_id = Tool.find_by_id(params[:tool_id]).barcode unless params[:tool_id].nil?

    respond_to do |format|
      format.html # new_tool_checkout.html.erb
      format.json { render json: @checkouts }
    end
  end

  # GET
  def new_tool_checkin
    @checkout = Checkout.new
    @checkout.tool_id = Tool.find_by_id(params[:tool_id]).barcode unless params[:tool_id].nil?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkouts }
    end
  end

  #declare error classes
  class ToolAlreadyCheckedIn < Exception
  end

  class ToolAlreadyCheckedOut < Exception
  end

  class ToolDoesNotExist < Exception
  end

  class ParticipantDoesNotExist < Exception
  end

  class OrganizationDoesNotExist < Exception
  end

  # POST
  def create_tool_checkout
    @checkout = Checkout.new

    @tool = Tool.find_by_barcode(params[:checkout][:tool_id])
    raise ToolDoesNotExist unless !@tool.nil?

    raise ToolAlreadyCheckedOut unless not @tool.is_checked_out?

    @participant = Participant.find_by_card(params[:checkout][:card_number].to_s) #this creates a CMU directory request to get the andrew id associated with the card number. Then finds the local DB mapping to get the participant id.
    
    @participant = Participant.find_by_andrewid(params[:checkout][:card_number]) unless !@participant.nil?

    raise ParticipantDoesNotExist unless !@participant.nil?

    if @participant.organizations.size > 1
      respond_to do |format|
        format.html { render "choose_organization", :tool => @tool, :participant => @participant }
        format.json { render json: @checkouts }
      end
    else
      @checkout.checked_out_at = Time.now
      @checkout.tool_id = @tool.id
      @checkout.participant_id = @participant.id
      @checkout.organization_id = @participant.organizations.first.id unless @participant.organizations.nil? or @participant.organizations.first.nil?

      respond_to do |format|
        if @checkout.save
          format.html { redirect_to @checkout.tool, notice: 'Checkout was successfully created.' }
          format.json { render json: @checkout, status: :created, location: @checkout }
        else
          format.html { render action: "new" }
          format.json { render json: @checkout.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # POST
  def create_tool_checkout_organization_selected
    @checkout = Checkout.new

    @tool = Tool.find(params[:tool])
    raise ToolDoesNotExist unless !@tool.nil?

    raise ToolAlreadyCheckedOut unless not @tool.is_checked_out?

    @participant = Participant.find(params[:participant])
    raise ParticipantDoesNotExist unless !@participant.nil?

    @organization = Organization.find(params[:organization])
    raise OrganizationDoesNotExist unless !@participant.nil?

    @checkout.checked_out_at = Time.now
    @checkout.tool_id = @tool.id
    @checkout.participant_id = @participant.id
    @checkout.organization_id = @organization.id

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to @checkout.tool, notice: 'Checkout was successfully created.' }
        format.json { render json: @checkout, status: :created, location: @checkout }
      else
        format.html { render action: "new" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST
  def create_tool_checkin
    @tool = Tool.find_by_barcode(params[:checkout][:tool_id])
    raise ToolDoesNotExist unless !@tool.nil?

    raise ToolAlreadyCheckedIn unless @tool.is_checked_out?

    @checkout = Checkout.current.find_by_tool_id(@tool.id)
    @checkout.checked_in_at = Time.now

    puts @checkout.checked_in_at

    respond_to do |format|
      if @checkout.save!
        format.html { redirect_to @checkout.tool, notice: "#{@checkout.tool.name} was checked in." }
        format.json { render json: @checkout, status: :created, location: @checkout }
      else
        format.html { render action: "new" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /checkouts/1
  # GET /checkouts/1.json
  def show
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkout }
    end
  end

  # GET /checkouts/new
  # GET /checkouts/new.json
  def new
    @checkout = Checkout.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkout }
    end
  end

  # GET /checkouts/1/edit
  def edit
    @checkout = Checkout.find(params[:id])
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)
    @checkout.checked_out_at = Date.today

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to @checkout, notice: 'Checkout was successfully created.' }
        format.json { render json: @checkout, status: :created, location: @checkout }
      else
        format.html { render action: "new" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.json
  def update
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      if @checkout.update_attributes(checkout_params)
        format.html { redirect_to @checkout, notice: 'Checkout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.json
  def destroy
    @checkout = Checkout.find(params[:id])
    @checkout.destroy

    respond_to do |format|
      format.html { redirect_to checkouts_url }
      format.json { head :no_content }
    end
  end

  private

  def checkout_params
    params.require(:checkout).permit(:checked_in_at, :checked_out_at, :participant, :organization, :tool)
  end
end

