class Certification < ActiveRecord::Base
  belongs_to :certification_type
  belongs_to :participant
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
