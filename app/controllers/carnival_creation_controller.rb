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

    # find params that have .csv files and cache their data
    params.each do |key, val|
      if key.include?('_csv')
        c.add_from_csv(val.tempfile, key.chomp('_csv'))
      end
    end

    redirect_to :show_diff
  end

  def upload_optional_csvs
    c = CsvUpdater.new()

    # find params that have .csv files and cache their data
    params.each do |key, val|
      if key.include?('_csv')
        c.add_from_csv(val.tempfile, key.chomp('_csv'))
      end
    end

    # run seeds as optional, which prevents deactivation of rows
    # not included in .csvs
    c.run_seeds(true)

    Rails.cache.clear
    
    redirect_to :root
  end

  def commit_changes
    # TODO: dump current DB state
    c = CsvUpdater.new()

    # run seeds as mandatory, which deactivates any rows 
    # not included in .csvs
    c.run_seeds(false)

    # set has_signed_waiver, has_signed_hardhat_waiver, and waiver_start vals
    # of all participants to nil
    c.reset_waiver_signatures()

    # deactivates all rows of tables not included in csv uploads
    c.deactivate_unseeded_tables()

    # clear the cache, where all info about insertions/deletions was stored
    Rails.cache.clear
    
    redirect_to :root
  end

  def show_end_index
  end
end
