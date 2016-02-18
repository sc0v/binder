class ToolWaitlistsController < ApplicationController
  load_and_authorize_resource

  # GET /tool_waitlists/new
  def new
    @tool_waitlist = ToolWaitlist.new
  end

  # POST /tool_waitlists
  # POST /tool_waitlists.json
  def create
    @tool_waitlist = ToolWaitlist.new(tool_waitlist_params)

    respond_to do |format|
      if @tool_waitlist.save
        format.html { redirect_to @tool_waitlist, notice: 'Tool waitlist was successfully created.' }
        format.json { render :show, status: :created, location: @tool_waitlist }
      else
        format.html { render :new }
        format.json { render json: @tool_waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_waitlists/1
  # DELETE /tool_waitlists/1.json
  def destroy
    @tool_waitlist.destroy
    respond_to do |format|
      format.html { redirect_to tool_waitlists_url, notice: 'Tool waitlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_waitlist_params
      params[:tool_waitlist]
    end
end
