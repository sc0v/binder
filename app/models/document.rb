# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`comments`**         | `text(65535)`      |
# **`created_at`**       | `datetime`         |
# **`document_id`**      | `integer`          |
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`public`**           | `boolean`          |
# **`updated_at`**       | `datetime`         |
# **`url`**              | `string(255)`      |
#


class Document < ActiveRecord::Base
  validates_associated :organization

  belongs_to :organization

  mount_uploader :url, DocumentUploader
  
  scope :search, lambda { |term| where('lower(name) LIKE lower(?)', "%#{term}%") }
end
