# ## Schema Information
#
# Table name: `participants`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`andrewid`**                   | `string`           |
# **`cache_updated`**              | `datetime`         |
# **`cached_department`**          | `string`           |
# **`cached_email`**               | `string`           |
# **`cached_name`**                | `string`           |
# **`cached_student_class`**       | `string`           |
# **`cached_surname`**             | `string`           |
# **`created_at`**                 | `datetime`         |
# **`has_signed_hardhat_waiver`**  | `boolean`          |
# **`has_signed_waiver`**          | `boolean`          |
# **`id`**                         | `integer`          | `not null, primary key`
# **`phone_carrier_id`**           | `integer`          |
# **`phone_number`**               | `string`           |
# **`updated_at`**                 | `datetime`         |
# **`user_id`**                    | `integer`          |
# **`waiver_start`**               | `datetime`         |
#
# ### Indexes
#
# * `index_participants_on_phone_carrier_id`:
#     * **`phone_carrier_id`**
#

module ParticipantsHelper
end
