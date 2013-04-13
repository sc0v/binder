class MembershipsController < ApplicationController

  def new
    @participant = Participant.find params[:participant_id]
    @membership = @participant.memberships.build
    @organizations = Organization.all - @participant.organizations
  end

  def create
    @participant = Participant.find params[:participant_id]
    @organization = Organization.find params[:organization_id]

    unless @organization.nil? or @participant.nil?
      @membership = @participant.memberships.create( organization: @organization )
    end

    respond_to do |format|
      format.html { redirect_to action: 'new' }
      format.js
    end
  end

  def destroy
    @participant = Participant.find params[:participant_id]
    @membership = Membership.find params[:id]

    unless @membership.nil? or @participant.nil?
      Membership.destroy( params[:id])
    end

    respond_to do |format|
      format.html { redirect_to action: 'new' }
      format.js
    end
    
  end

end
