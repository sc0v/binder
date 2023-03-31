# frozen_string_literal: true
class AddInfoToParticiapants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :cached_name, :string
    add_column :participants, :cached_surname, :string
    add_column :participants, :cached_email, :string
    add_column :participants, :cached_department, :string
    add_column :participants, :cached_student_class, :string
    add_column :participants, :cache_updated, :datetime
  end
end
