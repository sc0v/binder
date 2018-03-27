class HomeController < ApplicationController
  def index
    # need to find a way to get user
    if user_signed_in?
      @user = current_user
      @curr_memberships = @user.participant.memberships
      @pending_memberships = OrganizationList.user_orgs(@user.participant.andrewid)
      if !@pending_memberships.empty?
        for pending_membership in @pending_memberships
          unless @curr_memberships.map(&:organization_id).include?(pending_membership.organization_id)
              Membership.create!(organization_id: pending_membership.organization_id, participant_id: @user.participant.id)
          end
          OrganizationList.destroy(pending_membership)
        end
      end
    end
  end

  def milestones
  end

  def search
    authorize! :search, nil

    if params.blank? or params[:query].blank?
      flash[:error] = "Please enter a query"
      redirect_to root_url
      return
    end

    @query = params[:query]

    @participant_lookup = Participant.find_by_card(@query, true)
    unless @participant_lookup.nil?
      if @participant_lookup.organizations.blank? and can?(:create, Membership)
        redirect_to new_participant_membership_path(@participant_lookup)
        return
      else
        redirect_to @participant_lookup
        return
      end
    end

    @tool_lookup = Tool.find_by_barcode(@query)
    unless @tool_lookup.nil?
      redirect_to @tool_lookup
      return
    end

    @org = Organization.where('lower(name) = lower(?) OR lower(short_name) = lower(?)', @query, @query).first
    org_alias = OrganizationAlias.where('lower(name) = lower(?)', @query).first unless !@org.blank?
    @org = org_alias.organization unless org_alias.blank?

    unless @org.blank?
      redirect_to @org
      return
    end

    @faqs = Faq.search(@query) if can?(:read, Faq)
    @participants = Participant.search(@query)
    @tools = Tool.search(@query)
    @organizations = Organization.search(@query)
    @organization_aliases = OrganizationAlias.search(@query)
    @documents = Document.search(@query)

    @new_participant = Participant.search_ldap(@query)
  end

  def dev_login
    unless Rails.env.staging? or Rails.env.production?
      email = case params[:role]
        when 'Admin' then 'rcrown@andrew.cmu.edu'
        when 'SCC Member' then 'cbrownel@andrew.cmu.edu'
        when 'Booth Chair' then 'rpwhite@andrew.cmu.edu'
        when 'Participant' then 'nharper@andrew.cmu.edu'
      end

      sign_in(:user, User.find_by_email(email))

      session[:name] = params[:role]
    end

    redirect_to root_url
  end

  def hardhats
    @organizations = Organization.joins(:tools).distinct
    authorize! :read, @organizations
    @total = Tool.hardhats.checked_out.count
  end

  def charge_overview
    @organizations = Organization.joins(:charges).distinct.includes(:charges)
    authorize! :read, @organizations
    @charge_types = ChargeType.all.includes(:charges)
    @approved_total = Charge.approved.sum('amount')
    @pending_total = Charge.pending.sum('amount')
    @total = Charge.all.sum('amount')
  end

  def downtime
    @organizations = Organization.only_categories(['Fraternity', 'Sorority', 'Independent', 'Blitz', 'Concessions'])
    authorize! :read, @organizations
  end

  def hardhat_return
  end
end
