# frozen_string_literal: true

class OrganizationCategory < ApplicationRecord
  has_many :organizations, dependent: :destroy
  has_many :faq, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :collection_select, -> { all.order(:name) }
end
