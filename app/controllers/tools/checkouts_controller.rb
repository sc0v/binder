class Tools::CheckoutsController < ApplicationController

  def new
    
  end
  
  def add
    session[:tools]||=[]
    tool = Tool.find_by(barcode: params[:barcode])
    if tool.present? && !session[:tools].include?(tool.id)
      session[:tools].append(tool.id)
    else
      flash.alert = "No tool found with that barcode. #{helpers.link_to 'Create it', new_tool_path, class: 'cta'}"
    end
    #redirect_to params[:url]
    #redirect_to tools_path
    redirect_to checkout_tools_path
  end

  def remove
    session[:tools].delete(params[:id].to_i)
    #redirect_to tools_path
    redirect_to checkout_tools_path
  end

  def participant
    borrower = Participant.find_by_search(params[:participant_search])
    if borrower.present?
      session[:borrower_id] = borrower.id
    else
      flash.alert = "Andrew ID \"#{params[:participant_search]}\" not found."
    end
    (redirect_to params[:url] and return) unless !params[:url].present?
    redirect_to checkout_tools_path
  end

  def reset
    session[:borrower_id] = nil
    session[:tools] = nil
    #redirect_to tools_path
    redirect_to checkout_tools_path
  end
  
  def create
    return unless params[:checkout].present? && params[:checkout][:organization_id].present?
    #returnif params[:checkout][:organization_id].present?
      @organization = Organization.find(params[:checkout][:organization_id])
      return if @organization.blank?

      if session[:tools].empty?
        flash.alert = "Add at least one tool to checkout."
        return
      end
      bad_barcodes = []
      p = Participant.find(session[:borrower_id])
      session[:tools].each do |tool_id|
        # begin
          t = Tool.find(tool_id)
          if Checkout.create(organization: @organization,
                             participant: p,
                             tool: t,
                             checked_out_at: Time.zone.now).persists?
            session[:tools] -= [tool_id]
          else
            bad_barcodes.append(t.barcode)
          end
        # rescue
        #   flash.alert = "Error checking out tool #{t.barcode}"
        # end
      end
      
      if session[:tools].empty?
        session[:borrower_id] = nil
        flash.notice = "Tools checked out to #{p.name}"
      else
        flash.alert = "Problem checking out tools #{bad_barcodes.join(', ')}"
        #redirect_to tools_path
      end
      redirect_to checkout_tools_path
    #end
  end
  def update
    @tool = Tool.find_by(barcode: params[:barcode])
    if @tool.blank?
      redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} does not exist."
    else
      @checkout = @tool.checkouts.current.first unless @tool.checkouts.blank? || @tool.checkouts.current.blank?
      raise CheckoutError, I18n.t('errors.messages.tool_already_checked_in') if @checkout.blank?
      @checkout.checked_in_at = Time.zone.now
      @checkout.save!
      redirect_to checkout_tools_path, notice: "Tool #{params[:barcode]} successfully checked in."
    end
  rescue
    redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} was never checked out."
  end
end
