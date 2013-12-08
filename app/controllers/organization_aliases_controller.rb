class OrganizationAliasesController < ApplicationController
  # permissions error - when enabled, this tries to find a OrganizationAlias with the current related model id on creation
  # load_and_authorize_resource

  def new_alias
    @organization_alias = OrganizationAlias.new
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # new_alias.html.erb
      format.json { render json: @organization_alias }
    end
  end

  def create_alias
    @organization_alias = OrganizationAlias.new(params[:organization_alias])

    respond_to do |format|
      if @organization_alias.save
        format.html { redirect_to @organization_alias.organization, notice: 'Alias was successfully created.' }
        format.json { render json: @organization_alias.organization, status: :created, location: @organization_alias.organization }
      else
        format.html { redirect_to @organization_alias.organization, error: 'Alias was not successfully created.' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_alias
    @organization_alias = OrganizationAlias.find(params[:id])
    @org = @organization_alias.organization
    @organization_alias.destroy

    respond_to do |format|
      format.html { redirect_to @org }
      format.json { head :no_content }
    end
  end

end