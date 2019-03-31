class CarnivalCreationController < ApplicationController
  before_filter { authorize! :manage, :carnival_creation }

  def show_uploader
  end

  def show_diff
    @organization_adds = Rails.cache.read('organization_insertions') | Rails.cache.read('organization_reactivations')
    @participant_adds = Rails.cache.read('participant_insertions') | Rails.cache.read('participant_reactivations')
    @membership_adds = Rails.cache.read('membership_insertions') |  Rails.cache.read('membership_reactivations')
    @tool_adds = Rails.cache.read('tool_insertions') |  Rails.cache.read('tool_reactivations')
    @shift_adds = Rails.cache.read('shift_insertions')

    @organization_deactivations = Rails.cache.read('organization_deactivations')
    @participant_deactivations = Rails.cache.read('participant_deactivations')
    @membership_deactivations = Rails.cache.read('membership_deactivations')
    @tool_deactivations = Rails.cache.read('tool_deactivations')
  end

  def upload_csvs
    c = CsvUpdater.new()
    c.add_from_csv(params[:organization_csv].tempfile, 'organization')
    c.add_from_csv(params[:participant_csv].tempfile, 'participant')
    c.add_from_csv(params[:participant_csv].tempfile, 'membership')
    c.add_from_csv(params[:tool_csv].tempfile, 'tool')
    c.add_from_csv(params[:shift_csv].tempfile, 'shift')
    redirect_to :show_diff
  end

  def commit_changes
    # TODO: dump current DB state
    c = CsvUpdater.new()
    c.run_mandatory_seeds()

    # clear the cache, where all info about insertions/deletions was stored
    Rails.cache.clear
    
    redirect_to :show_end_index
  end

  def show_end_index
  end
end
