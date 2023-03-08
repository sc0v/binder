# frozen_string_literal: true

class OrganizationAliasesController < ApplicationController
  # permissions error - when enabled, this tries to find a OrganizationAlias with the current related model id on creation
  responders :flash, :http_cache

  def index
    return redirect_to root_url, alert: 'Not Authorized to see Aliases' unless can? :read, OrganizationAlias

    @organization = Organization.find(params[:organization_id])
    @organization_aliases = @organization.organization_aliases # .paginate(:page => params[:page]).per_page(10)
  end

  def new
    @organization_alias = OrganizationAlias.new
    organization = Organization.find(params[:organization_id])
    @organization_alias.organization = organization if organization.present?
    respond_with(@organization_alias)
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @organization_alias = OrganizationAlias.new(alias_params)
    @organization_alias.save
    redirect_to organization_path(@organization), notice: 'Alias was successfully created.'
  end

  def destroy
    @organization_alias = OrganizationAlias.find(params[:id])
    @organization = @organization_alias.organization
    @organization_alias.destroy
    redirect_to organization_path(@organization), notice: 'Alias was successfully deleted.'
  end

  private

  def alias_params
    params.require(:organization_alias).permit(:name, :organization_id)
  end
end
