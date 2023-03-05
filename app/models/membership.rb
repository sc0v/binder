class Membership < ActiveRecord::Base
  validates_presence_of :participant, :organization
  validates_associated :participant, :organization
  validates_uniqueness_of :participant_id, :scope => :organization_id

  belongs_to :organization
  belongs_to :participant

  scope :booth_chairs, -> { where(:is_booth_chair => true).order('booth_chair_order ASC') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def organization_name_formatted
    if is_booth_chair?
      organization.name + " - Booth Chair"
    else
      organization.name
    end
  end
  
end
