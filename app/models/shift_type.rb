# frozen_string_literal: true

class ShiftType < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :shifts, dependent: :destroy

  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
