# frozen_string_literal: true

class CertificationType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
