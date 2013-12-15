class OrganizationAliasesController < ApplicationController
  # permissions error - when enabled, this tries to find a OrganizationAlias with the current related model id on creation
  # load_and_authorize_resource

  def new
    @organization_alias = OrganizationAlias.new
    organization = Organization.find(params[:organization_id])
    @organization_alias.organization = organization unless organization.blank?

    respond_to do |format|
      format.html # new_alias.html.erb
      format.json { render json: @organization_alias }
    end
  end

  def create
    @organization_alias = OrganizationAlias.new(alias_params)

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

  def destroy
    @organization_alias = OrganizationAlias.find(params[:id])
    @org = @organization_alias.organization
    @organization_alias.destroy

    respond_to do |format|
      format.html { redirect_to @org }
      format.json { head :no_content }
    end
  end

  private

  def alias_params
    params.require(:organization_alias).permit(:name, :organization_id)
  end
end

