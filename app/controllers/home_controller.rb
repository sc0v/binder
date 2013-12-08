class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def milestones
  end

  def search
    @query = params[:query]
    @faqs = Faq.search(@query)
    @users = User.search(@query)
    @participants = Participant.search(@query)
    @tools = Tool.search(@query)
    @organizations = Organization.search(@query)
    @organization_aliases = OrganizationAlias.search(@query)
  end
end