class CarnivalCreationController < ApplicationController
  def show_uploader
  end

  def show_diff
  end

  def upload_csvs
    c = CsvUpdater.new()
    c.add_from_csv(params[:csv_file].tempfile, 'organization')
    redirect_to :show_diff
  end

  def commit_changes
    c = CsvUpdater.new()
    c.seed_organizations()
    redirect_to :show_end_index
  end

  def show_end_index
  end
end
