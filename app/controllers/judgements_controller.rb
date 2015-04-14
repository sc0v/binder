class JudgementsController < ApplicationController
  load_and_authorize_resource

  def index
  	@organization_categories = OrganizationCategory.all.includes(:organizations)
  end

  def show
  	@organization = Organization.find(params[:organization_id])	
  	@judgement_categories = JudgementCategory.all
  end
end