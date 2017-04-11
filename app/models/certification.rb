class Certification < ActiveRecord::Base
  belongs_to :certification_type
  belongs_to :participant
end
