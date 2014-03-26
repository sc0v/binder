class HomeController < ApplicationController
  def index
  end

  def milestones
  end

  def search
    @query = params[:query]
    
    @tool_lookup = Tool.find_by_barcode(@query)
    unless @tool_lookup.nil?
      redirect_to @tool_lookup
      return
    end
    
    @participant_lookup = Participant.find_by_card(@query)
    unless @participant_lookup.nil?
      if @participant_lookup.organizations.blank?
        redirect_to new_participant_membership_path(@participant_lookup)
        return
      else
        redirect_to @participant_lookup
        return
      end
    end
    
    @faqs = Faq.search(@query)
    @participants = Participant.search(@query)
    @tools = Tool.search(@query)
    @organizations = Organization.search(@query)
    @organization_aliases = OrganizationAlias.search(@query)
  end
end
