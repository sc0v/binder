class CheckoutsController < ApplicationController

  def lookup
    if session[:tool_id]
      # Tool lookup returned tool id, do a checkout
      tool = Tool.find session[:tool_id]
      session[:tool_id] = nil
      session[:return_url] = nil

      if tool.is_checked_out?
        redirect_to checkout_url( tool.checkouts.current[0] )
      else
        redirect_to new_tool_checkout_url tool
      end

    else
      # No tool lookup has yet occurred, do one
      session[:return_url] = checkout_lookup_url
    end
  end


  def index
    #@checkouts = Checkout.all
    redirect_to checkout_lookup_url
  end


  def show
    @checkout = Checkout.find params[:id]
  end


  def new
    @tool = Tool.find( params[:tool_id] )

    # No participant lookup has yet occurred, do one
    unless session[:participant_id] and session[:participant_id] != ''
      session[:return_url] = new_tool_checkout_url @tool 

    else
      @checkout = @tool.checkouts.build
      @checkout.participant = Participant.find session[:participant_id]
      @checkout.tool = @tool
      session[:participant_id] = nil
      session[:return_url] = nil
    end
                                           
  rescue
    flash[:notice] = "Tool you're attempting to checkout does not exist"
    redirect_to checkout_lookup_url
  end


  def create
    @checkout = Checkout.new params[:checkout]
    @checkout.checked_out_at = Time.now
    @checkout.save!
    redirect_to checkout_lookup_url
  end


  def destroy
    checkout = Checkout.find params[:id]
    if checkout.tool.is_checked_out?
      checkout.checked_in_at = Time.now
      checkout.save!
      flash[:success] = "Tool checked in"
    end
    redirect_to checkout_lookup_url

  rescue
    flash[:error] = "Error checking in"
    redirect_to checkout_lookup_url
  end

end
