class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def milestones
  end

  def search
    @query = params[:query]
    
    @participant_lookup = Participant.find_by_card(@query)
    unless @participant_lookup.nil?
      if @participant_lookup.organizations.blank?
        redirect_to new_participant_membership_path(@participant_lookup)
      else
        redirect_to @participant_lookup
      end
    end
    
    @tool_lookup = Tool.find_by_barcode(@query)
    redirect_to @tool_lookup unless(@tool_lookup.nil?)
    
    @faqs = Faq.search(@query)
    @participants = Participant.search(@query)
    @tools = Tool.search(@query)
    @organizations = Organization.search(@query)
    @organization_aliases = OrganizationAlias.search(@query)
  end
end
