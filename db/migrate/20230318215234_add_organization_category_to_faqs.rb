# frozen_string_literal: true
class AddOrganizationCategoryToFaqs < ActiveRecord::Migration[7.0]
  def change
    add_reference :faqs, :organization_category, null: true, foreign_key: true
  end
end
