class Charge < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :amount, :description, :issuing_participant, :receiving_participant, :organization, :charge_type, :charged_at
  validates :charged_at, :issuing_participant_id, :organization_id, :charge_type_id, :presence => true
  belongs_to :issuing_participant, :class_name => "Participant"
  belongs_to :receiving_participant, :class_name => "Participant"
  belongs_to :charge_type

  default_scope order('charged_at ASC')
end
