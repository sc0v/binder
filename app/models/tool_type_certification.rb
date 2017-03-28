# ## Schema Information
#
# Table name: `tool_type_certifications`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`certification_type_id`**  | `integer`          |
# **`created_at`**             | `datetime`         | `not null`
# **`id`**                     | `integer`          | `not null, primary key`
# **`tool_type_id`**           | `integer`          |
# **`updated_at`**             | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_tool_type_certifications_on_certification_type_id`:
#     * **`certification_type_id`**
# * `index_tool_type_certifications_on_tool_type_id`:
#     * **`tool_type_id`**
#

class ToolTypeCertification < ActiveRecord::Base
  belongs_to :tool_type
  belongs_to :certification_type
end
