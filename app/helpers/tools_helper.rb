# ## Schema Information
#
# Table name: `tools`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`barcode`**       | `integer`          |
# **`created_at`**    | `datetime`         |
# **`description`**   | `text(65535)`      |
# **`id`**            | `integer`          | `not null, primary key`
# **`tool_type_id`**  | `integer`          |
# **`updated_at`**    | `datetime`         |
#
# ### Indexes
#
# * `index_tools_on_barcode`:
#     * **`barcode`**
# * `index_tools_on_tool_type_id`:
#     * **`tool_type_id`**
#

module ToolsHelper
end
