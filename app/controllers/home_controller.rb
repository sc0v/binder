class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def milestones
  end

  def search
    @query = params[:query]
    
    @participant_lookup = Participant.find_by_card(@query)
    redirect_to @participant_lookup unless (@participant_lookup.nil?) 
    
    @tool_lookup = Tool.find_by_barcode(@query)
    redirect_to @tool_lookup unless(@tool_lookup.nil?)
    
    @faqs = Faq.search(@query)
    @participants = Participant.search(@query)
    @tools = Tool.search(@query)
    @organizations = Organization.search(@query)
    @organization_aliases = OrganizationAlias.search(@query)
  end
end
