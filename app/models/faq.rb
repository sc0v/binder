class Faq < ActiveRecord::Base
  # attr_accessible :answer, :question
  scope :search, lambda { |term| where('lower(question) LIKE lower(?) OR lower(answer) LIKE lower(?)', "%#{term}%", "%#{term}%") }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

end
