# ## Schema Information
#
# Table name: `charges`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`amount`**                    | `decimal(8, 2)`    |
# **`charge_type_id`**            | `integer`          |
# **`charged_at`**                | `datetime`         |
# **`created_at`**                | `datetime`         |
# **`creating_participant_id`**   | `integer`          |
# **`description`**               | `text`             |
# **`id`**                        | `integer`          | `not null, primary key`
# **`is_approved`**               | `boolean`          |
# **`issuing_participant_id`**    | `integer`          |
# **`organization_id`**           | `integer`          |
# **`receiving_participant_id`**  | `integer`          |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_charges_on_organization_id`:
#     * **`organization_id`**
#

module ChargesHelper
end
