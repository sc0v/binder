# frozen_string_literal: true

class FAQ < ApplicationRecord
  belongs_to :organization_category, optional: true

  validates :answer, presence: true
  validates :question,
            presence: true,
            uniqueness: {
              scope: :organization_category,
              case_sensitive: false
            }

  scope :search,
        ->(term) {
          where(
            'lower(question) LIKE :term OR lower(answer) LIKE :term',
            { term: "%#{term}%".downcase }
          )
        }
end
