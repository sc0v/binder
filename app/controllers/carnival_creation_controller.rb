class CarnivalCreationController < ApplicationController
  def show_uploader
  end

  def show_diff
    @organization_adds = Rails.cache.read('organization_insertions') | Rails.cache.read('organization_reactivations')
    @participant_adds = Rails.cache.read('participant_insertions') | Rails.cache.read('participant_reactivations')
    @membership_adds = Rails.cache.read('membership_insertions')

    @organization_deactivations = Rails.cache.read('organization_deactivations')
    @participant_deactivations = Rails.cache.read('participant_deactivations')
  end

  def upload_csvs
    c = CsvUpdater.new()
    c.add_from_csv(params[:organization_csv].tempfile, 'organization')
    c.add_from_csv(params[:participant_csv].tempfile, 'participant')
    # c.add_from_csv(params[:participant_csv].tempfile, 'membership')
    redirect_to :show_diff
  end

  def commit_changes
    # TODO: dump current DB state
    c = CsvUpdater.new()
    c.seed_organizations()
    c.seed_participants()
    c.seed_memberships()

    # clear the cache, where all info about insertions/deletions was stored
    Rails.cache.clear
    
    redirect_to :show_end_index
  end

  def show_end_index
  end
end
