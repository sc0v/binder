# frozen_string_literal: true

class ChargeType < ApplicationRecord
  # attr_accessible :default_amount, :default_amount, :description, :name, :requires_booth_chair_approval

  validates :name, presence: true, uniqueness: true

  has_many :charges, dependent: :destroy

  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
