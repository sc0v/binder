class Charge < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :amount, :amount, :description
  belongs_to :issuing_participant, :class_name => "Participant"
  belongs_to :receiving_participant, :class_name => "Participant"
  belongs_to :charge_type
end
