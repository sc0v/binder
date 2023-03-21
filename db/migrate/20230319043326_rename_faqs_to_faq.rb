# frozen_string_literal: true

class RenameFaqsToFAQ < ActiveRecord::Migration[7.0]
  def change
    rename_table :faqs, :faq
  end
end
