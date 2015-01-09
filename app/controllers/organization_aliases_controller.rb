class OrganizationAliasesController < ApplicationController
  # permissions error - when enabled, this tries to find a OrganizationAlias with the current related model id on creation
  # load_and_authorize_resource
  responders :flash, :http_cache

  def new
    @organization_alias = OrganizationAlias.new
    organization = Organization.find(params[:organization_id])
    @organization_alias.organization = organization unless organization.blank?
    respond_with(@organization_alias)
  end

  def create
    @organization_alias = OrganizationAlias.new(alias_params)
    @organization_alias.save
    respond_with(@organization_alias)
  end

  def destroy
    @organization_alias = OrganizationAlias.find(params[:id])
    @org = @organization_alias.organization
    @organization_alias.destroy
    respond_with(@organization_alias)
  end

  private

  def alias_params
    params.require(:organization_alias).permit(:name, :organization_id)
  end
end

