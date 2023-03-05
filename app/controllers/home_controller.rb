class HomeController < ApplicationController
  def index
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
      redirect_to @participant_lookup
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

    @new_participant = Participant.search_ldap(@query)
  end

  def dev_login
    unless Rails.env.staging? or Rails.env.production?
      email = case params[:role]
        when 'Admin' then 'binder+admin_user@springcarnival.org'
        when 'SCC Member' then 'binder+scc_user@springcarnival.org'
        when 'Booth Chair' then 'binder+booth_chair_user@springcarnival.org'
        when 'Participant' then 'binder+rando_user@springcarnival.org'
      end

      sign_in(User.find_by(email: email))

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
