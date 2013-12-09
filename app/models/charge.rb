class Charge < ActiveRecord::Base
  validates_presence_of :charged_at, :issuing_participant, :organization, :charge_type, :amount
  validates_associated :issuing_participant, :organization, :charge_type, :receiving_participant
  validates :amount, :numericality => true

  belongs_to :organization
  belongs_to :charge_type
  belongs_to :issuing_participant, :class_name => "Participant"
  belongs_to :receiving_participant, :class_name => "Participant"
  
  default_scope { order('charged_at DESC') }
end

