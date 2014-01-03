class DowntimeEntry < ActiveRecord::Base
  validates_presence_of :organization, :started_at
  validates_associated :organization

  belongs_to :organization
end

